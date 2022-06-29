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
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA05"]]) {
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
        if ([cmd isEqualToString:@"5b"]) {
            //读取Adv Name过滤规则
            NSData *subData = [readData subdataWithRange:NSMakeRange(6, len)];
            NSDictionary *resultDic= @{
                mk_mt_totalNumKey:totalNum,
                mk_mt_totalIndexKey:index,
                mk_mt_contentKey:(subData ? subData : [NSData data]),
            };
//            return [self dataParserGetDataSuccess:resultDic operationID:mk_mt_taskReadFilterAdvNameListOperation];
        }
    }
    if ([flag isEqualToString:@"01"]) {
        //配置
        mk_mt_taskOperationID operationID = mk_mt_defaultTaskOperationID;
        NSString *content = [readString substringWithRange:NSMakeRange(8, 2)];
        BOOL success = [content isEqualToString:@"01"];
        
        if ([cmd isEqualToString:@"5b"]) {
            //配置Adv Name过滤规则
//            operationID = mk_mt_taskConfigFilterAdvNameListOperation;
        }
        return [self dataParserGetDataSuccess:@{@"success":@(success)} operationID:operationID];
    }
    return @{};
}

+ (NSDictionary *)parseCustomReadData:(NSString *)content cmd:(NSString *)cmd data:(NSData *)data {
    mk_mt_taskOperationID operationID = mk_mt_defaultTaskOperationID;
    NSDictionary *resultDic = @{};
    
    if ([cmd isEqualToString:@"01"]) {
        
    }else if ([cmd isEqualToString:@"80"]) {
        //读取LoRaWAN频段
        resultDic = @{
            @"region":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mt_taskReadLorawanRegionOperation;
    }else if ([cmd isEqualToString:@"81"]) {
        //读取LoRaWAN入网类型
        resultDic = @{
            @"modem":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mt_taskReadLorawanModemOperation;
    }else if ([cmd isEqualToString:@"82"]) {
        //读取LoRaWAN网络状态
        resultDic = @{
            @"status":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mt_taskReadLorawanNetworkStatusOperation;
    }else if ([cmd isEqualToString:@"83"]) {
        //读取LoRaWAN DEVEUI
        resultDic = @{
            @"devEUI":content,
        };
        operationID = mk_mt_taskReadLorawanDEVEUIOperation;
    }else if ([cmd isEqualToString:@"84"]) {
        //读取LoRaWAN APPEUI
        resultDic = @{
            @"appEUI":content
        };
        operationID = mk_mt_taskReadLorawanAPPEUIOperation;
    }else if ([cmd isEqualToString:@"85"]) {
        //读取LoRaWAN APPKEY
        resultDic = @{
            @"appKey":content
        };
        operationID = mk_mt_taskReadLorawanAPPKEYOperation;
    }else if ([cmd isEqualToString:@"86"]) {
        //读取LoRaWAN DEVADDR
        resultDic = @{
            @"devAddr":content
        };
        operationID = mk_mt_taskReadLorawanDEVADDROperation;
    }else if ([cmd isEqualToString:@"87"]) {
        //读取LoRaWAN APPSKEY
        resultDic = @{
            @"appSkey":content
        };
        operationID = mk_mt_taskReadLorawanAPPSKEYOperation;
    }else if ([cmd isEqualToString:@"88"]) {
        //读取LoRaWAN nwkSkey
        resultDic = @{
            @"nwkSkey":content
        };
        operationID = mk_mt_taskReadLorawanNWKSKEYOperation;
    }else if ([cmd isEqualToString:@"89"]) {
        //读取LoRaWAN 上行数据类型
        resultDic = @{
            @"messageType":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mt_taskReadLorawanMessageTypeOperation;
    }else if ([cmd isEqualToString:@"8a"]) {
        //读取LoRaWAN CH
        resultDic = @{
            @"CHL":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)],
            @"CHH":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)]
        };
        operationID = mk_mt_taskReadLorawanCHOperation;
    }else if ([cmd isEqualToString:@"8b"]) {
        //读取LoRaWAN DR
        resultDic = @{
            @"DR":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mt_taskReadLorawanDROperation;
    }else if ([cmd isEqualToString:@"8c"]) {
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
    }else if ([cmd isEqualToString:@"8d"]) {
        //读取LoRaWAN duty cycle
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_mt_taskReadLorawanDutyCycleStatusOperation;
    }else if ([cmd isEqualToString:@"8e"]) {
        //读取LoRaWAN devtime指令同步间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mt_taskReadLorawanDevTimeSyncIntervalOperation;
    }else if ([cmd isEqualToString:@"8f"]) {
        //读取LoRaWAN LinkCheckReq指令间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mt_taskReadLorawanNetworkCheckIntervalOperation;
    }else if ([cmd isEqualToString:@"90"]) {
        //读取LoRaWAN 重传次数
        resultDic = @{
            @"number":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mt_taskReadLorawanMaxRetransmissionTimesOperation;
    }else if ([cmd isEqualToString:@"91"]) {
        //读取ADR_ACK_LIMIT
        resultDic = @{
            @"value":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mt_taskReadLorawanADRACKLimitOperation;
    }else if ([cmd isEqualToString:@"92"]) {
        //读取ADR_ACK_DELAY
        resultDic = @{
            @"value":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mt_taskReadLorawanADRACKDelayOperation;
    }
    
    return [self dataParserGetDataSuccess:resultDic operationID:operationID];
}

+ (NSDictionary *)parseCustomConfigData:(NSString *)content cmd:(NSString *)cmd {
    mk_mt_taskOperationID operationID = mk_mt_defaultTaskOperationID;
    BOOL success = [content isEqualToString:@"01"];
    
    if ([cmd isEqualToString:@"01"]) {
        //配置LoRaWAN入网类型
        operationID = mk_mt_taskConfigModemOperation;
    }else if ([cmd isEqualToString:@"80"]) {
        //配置LoRaWAN频段
        operationID = mk_mt_taskConfigRegionOperation;
    }else if ([cmd isEqualToString:@"81"]) {
        //配置LoRaWAN入网类型
        operationID = mk_mt_taskConfigModemOperation;
    }else if ([cmd isEqualToString:@"83"]) {
        //配置LoRaWAN DEVEUI
        operationID = mk_mt_taskConfigDEVEUIOperation;
    }else if ([cmd isEqualToString:@"84"]) {
        //配置LoRaWAN APPEUI
        operationID = mk_mt_taskConfigAPPEUIOperation;
    }else if ([cmd isEqualToString:@"85"]) {
        //配置LoRaWAN APPKEY
        operationID = mk_mt_taskConfigAPPKEYOperation;
    }else if ([cmd isEqualToString:@"86"]) {
        //配置LoRaWAN DEVADDR
        operationID = mk_mt_taskConfigDEVADDROperation;
    }else if ([cmd isEqualToString:@"87"]) {
        //配置LoRaWAN APPSKEY
        operationID = mk_mt_taskConfigAPPSKEYOperation;
    }else if ([cmd isEqualToString:@"88"]) {
        //配置LoRaWAN nwkSkey
        operationID = mk_mt_taskConfigNWKSKEYOperation;
    }else if ([cmd isEqualToString:@"89"]) {
        //配置LoRaWAN 上行数据类型
        operationID = mk_mt_taskConfigMessageTypeOperation;
    }else if ([cmd isEqualToString:@"8a"]) {
        //配置LoRaWAN CH
        operationID = mk_mt_taskConfigCHValueOperation;
    }else if ([cmd isEqualToString:@"8b"]) {
        //配置LoRaWAN DR
        operationID = mk_mt_taskConfigDRValueOperation;
    }else if ([cmd isEqualToString:@"8c"]) {
        //配置LoRaWAN 数据发送策略
        operationID = mk_mt_taskConfigUplinkStrategyOperation;
    }else if ([cmd isEqualToString:@"8d"]) {
        //配置LoRaWAN duty cycle
        operationID = mk_mt_taskConfigDutyCycleStatusOperation;
    }else if ([cmd isEqualToString:@"8e"]) {
        //配置LoRaWAN devtime指令同步间隔
        operationID = mk_mt_taskConfigTimeSyncIntervalOperation;
    }else if ([cmd isEqualToString:@"8f"]) {
        //配置LoRaWAN LinkCheckReq指令间隔
        operationID = mk_mt_taskConfigNetworkCheckIntervalOperation;
    }else if ([cmd isEqualToString:@"90"]) {
        //配置LoRaWAN 重传次数
        operationID = mk_mt_taskConfigMaxRetransmissionTimesOperation;
    }else if ([cmd isEqualToString:@"91"]) {
        //配置ADR_ACK_LIMIT
        operationID = mk_mt_taskConfigLorawanADRACKLimitOperation;
    }else if ([cmd isEqualToString:@"92"]) {
        //配置ADR_ACK_DELAY
        operationID = mk_mt_taskConfigLorawanADRACKDelayOperation;
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
