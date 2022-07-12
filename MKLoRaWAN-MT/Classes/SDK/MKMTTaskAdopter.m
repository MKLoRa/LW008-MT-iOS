//
//  MKMTTaskAdopter.m
//  MKLoRaWAN-MT_Example
//
//  Created by aa on 2022/6/9.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKMTTaskAdopter.h"

#import <CoreBluetooth/CoreBluetooth.h>

#import "MKBLEBaseSDKAdopter.h"
#import "MKBLEBaseSDKDefines.h"

#import "MKMTOperationID.h"
#import "MKMTSDKDataAdopter.h"

NSString *const mk_mt_totalNumKey = @"mk_mt_totalNumKey";
NSString *const mk_mt_totalIndexKey = @"mk_mt_totalIndexKey";
NSString *const mk_mt_contentKey = @"mk_mt_contentKey";

@implementation MKMTTaskAdopter

+ (NSDictionary *)parseReadDataWithCharacteristic:(CBCharacteristic *)characteristic {
    NSData *readData = characteristic.value;
    NSLog(@"+++++%@-----%@",characteristic.UUID.UUIDString,readData);
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A24"]]) {
        //产品型号
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"modeID":tempString} operationID:mk_mt_taskReadDeviceModelOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A26"]]) {
        //firmware
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"firmware":tempString} operationID:mk_mt_taskReadFirmwareOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A27"]]) {
        //hardware
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"hardware":tempString} operationID:mk_mt_taskReadHardwareOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A28"]]) {
        //soft ware
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"software":tempString} operationID:mk_mt_taskReadSoftwareOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A29"]]) {
        //manufacturerKey
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"manufacturer":tempString} operationID:mk_mt_taskReadManufacturerOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
        //密码相关
        NSString *content = [MKBLEBaseSDKAdopter hexStringFromData:readData];
        NSString *state = @"";
        if (content.length == 10) {
            state = [content substringWithRange:NSMakeRange(8, 2)];
        }
        return [self dataParserGetDataSuccess:@{@"state":state} operationID:mk_mt_connectPasswordOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA02"]]) {
        return [self parseCustomData:readData];
    }
    return @{};
}

+ (NSDictionary *)parseWriteDataWithCharacteristic:(CBCharacteristic *)characteristic {
    return @{};
}

#pragma mark - 数据解析
+ (NSDictionary *)parseCustomData:(NSData *)readData {
    NSString *readString = [MKBLEBaseSDKAdopter hexStringFromData:readData];
    NSString *headerString = [readString substringWithRange:NSMakeRange(0, 2)];
    if ([headerString isEqualToString:@"ee"]) {
        //分包协议
        return [self parsePacketData:readData];
    }
    if (![headerString isEqualToString:@"ed"]) {
        return @{};
    }
    NSInteger dataLen = [MKBLEBaseSDKAdopter getDecimalWithHex:readString range:NSMakeRange(6, 2)];
    if (readData.length != dataLen + 4) {
        return @{};
    }
    NSString *flag = [readString substringWithRange:NSMakeRange(2, 2)];
    NSString *cmd = [readString substringWithRange:NSMakeRange(4, 2)];
    NSString *content = [readString substringWithRange:NSMakeRange(8, dataLen * 2)];
    //不分包协议
    if ([flag isEqualToString:@"00"]) {
        //读取
        return [self parseCustomReadData:content cmd:cmd data:readData];
    }
    if ([flag isEqualToString:@"01"]) {
        return [self parseCustomConfigData:content cmd:cmd];
    }
    return @{};
}

+ (NSDictionary *)parsePacketData:(NSData *)readData {
    NSString *readString = [MKBLEBaseSDKAdopter hexStringFromData:readData];
    NSString *flag = [readString substringWithRange:NSMakeRange(2, 2)];
    NSString *cmd = [readString substringWithRange:NSMakeRange(4, 2)];
    if ([flag isEqualToString:@"00"]) {
        //读取
        NSString *totalNum = [MKBLEBaseSDKAdopter getDecimalStringWithHex:readString range:NSMakeRange(6, 2)];
        NSString *index = [MKBLEBaseSDKAdopter getDecimalStringWithHex:readString range:NSMakeRange(8, 2)];
        NSInteger len = [MKBLEBaseSDKAdopter getDecimalWithHex:readString range:NSMakeRange(10, 2)];
        if ([index integerValue] >= [totalNum integerValue]) {
            return @{};
        }
        mk_mt_taskOperationID operationID = mk_mt_defaultTaskOperationID;
        
        NSData *subData = [readData subdataWithRange:NSMakeRange(6, len)];
        NSDictionary *resultDic= @{
            mk_mt_totalNumKey:totalNum,
            mk_mt_totalIndexKey:index,
            mk_mt_contentKey:(subData ? subData : [NSData data]),
        };
        if ([cmd isEqualToString:@"5d"]) {
            //读取Adv Name过滤规则
            operationID = mk_mt_taskReadFilterAdvNameListOperation;
        }else if ([cmd isEqualToString:@"6f"]) {
            //读取URL类型过滤内容
            operationID = mk_mt_taskReadFilterByURLContentOperation;
        }
        return [self dataParserGetDataSuccess:resultDic operationID:operationID];
    }
    if ([flag isEqualToString:@"01"]) {
        //配置
        mk_mt_taskOperationID operationID = mk_mt_defaultTaskOperationID;
        NSString *content = [readString substringWithRange:NSMakeRange(8, 2)];
        BOOL success = [content isEqualToString:@"01"];
        
        if ([cmd isEqualToString:@"5d"]) {
            //配置Adv Name过滤规则
            operationID = mk_mt_taskConfigFilterAdvNameListOperation;
        }else if ([cmd isEqualToString:@"6f"]) {
            //配置URL类型过滤的内容
            operationID = mk_mt_taskConfigFilterByURLContentOperation;
        }
        return [self dataParserGetDataSuccess:@{@"success":@(success)} operationID:operationID];
    }
    return @{};
}

+ (NSDictionary *)parseCustomReadData:(NSString *)content cmd:(NSString *)cmd data:(NSData *)data {
    mk_mt_taskOperationID operationID = mk_mt_defaultTaskOperationID;
    NSDictionary *resultDic = @{};
    
    if ([cmd isEqualToString:@"01"]) {
        
    }else if ([cmd isEqualToString:@"14"]) {
        //读取时区
        resultDic = @{
            @"timeZone":[MKBLEBaseSDKAdopter signedHexTurnString:content],
        };
        operationID = mk_mt_taskReadTimeZoneOperation;
    }else if ([cmd isEqualToString:@"15"]) {
        //读取工作模式
        NSInteger mode = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"mode":[NSString stringWithFormat:@"%ld",(mode - 1)],
        };
        operationID = mk_mt_taskReadWorkModeOperation;
    }else if ([cmd isEqualToString:@"16"]) {
        //读取指示灯功能
        NSDictionary *indicatorSettings = [MKMTSDKDataAdopter fetchIndicatorSettings:content];
        resultDic = @{
            @"indicatorSettings":indicatorSettings,
        };
        operationID = mk_mt_taskReadIndicatorSettingsOperation;
    }else if ([cmd isEqualToString:@"17"]) {
        //读取设备心跳间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mt_taskReadHeartbeatIntervalOperation;
    }else if ([cmd isEqualToString:@"19"]) {
        //读取关机信息上报
        BOOL isOn = [content isEqualToString:@"01"];
        resultDic = @{
            @"isOn":@(isOn),
        };
        operationID = mk_mt_taskReadShutdownPayloadStatusOperation;
    }else if ([cmd isEqualToString:@"1a"]) {
        //读取离线定位功能开关状态
        BOOL isOn = [content isEqualToString:@"01"];
        resultDic = @{
            @"isOn":@(isOn),
        };
        operationID = mk_mt_taskReadOfflineFixStatusOperation;
    }else if ([cmd isEqualToString:@"1b"]) {
        //读取低电触发心跳开关状态
        BOOL isOn = [content isEqualToString:@"01"];
        resultDic = @{
            @"isOn":@(isOn),
        };
        operationID = mk_mt_taskReadLowPowerPayloadStatusOperation;
    }else if ([cmd isEqualToString:@"1c"]) {
        //读取低电百分比
        resultDic = @{
            @"prompt":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mt_taskReadLowPowerPromptOperation;
    }else if ([cmd isEqualToString:@"20"]) {
        //读取电池电压
        resultDic = @{
            @"voltage":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mt_taskReadBatteryVoltageOperation;
    }else if ([cmd isEqualToString:@"21"]) {
        //读取MAC地址
        NSString *macAddress = [NSString stringWithFormat:@"%@:%@:%@:%@:%@:%@",[content substringWithRange:NSMakeRange(0, 2)],[content substringWithRange:NSMakeRange(2, 2)],[content substringWithRange:NSMakeRange(4, 2)],[content substringWithRange:NSMakeRange(6, 2)],[content substringWithRange:NSMakeRange(8, 2)],[content substringWithRange:NSMakeRange(10, 2)]];
        resultDic = @{@"macAddress":[macAddress uppercaseString]};
        operationID = mk_mt_taskReadMacAddressOperation;
    }else if ([cmd isEqualToString:@"22"]) {
        //读取产测状态
        NSString *status = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"status":status,
        };
        operationID = mk_mt_taskReadPCBAStatusOperation;
    }else if ([cmd isEqualToString:@"23"]) {
        //读取自检故障原因
//        NSString *status = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"status":content,
        };
        operationID = mk_mt_taskReadSelftestStatusOperation;
    }else if ([cmd isEqualToString:@"30"]) {
        //读取密码开关
        BOOL need = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"need":@(need)
        };
        operationID = mk_mt_taskReadConnectationNeedPasswordOperation;
    }else if ([cmd isEqualToString:@"31"]) {
        //读取密码
        NSData *passwordData = [data subdataWithRange:NSMakeRange(4, data.length - 4)];
        NSString *password = [[NSString alloc] initWithData:passwordData encoding:NSUTF8StringEncoding];
        resultDic = @{
            @"password":(MKValidStr(password) ? password : @""),
        };
        operationID = mk_mt_taskReadPasswordOperation;
    }else if ([cmd isEqualToString:@"32"]) {
        //读取广播超时时长
        resultDic = @{
            @"timeout":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mt_taskReadBroadcastTimeoutOperation;
    }else if ([cmd isEqualToString:@"33"]) {
        //读取设备Tx Power
        NSString *txPower = [MKMTSDKDataAdopter fetchTxPowerValueString:content];
        resultDic = @{@"txPower":txPower};
        operationID = mk_mt_taskReadTxPowerOperation;
    }else if ([cmd isEqualToString:@"34"]) {
        //读取设备广播名称
        NSData *nameData = [data subdataWithRange:NSMakeRange(4, data.length - 4)];
        NSString *deviceName = [[NSString alloc] initWithData:nameData encoding:NSUTF8StringEncoding];
        resultDic = @{
            @"deviceName":(MKValidStr(deviceName) ? deviceName : @""),
        };
        operationID = mk_mt_taskReadDeviceNameOperation;
    }else if ([cmd isEqualToString:@"40"]) {
        //读取定期模式定位策略
        NSString *strategy = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"strategy":strategy,
        };
        operationID = mk_mt_taskReadPeriodicModePositioningStrategyOperation;
    }else if ([cmd isEqualToString:@"41"]) {
        //读取定期模式上报间隔
        NSString *interval = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"interval":interval,
        };
        operationID = mk_mt_taskReadPeriodicModeReportIntervalOperation;
    }else if ([cmd isEqualToString:@"42"]) {
        //读取定时模式定位策略
        NSString *strategy = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"strategy":strategy,
        };
        operationID = mk_mt_taskReadTimingModePositioningStrategyOperation;
    }else if ([cmd isEqualToString:@"43"]) {
        //读取定时模式时间点
        NSArray *list = [MKMTSDKDataAdopter parseTimingModeReportingTimePoint:content];
        
        resultDic = @{
            @"pointList":list,
        };
        operationID = mk_mt_taskReadTimingModeReportingTimePointOperation;
    }else if ([cmd isEqualToString:@"44"]) {
        //读取运动模式事件
        NSString *binaryHex = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(0, content.length)]];
        
        BOOL notifyEventOnStart = [[binaryHex substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL fixOnStart = [[binaryHex substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        BOOL notifyEventInTrip = [[binaryHex substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
        BOOL fixInTrip = [[binaryHex substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"];
        BOOL notifyEventOnEnd = [[binaryHex substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"];
        BOOL fixOnEnd = [[binaryHex substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"];
        resultDic = @{
            @"notifyEventOnStart":@(notifyEventOnStart),
            @"fixOnStart":@(fixOnStart),
            @"notifyEventInTrip":@(notifyEventInTrip),
            @"fixInTrip":@(fixInTrip),
            @"notifyEventOnEnd":@(notifyEventOnEnd),
            @"fixOnEnd":@(fixOnEnd)
        };
        operationID = mk_mt_taskReadMotionModeEventsOperation;
    }else if ([cmd isEqualToString:@"45"]) {
        //读取运动开始定位上报次数
        NSString *number = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"number":number,
        };
        operationID = mk_mt_taskReadMotionModeNumberOfFixOnStartOperation;
    }else if ([cmd isEqualToString:@"46"]) {
        //读取运动开始定位策略
        NSString *strategy = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"strategy":strategy,
        };
        operationID = mk_mt_taskReadMotionModePosStrategyOnStartOperation;
    }else if ([cmd isEqualToString:@"47"]) {
        //读取运动中定位间隔
        NSString *interval = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"interval":interval,
        };
        operationID = mk_mt_taskReadMotionModeReportIntervalInTripOperation;
    }else if ([cmd isEqualToString:@"48"]) {
        //读取运动中定位策略
        NSString *strategy = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"strategy":strategy,
        };
        operationID = mk_mt_taskReadMotionModePosStrategyInTripOperation;
    }else if ([cmd isEqualToString:@"49"]) {
        //读取运动结束判断时间
        NSString *time = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"time":time,
        };
        operationID = mk_mt_taskReadMotionModeTripEndTimeoutOperation;
    }else if ([cmd isEqualToString:@"4a"]) {
        //读取运动结束判断时间
        NSString *number = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"number":number,
        };
        operationID = mk_mt_taskReadMotionModeNumberOfFixOnEndOperation;
    }else if ([cmd isEqualToString:@"4b"]) {
        //读取运动结束定位间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mt_taskReadMotionModeReportIntervalOnEndOperation;
    }else if ([cmd isEqualToString:@"4c"]) {
        //读取运动结束定位策略
        NSString *strategy = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"strategy":strategy,
        };
        operationID = mk_mt_taskReadMotionModePosStrategyOnEndOperation;
    }else if ([cmd isEqualToString:@"50"]) {
        //读取WIFI定位数据格式
        resultDic = @{
            @"dataType":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mt_taskReadWifiDataTypeOperation;
    }else if ([cmd isEqualToString:@"51"]) {
        //读取WIFI定位超时时间
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mt_taskReadWifiPositioningTimeoutOperation;
    }else if ([cmd isEqualToString:@"52"]) {
        //读取WIFI定位成功BSSID数量
        resultDic = @{
            @"number":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mt_taskReadWifiNumberOfBSSIDOperation;
    }else if ([cmd isEqualToString:@"53"]) {
        //读取蓝牙定位超时时间
        resultDic = @{
            @"timeout":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mt_taskReadBlePositioningTimeoutOperation;
    }else if ([cmd isEqualToString:@"54"]) {
        //读取蓝牙定位MAC数量
        resultDic = @{
            @"number":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mt_taskReadBlePositioningNumberOfMacOperation;
    }else if ([cmd isEqualToString:@"55"]) {
        //读取RSSI过滤规则
        resultDic = @{
            @"rssi":[NSString stringWithFormat:@"%ld",(long)[[MKBLEBaseSDKAdopter signedHexTurnString:content] integerValue]],
        };
        operationID = mk_mt_taskReadRssiFilterValueOperation;
    }else if ([cmd isEqualToString:@"56"]) {
        //读取蓝牙扫描phy选择
        NSInteger value = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(0, content.length)];
        NSString *phyType = @"0";
        if (value == 1) {
            phyType = @"1";
        }else if (value == 2) {
            phyType = @"3";
        }else if (value == 3) {
            phyType = @"2";
        }
        resultDic = @{@"phyType":phyType};
        operationID = mk_mt_taskReadScanningPHYTypeOperation;
    }else if ([cmd isEqualToString:@"57"]) {
        //读取广播内容过滤逻辑
        resultDic = @{
            @"relationship":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mt_taskReadFilterRelationshipOperation;
    }else if ([cmd isEqualToString:@"58"]) {
        //读取精准过滤MAC开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_mt_taskReadFilterByMacPreciseMatchOperation;
    }else if ([cmd isEqualToString:@"59"]) {
        //读取反向过滤MAC开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_mt_taskReadFilterByMacReverseFilterOperation;
    }else if ([cmd isEqualToString:@"5a"]) {
        //读取MAC过滤列表
        NSArray *macList = [MKMTSDKDataAdopter parseFilterMacList:content];
        resultDic = @{
            @"macList":(MKValidArray(macList) ? macList : @[]),
        };
        operationID = mk_mt_taskReadFilterMACAddressListOperation;
    }else if ([cmd isEqualToString:@"5b"]) {
        //读取精准过滤Adv Name开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_mt_taskReadFilterByAdvNamePreciseMatchOperation;
    }else if ([cmd isEqualToString:@"5c"]) {
        //读取反向过滤Adv Name开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_mt_taskReadFilterByAdvNameReverseFilterOperation;
    }else if ([cmd isEqualToString:@"5e"]) {
        //读取过滤设备类型开关
        BOOL unknown = ([[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"]);
        BOOL iBeacon = ([[content substringWithRange:NSMakeRange(2, 2)] isEqualToString:@"01"]);
        BOOL uid = ([[content substringWithRange:NSMakeRange(4, 2)] isEqualToString:@"01"]);
        BOOL url = ([[content substringWithRange:NSMakeRange(6, 2)] isEqualToString:@"01"]);
        BOOL tlm = ([[content substringWithRange:NSMakeRange(8, 2)] isEqualToString:@"01"]);
        BOOL bxp_acc = ([[content substringWithRange:NSMakeRange(10, 2)] isEqualToString:@"01"]);
        BOOL bxp_th = ([[content substringWithRange:NSMakeRange(12, 2)] isEqualToString:@"01"]);
        BOOL mk_iBeacon = ([[content substringWithRange:NSMakeRange(14, 2)] isEqualToString:@"01"]);
        BOOL mk_iBeacon_acc = ([[content substringWithRange:NSMakeRange(16, 2)] isEqualToString:@"01"]);

        resultDic = @{
            @"unknown":@(unknown),
            @"iBeacon":@(iBeacon),
            @"uid":@(uid),
            @"url":@(url),
            @"tlm":@(tlm),
            @"bxp_acc":@(bxp_acc),
            @"bxp_th":@(bxp_th),
            @"mk_iBeacon":@(mk_iBeacon),
            @"mk_iBeacon_acc":@(mk_iBeacon_acc)
        };
        operationID = mk_mt_taskReadFilterTypeStatusOperation;
    }else if ([cmd isEqualToString:@"5f"]) {
        //读取iBeacon类型过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_mt_taskReadFilterByBeaconStatusOperation;
    }else if ([cmd isEqualToString:@"60"]) {
        //读取iBeacon类型过滤的Major范围
        BOOL isOn = ([[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"]);
        NSString *minValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 4)];
        NSString *maxValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(6, 4)];
        resultDic = @{
            @"isOn":@(isOn),
            @"maxValue":maxValue,
            @"minValue":minValue,
        };
        operationID = mk_mt_taskReadFilterByBeaconMajorRangeOperation;
    }else if ([cmd isEqualToString:@"61"]) {
        //读取iBeacon类型过滤的Minor范围
        BOOL isOn = ([[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"]);
        NSString *minValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 4)];
        NSString *maxValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(6, 4)];
        resultDic = @{
            @"isOn":@(isOn),
            @"maxValue":maxValue,
            @"minValue":minValue,
        };
        operationID = mk_mt_taskReadFilterByBeaconMinorRangeOperation;
    }else if ([cmd isEqualToString:@"62"]) {
        //读取iBeacon类型过滤的UUID
        resultDic = @{
            @"uuid":content,
        };
        operationID = mk_mt_taskReadFilterByBeaconUUIDOperation;
    }else if ([cmd isEqualToString:@"63"]) {
        //读取MKiBeacon类型过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_mt_taskReadFilterByMKBeaconStatusOperation;
    }else if ([cmd isEqualToString:@"64"]) {
        //读取MKiBeacon类型过滤的Major范围
        BOOL isOn = ([[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"]);
        NSString *minValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 4)];
        NSString *maxValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(6, 4)];
        resultDic = @{
            @"isOn":@(isOn),
            @"maxValue":maxValue,
            @"minValue":minValue,
        };
        operationID = mk_mt_taskReadFilterByMKBeaconMajorRangeOperation;
    }else if ([cmd isEqualToString:@"65"]) {
        //读取iBeacon类型过滤的Minor范围
        BOOL isOn = ([[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"]);
        NSString *minValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 4)];
        NSString *maxValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(6, 4)];
        resultDic = @{
            @"isOn":@(isOn),
            @"maxValue":maxValue,
            @"minValue":minValue,
        };
        operationID = mk_mt_taskReadFilterByMKBeaconMinorRangeOperation;
    }else if ([cmd isEqualToString:@"66"]) {
        //读取iBeacon类型过滤的UUID
        resultDic = @{
            @"uuid":content,
        };
        operationID = mk_mt_taskReadFilterByMKBeaconUUIDOperation;
    }else if ([cmd isEqualToString:@"67"]) {
        //读取MKiBeacon&ACC类型过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_mt_taskReadFilterByMKBeaconAccStatusOperation;
    }else if ([cmd isEqualToString:@"68"]) {
        //读取MKiBeacon&ACC类型过滤的Major范围
        BOOL isOn = ([[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"]);
        NSString *minValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 4)];
        NSString *maxValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(6, 4)];
        resultDic = @{
            @"isOn":@(isOn),
            @"maxValue":maxValue,
            @"minValue":minValue,
        };
        operationID = mk_mt_taskReadFilterByMKBeaconAccMajorRangeOperation;
    }else if ([cmd isEqualToString:@"69"]) {
        //读取MKiBeacon&ACC类型过滤的Minor范围
        BOOL isOn = ([[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"]);
        NSString *minValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 4)];
        NSString *maxValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(6, 4)];
        resultDic = @{
            @"isOn":@(isOn),
            @"maxValue":maxValue,
            @"minValue":minValue,
        };
        operationID = mk_mt_taskReadFilterByMKBeaconAccMinorRangeOperation;
    }else if ([cmd isEqualToString:@"6a"]) {
        //读取MKiBeacon&ACC类型过滤的UUID
        resultDic = @{
            @"uuid":content,
        };
        operationID = mk_mt_taskReadFilterByMKBeaconAccUUIDOperation;
    }else if ([cmd isEqualToString:@"6b"]) {
        //读取UID类型过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_mt_taskReadFilterByUIDStatusOperation;
    }else if ([cmd isEqualToString:@"6c"]) {
        //读取UID类型过滤的Namespace ID
        resultDic = @{
            @"namespaceID":content,
        };
        operationID = mk_mt_taskReadFilterByUIDNamespaceIDOperation;
    }else if ([cmd isEqualToString:@"6d"]) {
        //读取UID类型过滤的Instance ID
        resultDic = @{
            @"instanceID":content,
        };
        operationID = mk_mt_taskReadFilterByUIDInstanceIDOperation;
    }else if ([cmd isEqualToString:@"6e"]) {
        //读取URL类型过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_mt_taskReadFilterByURLStatusOperation;
    }else if ([cmd isEqualToString:@"70"]) {
        //读取TLM类型过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_mt_taskReadFilterByTLMStatusOperation;
    }else if ([cmd isEqualToString:@"71"]) {
        //读取TLM过滤数据类型
        NSString *version = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"version":version
        };
        operationID = mk_mt_taskReadFilterByTLMVersionOperation;
    }else if ([cmd isEqualToString:@"72"]) {
        //读取BeaconX Pro-ACC设备过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_mt_taskReadBXPAccFilterStatusOperation;
    }else if ([cmd isEqualToString:@"73"]) {
        //读取BeaconX Pro-T&H设备过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_mt_taskReadBXPTHFilterStatusOperation;
    }else if ([cmd isEqualToString:@"74"]) {
        //读取Other过滤条件开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_mt_taskReadFilterByOtherStatusOperation;
    }else if ([cmd isEqualToString:@"75"]) {
        //读取Other过滤条件的逻辑关系
        NSString *relationship = [MKMTSDKDataAdopter parseOtherRelationship:content];
        resultDic = @{
            @"relationship":relationship,
        };
        operationID = mk_mt_taskReadFilterByOtherRelationshipOperation;
    }else if ([cmd isEqualToString:@"76"]) {
        //读取Other的过滤条件列表
        NSArray *conditionList = [MKMTSDKDataAdopter parseOtherFilterConditionList:content];
        resultDic = @{
            @"conditionList":conditionList,
        };
        operationID = mk_mt_taskReadFilterByOtherConditionsOperation;
    }else if ([cmd isEqualToString:@"7a"]) {
        //读取GPS定位超时时间(LR1110)
        resultDic = @{
            @"timeout":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mt_taskReadLRPositioningTimeoutOperation;
    }else if ([cmd isEqualToString:@"7b"]) {
        //读取GPS定位超时时间(LR1110)
        resultDic = @{
            @"number":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mt_taskReadLRStatelliteThresholdOperation;
    }else if ([cmd isEqualToString:@"7c"]) {
        //读取GPS定位数据格式(LR1110)
        resultDic = @{
            @"dataType":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mt_taskReadLRGPSDataTypeOperation;
    }else if ([cmd isEqualToString:@"7d"]) {
        //读取定位系统(LR1110)
        resultDic = @{
            @"type":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mt_taskReadLRPositioningSystemOperation;
    }else if ([cmd isEqualToString:@"7e"]) {
        //读取定位方式选择(LR1110)
        BOOL isOn = ([content isEqualToString:@"00"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_mt_taskReadLRAutonomousAidingOperation;
    }else if ([cmd isEqualToString:@"7f"]) {
        //读取定位方式选择(LR1110)
        NSNumber *latitude = [MKBLEBaseSDKAdopter signedHexTurnString:[content substringWithRange:NSMakeRange(0, 8)]];
        NSNumber *longitude = [MKBLEBaseSDKAdopter signedHexTurnString:[content substringWithRange:NSMakeRange(8, 8)]];
        resultDic = @{
            @"latitude":[NSString stringWithFormat:@"%@",latitude],
            @"longitude":[NSString stringWithFormat:@"%@",longitude]
        };
        operationID = mk_mt_taskReadLRLatitudeLongitudeOperation;
    }else if ([cmd isEqualToString:@"80"]) {
        //读取星历开始更新事件开关(LR1110)
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_mt_taskReadLRNotifyOnEphemerisStartStatusOperation;
    }else if ([cmd isEqualToString:@"81"]) {
        //读取星历结束更新事件开关(LR1110)
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_mt_taskReadLRNotifyOnEphemerisEndStatusOperation;
    }else if ([cmd isEqualToString:@"90"]) {
        //读取LoRaWAN网络状态
        resultDic = @{
            @"status":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mt_taskReadLorawanNetworkStatusOperation;
    }else if ([cmd isEqualToString:@"91"]) {
        //读取LoRaWAN频段
        resultDic = @{
            @"region":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mt_taskReadLorawanRegionOperation;
    }else if ([cmd isEqualToString:@"92"]) {
        //读取LoRaWAN入网类型
        resultDic = @{
            @"modem":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mt_taskReadLorawanModemOperation;
    }else if ([cmd isEqualToString:@"93"]) {
        //读取LoRaWAN DEVEUI
        resultDic = @{
            @"devEUI":content,
        };
        operationID = mk_mt_taskReadLorawanDEVEUIOperation;
    }else if ([cmd isEqualToString:@"94"]) {
        //读取LoRaWAN APPEUI
        resultDic = @{
            @"appEUI":content
        };
        operationID = mk_mt_taskReadLorawanAPPEUIOperation;
    }else if ([cmd isEqualToString:@"95"]) {
        //读取LoRaWAN APPKEY
        resultDic = @{
            @"appKey":content
        };
        operationID = mk_mt_taskReadLorawanAPPKEYOperation;
    }else if ([cmd isEqualToString:@"96"]) {
        //读取LoRaWAN DEVADDR
        resultDic = @{
            @"devAddr":content
        };
        operationID = mk_mt_taskReadLorawanDEVADDROperation;
    }else if ([cmd isEqualToString:@"97"]) {
        //读取LoRaWAN APPSKEY
        resultDic = @{
            @"appSkey":content
        };
        operationID = mk_mt_taskReadLorawanAPPSKEYOperation;
    }else if ([cmd isEqualToString:@"98"]) {
        //读取LoRaWAN nwkSkey
        resultDic = @{
            @"nwkSkey":content
        };
        operationID = mk_mt_taskReadLorawanNWKSKEYOperation;
    }else if ([cmd isEqualToString:@"99"]) {
        //读取LoRaWAN 上行数据类型
        resultDic = @{
            @"messageType":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mt_taskReadLorawanMessageTypeOperation;
    }else if ([cmd isEqualToString:@"9a"]) {
        //读取LoRaWAN CH
        resultDic = @{
            @"CHL":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)],
            @"CHH":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)]
        };
        operationID = mk_mt_taskReadLorawanCHOperation;
    }else if ([cmd isEqualToString:@"9b"]) {
        //读取LoRaWAN DR
        resultDic = @{
            @"DR":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mt_taskReadLorawanDROperation;
    }else if ([cmd isEqualToString:@"9c"]) {
        //读取LoRaWAN 数据发送策略
        BOOL isOn = ([[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"]);
        NSString *transmissions = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)];
        NSString *DRL = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(4, 2)];
        NSString *DRH = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(6, 2)];
        resultDic = @{
            @"isOn":@(isOn),
            @"transmissions":transmissions,
            @"DRL":DRL,
            @"DRH":DRH,
        };
        operationID = mk_mt_taskReadLorawanUplinkStrategyOperation;
    }else if ([cmd isEqualToString:@"9d"]) {
        //读取LoRaWAN duty cycle
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_mt_taskReadLorawanDutyCycleStatusOperation;
    }else if ([cmd isEqualToString:@"9e"]) {
        //读取LoRaWAN devtime指令同步间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mt_taskReadLorawanDevTimeSyncIntervalOperation;
    }else if ([cmd isEqualToString:@"9f"]) {
        //读取LoRaWAN LinkCheckReq指令间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mt_taskReadLorawanNetworkCheckIntervalOperation;
    }else if ([cmd isEqualToString:@"a0"]) {
        //读取ADR_ACK_LIMIT
        resultDic = @{
            @"value":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mt_taskReadLorawanADRACKLimitOperation;
    }else if ([cmd isEqualToString:@"a1"]) {
        //读取ADR_ACK_DELAY
        resultDic = @{
            @"value":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mt_taskReadLorawanADRACKDelayOperation;
    }else if ([cmd isEqualToString:@"a2"]) {
        //读取LoRaWAN 重传次数
        resultDic = @{
            @"number":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mt_taskReadLorawanMaxRetransmissionTimesOperation;
    }else if ([cmd isEqualToString:@"b0"]) {
        //读取下行请求定位策略
        NSString *strategy = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"strategy":strategy,
        };
        operationID = mk_mt_taskReadDownlinkPositioningStrategyOperation;
    }else if ([cmd isEqualToString:@"b1"]) {
        //读取三轴唤醒条件
        NSString *threshold = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)];
        NSString *duration = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)];
        resultDic = @{
            @"threshold":threshold,
            @"duration":duration,
        };
        operationID = mk_mt_taskReadThreeAxisWakeupConditionsOperation;
    }else if ([cmd isEqualToString:@"b2"]) {
        //读取运动检测判断
        NSString *threshold = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)];
        NSString *duration = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)];
        resultDic = @{
            @"threshold":threshold,
            @"duration":duration,
        };
        operationID = mk_mt_taskReadThreeAxisMotionParametersOperation;
    }else if ([cmd isEqualToString:@"b3"]) {
        //读取震动检测开关状态
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_mt_taskReadShockDetectionStatusOperation;
    }else if ([cmd isEqualToString:@"b4"]) {
        //读取震动检测阈值
        NSString *threshold = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"threshold":threshold,
        };
        operationID = mk_mt_taskReadShockThresholdsOperation;
    }else if ([cmd isEqualToString:@"b5"]) {
        //读取震动上发间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mt_taskReadShockDetectionReportIntervalOperation;
    }else if ([cmd isEqualToString:@"b6"]) {
        //读取震动次数判断间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mt_taskReadShockTimeoutOperation;
    }else if ([cmd isEqualToString:@"b7"]) {
        //读取闲置功能使能
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_mt_taskReadManDownDetectionOperation;
    }else if ([cmd isEqualToString:@"b8"]) {
        //读取闲置超时时间
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mt_taskReadIdleDetectionTimeoutOperation;
    }else if ([cmd isEqualToString:@"ba"]) {
        //读取活动记录使能
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_mt_taskReadActiveStateCountStatusOperation;
    }else if ([cmd isEqualToString:@"bb"]) {
        //读取活动判定间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mt_taskReadActiveStateTimeoutOperation;
    }
    
    return [self dataParserGetDataSuccess:resultDic operationID:operationID];
}

+ (NSDictionary *)parseCustomConfigData:(NSString *)content cmd:(NSString *)cmd {
    mk_mt_taskOperationID operationID = mk_mt_defaultTaskOperationID;
    BOOL success = [content isEqualToString:@"01"];
    
    if ([cmd isEqualToString:@"01"]) {
        //
    }else if ([cmd isEqualToString:@"10"]) {
        //关机
        operationID = mk_mt_taskPowerOffOperation;
    }else if ([cmd isEqualToString:@"11"]) {
        //配置LoRaWAN 入网
        operationID = mk_mt_taskRestartDeviceOperation;
    }else if ([cmd isEqualToString:@"12"]) {
        //恢复出厂设置
        operationID = mk_mt_taskFactoryResetOperation;
    }else if ([cmd isEqualToString:@"13"]) {
        //配置时间戳
        operationID = mk_mt_taskConfigDeviceTimeOperation;
    }else if ([cmd isEqualToString:@"14"]) {
        //配置时区
        operationID = mk_mt_taskConfigTimeZoneOperation;
    }else if ([cmd isEqualToString:@"15"]) {
        //配置工作模式
        operationID = mk_mt_taskConfigWorkModeOperation;
    }else if ([cmd isEqualToString:@"16"]) {
        //配置指示灯开关状态
        operationID = mk_mt_taskConfigIndicatorSettingsOperation;
    }else if ([cmd isEqualToString:@"17"]) {
        //配置设备心跳间隔
        operationID = mk_mt_taskConfigHeartbeatIntervalOperation;
    }else if ([cmd isEqualToString:@"19"]) {
        //配置关机信息上报状态
        operationID = mk_mt_taskConfigShutdownPayloadStatusOperation;
    }else if ([cmd isEqualToString:@"1a"]) {
        //配置离线定位功能开关
        operationID = mk_mt_taskConfigOfflineFixOperation;
    }else if ([cmd isEqualToString:@"1b"]) {
        //配置低电触发心跳开关状态
        operationID = mk_mt_taskConfigLowPowerPayloadStatusOperation;
    }else if ([cmd isEqualToString:@"1c"]) {
        //配置低电百分比
        operationID = mk_mt_taskConfigLowPowerPromptOperation;
    }else if ([cmd isEqualToString:@"30"]) {
        //配置是否需要连接密码
        operationID = mk_mt_taskConfigNeedPasswordOperation;
    }else if ([cmd isEqualToString:@"31"]) {
        //配置连接密码
        operationID = mk_mt_taskConfigPasswordOperation;
    }else if ([cmd isEqualToString:@"32"]) {
        //配置蓝牙广播超时时间
        operationID = mk_mt_taskConfigBroadcastTimeoutOperation;
    }else if ([cmd isEqualToString:@"33"]) {
        //配置蓝牙TX Power
        operationID = mk_mt_taskConfigTxPowerOperation;
    }else if ([cmd isEqualToString:@"34"]) {
        //配置蓝牙广播名称
        operationID = mk_mt_taskConfigDeviceNameOperation;
    }else if ([cmd isEqualToString:@"40"]) {
        //设置定期模式定位策略
        operationID = mk_mt_taskConfigPeriodicModePositioningStrategyOperation;
    }else if ([cmd isEqualToString:@"41"]) {
        //设置定期模式上报间隔
        operationID = mk_mt_taskConfigPeriodicModeReportIntervalOperation;
    }else if ([cmd isEqualToString:@"42"]) {
        //设置定时模式定位策略
        operationID = mk_mt_taskConfigTimingModePositioningStrategyOperation;
    }else if ([cmd isEqualToString:@"43"]) {
        //设置定时模式时间点
        operationID = mk_mt_taskConfigTimingModeReportingTimePointOperation;
    }else if ([cmd isEqualToString:@"44"]) {
        //设置运动模式事件
        operationID = mk_mt_taskConfigMotionModeEventsOperation;
    }else if ([cmd isEqualToString:@"45"]) {
        //设置运动开始定位上报次数
        operationID = mk_mt_taskConfigMotionModeNumberOfFixOnStartOperation;
    }else if ([cmd isEqualToString:@"46"]) {
        //设置运动开始定位策略
        operationID = mk_mt_taskConfigMotionModePosStrategyOnStartOperation;
    }else if ([cmd isEqualToString:@"47"]) {
        //设置运动中定位间隔
        operationID = mk_mt_taskConfigMotionModeReportIntervalInTripOperation;
    }else if ([cmd isEqualToString:@"48"]) {
        //设置运动中定位策略
        operationID = mk_mt_taskConfigMotionModePosStrategyInTripOperation;
    }else if ([cmd isEqualToString:@"49"]) {
        //设置运动结束判断时间
        operationID = mk_mt_taskConfigMotionModeTripEndTimeoutOperation;
    }else if ([cmd isEqualToString:@"4a"]) {
        //设置运动结束定位次数
        operationID = mk_mt_taskConfigMotionModeNumberOfFixOnEndOperation;
    }else if ([cmd isEqualToString:@"4b"]) {
        //设置运动结束定位间隔
        operationID = mk_mt_taskConfigMotionModeReportIntervalOnEndOperation;
    }else if ([cmd isEqualToString:@"4c"]) {
        //设置运动结束定位策略
        operationID = mk_mt_taskConfigMotionModePosStrategyOnEndOperation;
    }else if ([cmd isEqualToString:@"50"]) {
        //配置WIFI定位数据格式
        operationID = mk_mt_taskConfigWifiDataTypeOperation;
    }else if ([cmd isEqualToString:@"51"]) {
        //配置WIFI扫描超时时间
        operationID = mk_mt_taskConfigWifiPositioningTimeoutOperation;
    }else if ([cmd isEqualToString:@"52"]) {
        //配置WIFI定位成功BSSID数量
        operationID = mk_mt_taskConfigWifiNumberOfBSSIDOperation;
    }else if ([cmd isEqualToString:@"53"]) {
        //配置蓝牙定位超时时间
        operationID = mk_mt_taskConfigBlePositioningTimeoutOperation;
    }else if ([cmd isEqualToString:@"54"]) {
        //配置蓝牙定位mac数量
        operationID = mk_mt_taskConfigBlePositioningNumberOfMacOperation;
    }else if ([cmd isEqualToString:@"55"]) {
        //配置rssi过滤规则
        operationID = mk_mt_taskConfigRssiFilterValueOperation;
    }else if ([cmd isEqualToString:@"56"]) {
        //配置蓝牙扫描PHY选择
        operationID = mk_mt_taskConfigScanningPHYTypeOperation;
    }else if ([cmd isEqualToString:@"57"]) {
        //配置广播内容过滤逻辑
        operationID = mk_mt_taskConfigFilterRelationshipOperation;
    }else if ([cmd isEqualToString:@"58"]) {
        //配置精准过滤MAC开关
        operationID = mk_mt_taskConfigFilterByMacPreciseMatchOperation;
    }else if ([cmd isEqualToString:@"59"]) {
        //配置反向过滤MAC开关
        operationID = mk_mt_taskConfigFilterByMacReverseFilterOperation;
    }else if ([cmd isEqualToString:@"5a"]) {
        //配置MAC过滤规则
        operationID = mk_mt_taskConfigFilterMACAddressListOperation;
    }else if ([cmd isEqualToString:@"5b"]) {
        //配置精准过滤Adv Name开关
        operationID = mk_mt_taskConfigFilterByAdvNamePreciseMatchOperation;
    }else if ([cmd isEqualToString:@"5c"]) {
        //配置反向过滤Adv Name开关
        operationID = mk_mt_taskConfigFilterByAdvNameReverseFilterOperation;
    }else if ([cmd isEqualToString:@"5f"]) {
        //配置iBeacon类型过滤开关
        operationID = mk_mt_taskConfigFilterByBeaconStatusOperation;
    }else if ([cmd isEqualToString:@"60"]) {
        //配置iBeacon类型过滤Major范围
        operationID = mk_mt_taskConfigFilterByBeaconMajorOperation;
    }else if ([cmd isEqualToString:@"61"]) {
        //配置iBeacon类型过滤Minor范围
        operationID = mk_mt_taskConfigFilterByBeaconMinorOperation;
    }else if ([cmd isEqualToString:@"62"]) {
        //配置iBeacon类型过滤UUID
        operationID = mk_mt_taskConfigFilterByBeaconUUIDOperation;
    }else if ([cmd isEqualToString:@"63"]) {
        //配置MKiBeacon类型过滤开关
        operationID = mk_mt_taskConfigFilterByMKBeaconStatusOperation;
    }else if ([cmd isEqualToString:@"64"]) {
        //配置MKiBeacon类型过滤Major范围
        operationID = mk_mt_taskConfigFilterByMKBeaconMajorOperation;
    }else if ([cmd isEqualToString:@"65"]) {
        //配置MKiBeacon类型过滤Minor范围
        operationID = mk_mt_taskConfigFilterByMKBeaconMinorOperation;
    }else if ([cmd isEqualToString:@"66"]) {
        //配置MKiBeacon类型过滤UUID
        operationID = mk_mt_taskConfigFilterByMKBeaconUUIDOperation;
    }else if ([cmd isEqualToString:@"67"]) {
        //配置MKiBeacon&ACC类型过滤开关
        operationID = mk_mt_taskConfigFilterByMKBeaconAccStatusOperation;
    }else if ([cmd isEqualToString:@"68"]) {
        //配置MKiBeacon&ACC类型过滤Major范围
        operationID = mk_mt_taskConfigFilterByMKBeaconAccMajorOperation;
    }else if ([cmd isEqualToString:@"69"]) {
        //配置MKiBeacon&ACC类型过滤Minor范围
        operationID = mk_mt_taskConfigFilterByMKBeaconAccMinorOperation;
    }else if ([cmd isEqualToString:@"6a"]) {
        //配置MKiBeacon&ACC类型过滤UUID
        operationID = mk_mt_taskConfigFilterByMKBeaconAccUUIDOperation;
    }else if ([cmd isEqualToString:@"6b"]) {
        //配置UID类型过滤开关
        operationID = mk_mt_taskConfigFilterByUIDStatusOperation;
    }else if ([cmd isEqualToString:@"6c"]) {
        //配置UID类型过滤Namespace ID.
        operationID = mk_mt_taskConfigFilterByUIDNamespaceIDOperation;
    }else if ([cmd isEqualToString:@"6d"]) {
        //配置UID类型过滤Instace ID.
        operationID = mk_mt_taskConfigFilterByUIDInstanceIDOperation;
    }else if ([cmd isEqualToString:@"6e"]) {
        //配置URL类型过滤开关
        operationID = mk_mt_taskConfigFilterByURLStatusOperation;
    }else if ([cmd isEqualToString:@"70"]) {
        //配置TLM类型开关
        operationID = mk_mt_taskConfigFilterByTLMStatusOperation;
    }else if ([cmd isEqualToString:@"71"]) {
        //配置TLM过滤数据类型
        operationID = mk_mt_taskConfigFilterByTLMVersionOperation;
    }else if ([cmd isEqualToString:@"72"]) {
        //配置BeaconX Pro-ACC设备过滤开关
        operationID = mk_mt_taskConfigBXPAccFilterStatusOperation;
    }else if ([cmd isEqualToString:@"73"]) {
        //配置BeaconX Pro-TH设备过滤开关
        operationID = mk_mt_taskConfigBXPTHFilterStatusOperation;
    }else if ([cmd isEqualToString:@"74"]) {
        //配置Other过滤关系开关
        operationID = mk_mt_taskConfigFilterByOtherStatusOperation;
    }else if ([cmd isEqualToString:@"75"]) {
        //配置Other过滤条件逻辑关系
        operationID = mk_mt_taskConfigFilterByOtherRelationshipOperation;
    }else if ([cmd isEqualToString:@"76"]) {
        //配置Other过滤条件列表
        operationID = mk_mt_taskConfigFilterByOtherConditionsOperation;
    }else if ([cmd isEqualToString:@"7a"]) {
        //配置GPS定位超时时间
        operationID = mk_mt_taskConfigLRPositioningTimeoutOperation;
    }else if ([cmd isEqualToString:@"7b"]) {
        //配置GPS搜星数量
        operationID = mk_mt_taskConfigLRStatelliteThresholdOperation;
    }else if ([cmd isEqualToString:@"7c"]) {
        //配置GPS定位数据格式
        operationID = mk_mt_taskConfigLRGPSDataTypeOperation;
    }else if ([cmd isEqualToString:@"7d"]) {
        //配置GPS定位星座
        operationID = mk_mt_taskConfigLRPositioningSystemOperation;
    }else if ([cmd isEqualToString:@"7e"]) {
        //配置定位方式选择
        operationID = mk_mt_taskConfigLRAutonomousAidingOperation;
    }else if ([cmd isEqualToString:@"7f"]) {
        //配置辅助定位经纬度
        operationID = mk_mt_taskConfigLRLatitudeLongitudeOperation;
    }else if ([cmd isEqualToString:@"80"]) {
        //配置星历开始更新事件开关
        operationID = mk_mt_taskConfigLRNotifyOnEphemerisStartStatusOperation;
    }else if ([cmd isEqualToString:@"81"]) {
        //配置星历结束更新事件开关
        operationID = mk_mt_taskConfigLRNotifyOnEphemerisEndStatusOperation;
    }else if ([cmd isEqualToString:@"91"]) {
        //配置LoRaWAN频段
        operationID = mk_mt_taskConfigRegionOperation;
    }else if ([cmd isEqualToString:@"92"]) {
        //配置LoRaWAN入网类型
        operationID = mk_mt_taskConfigModemOperation;
    }else if ([cmd isEqualToString:@"93"]) {
        //配置LoRaWAN DEVEUI
        operationID = mk_mt_taskConfigDEVEUIOperation;
    }else if ([cmd isEqualToString:@"94"]) {
        //配置LoRaWAN APPEUI
        operationID = mk_mt_taskConfigAPPEUIOperation;
    }else if ([cmd isEqualToString:@"95"]) {
        //配置LoRaWAN APPKEY
        operationID = mk_mt_taskConfigAPPKEYOperation;
    }else if ([cmd isEqualToString:@"96"]) {
        //配置LoRaWAN DEVADDR
        operationID = mk_mt_taskConfigDEVADDROperation;
    }else if ([cmd isEqualToString:@"97"]) {
        //配置LoRaWAN APPSKEY
        operationID = mk_mt_taskConfigAPPSKEYOperation;
    }else if ([cmd isEqualToString:@"98"]) {
        //配置LoRaWAN nwkSkey
        operationID = mk_mt_taskConfigNWKSKEYOperation;
    }else if ([cmd isEqualToString:@"99"]) {
        //配置LoRaWAN 上行数据类型
        operationID = mk_mt_taskConfigMessageTypeOperation;
    }else if ([cmd isEqualToString:@"9a"]) {
        //配置LoRaWAN CH
        operationID = mk_mt_taskConfigCHValueOperation;
    }else if ([cmd isEqualToString:@"9b"]) {
        //配置LoRaWAN DR
        operationID = mk_mt_taskConfigDRValueOperation;
    }else if ([cmd isEqualToString:@"9c"]) {
        //配置LoRaWAN 数据发送策略
        operationID = mk_mt_taskConfigUplinkStrategyOperation;
    }else if ([cmd isEqualToString:@"9d"]) {
        //配置LoRaWAN duty cycle
        operationID = mk_mt_taskConfigDutyCycleStatusOperation;
    }else if ([cmd isEqualToString:@"9e"]) {
        //配置LoRaWAN devtime指令同步间隔
        operationID = mk_mt_taskConfigTimeSyncIntervalOperation;
    }else if ([cmd isEqualToString:@"9f"]) {
        //配置LoRaWAN LinkCheckReq指令间隔
        operationID = mk_mt_taskConfigNetworkCheckIntervalOperation;
    }else if ([cmd isEqualToString:@"a0"]) {
        //配置ADR_ACK_LIMIT
        operationID = mk_mt_taskConfigLorawanADRACKLimitOperation;
    }else if ([cmd isEqualToString:@"a1"]) {
        //配置ADR_ACK_DELAY
        operationID = mk_mt_taskConfigLorawanADRACKDelayOperation;
    }else if ([cmd isEqualToString:@"a2"]) {
        //配置LoRaWAN 重传次数
        operationID = mk_mt_taskConfigMaxRetransmissionTimesOperation;
    }else if ([cmd isEqualToString:@"b0"]) {
        //配置下行请求定位策略
        operationID = mk_mt_taskConfigDownlinkPositioningStrategyyOperation;
    }else if ([cmd isEqualToString:@"b1"]) {
        //配置三轴唤醒条件
        operationID = mk_mt_taskConfigThreeAxisWakeupConditionsOperation;
    }else if ([cmd isEqualToString:@"b2"]) {
        //配置运动检测判断
        operationID = mk_mt_taskConfigThreeAxisMotionParametersOperation;
    }else if ([cmd isEqualToString:@"b3"]) {
        //配置震动检测使能
        operationID = mk_mt_taskConfigShockDetectionStatusOperation;
    }else if ([cmd isEqualToString:@"b4"]) {
        //配置震动检测阈值
        operationID = mk_mt_taskConfigShockThresholdsOperation;
    }else if ([cmd isEqualToString:@"b5"]) {
        //配置震动上发间隔
        operationID = mk_mt_taskConfigShockDetectionReportIntervalOperation;
    }else if ([cmd isEqualToString:@"b6"]) {
        //配置震动次数判断间隔
        operationID = mk_mt_taskConfigShockTimeoutOperation;
    }else if ([cmd isEqualToString:@"b7"]) {
        //配置闲置功能使能
        operationID = mk_mt_taskConfigManDownDetectionStatusOperation;
    }else if ([cmd isEqualToString:@"b8"]) {
        //配置闲置超时时间
        operationID = mk_mt_taskConfigIdleDetectionTimeoutOperation;
    }else if ([cmd isEqualToString:@"b9"]) {
        //闲置状态清除
        operationID = mk_mt_taskConfigIdleStutasResetOperation;
    }else if ([cmd isEqualToString:@"ba"]) {
        //配置活动记录使能
        operationID = mk_mt_taskConfigActiveStateCountStatusOperation;
    }else if ([cmd isEqualToString:@"bb"]) {
        //配置活动判定间隔
        operationID = mk_mt_taskConfigActiveStateTimeoutOperation;
    }else if ([cmd isEqualToString:@"c0"]) {
        //读取多少天本地存储的数据
        operationID = mk_mt_taskReadNumberOfDaysStoredDataOperation;
    }else if ([cmd isEqualToString:@"c1"]) {
        //清除存储的所有数据
        operationID = mk_mt_taskClearAllDatasOperation;
    }else if ([cmd isEqualToString:@"c2"]) {
        //暂停/恢复数据传输
        operationID = mk_mt_taskPauseSendLocalDataOperation;
    }
    
    return [self dataParserGetDataSuccess:@{@"success":@(success)} operationID:operationID];
}



#pragma mark -

+ (NSDictionary *)dataParserGetDataSuccess:(NSDictionary *)returnData operationID:(mk_mt_taskOperationID)operationID{
    if (!returnData) {
        return @{};
    }
    return @{@"returnData":returnData,@"operationID":@(operationID)};
}

@end
