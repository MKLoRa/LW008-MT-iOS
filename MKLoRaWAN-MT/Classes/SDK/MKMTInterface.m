//
//  MKMTInterface.m
//  MKLoRaWAN-MT_Example
//
//  Created by aa on 2022/6/9.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKMTInterface.h"

#import "MKBLEBaseSDKDefines.h"
#import "MKBLEBaseSDKAdopter.h"

#import "MKMTCentralManager.h"
#import "MKMTOperationID.h"
#import "MKMTOperation.h"
#import "CBPeripheral+MKMTAdd.h"
#import "MKMTSDKDataAdopter.h"

#define centralManager [MKMTCentralManager shared]
#define peripheral ([MKMTCentralManager shared].peripheral)

@implementation MKMTInterface

#pragma mark ****************************************Device Service Information************************************************

+ (void)mt_readDeviceModelWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_mt_taskReadDeviceModelOperation
                           characteristic:peripheral.mt_deviceModel
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)mt_readFirmwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_mt_taskReadFirmwareOperation
                           characteristic:peripheral.mt_firmware
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)mt_readHardwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_mt_taskReadHardwareOperation
                           characteristic:peripheral.mt_hardware
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)mt_readSoftwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_mt_taskReadSoftwareOperation
                           characteristic:peripheral.mt_software
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)mt_readManufacturerWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_mt_taskReadManufacturerOperation
                           characteristic:peripheral.mt_manufacturer
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

#pragma mark ****************************************System************************************************

+ (void)mt_readTimeZoneWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadTimeZoneOperation
                     cmdFlag:@"14"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readWorkModeWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadWorkModeOperation
                     cmdFlag:@"15"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readIndicatorSettingsWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadIndicatorSettingsOperation
                     cmdFlag:@"16"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readHeartbeatIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadHeartbeatIntervalOperation
                     cmdFlag:@"17"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readShutdownPayloadStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadShutdownPayloadStatusOperation
                     cmdFlag:@"19"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readOfflineFixStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadOfflineFixStatusOperation
                     cmdFlag:@"1a"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readLowPowerPayloadStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadLowPowerPayloadStatusOperation
                     cmdFlag:@"1b"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readLowPowerPromptWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadLowPowerPromptOperation
                     cmdFlag:@"1c"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readBatteryVoltageWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadBatteryVoltageOperation
                     cmdFlag:@"20"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readMacAddressWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadMacAddressOperation
                     cmdFlag:@"21"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readPCBAStatusWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadPCBAStatusOperation
                     cmdFlag:@"22"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readSelftestStatusWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadSelftestStatusOperation
                     cmdFlag:@"23"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark ****************************************蓝牙相关参数************************************************

+ (void)mt_readConnectationNeedPasswordWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadConnectationNeedPasswordOperation
                     cmdFlag:@"30"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readPasswordWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadPasswordOperation
                     cmdFlag:@"31"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readBroadcastTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadBroadcastTimeoutOperation
                     cmdFlag:@"32"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readTxPowerWithSucBlock:(void (^)(id returnData))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadTxPowerOperation
                     cmdFlag:@"33"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readDeviceNameWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadDeviceNameOperation
                     cmdFlag:@"34"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark ****************************************模式相关参数************************************************

+ (void)mt_readPeriodicModePositioningStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                               failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadPeriodicModePositioningStrategyOperation
                     cmdFlag:@"40"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readPeriodicModeReportIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadPeriodicModeReportIntervalOperation
                     cmdFlag:@"41"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readTimingModePositioningStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadTimingModePositioningStrategyOperation
                     cmdFlag:@"42"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readTimingModeReportingTimePointWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadTimingModeReportingTimePointOperation
                     cmdFlag:@"43"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readMotionModeEventsWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadMotionModeEventsOperation
                     cmdFlag:@"44"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readMotionModeNumberOfFixOnStartWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadMotionModeNumberOfFixOnStartOperation
                     cmdFlag:@"45"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readMotionModePosStrategyOnStartWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadMotionModePosStrategyOnStartOperation
                     cmdFlag:@"46"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readMotionModeReportIntervalInTripWithSucBlock:(void (^)(id returnData))sucBlock
                                              failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadMotionModeReportIntervalInTripOperation
                     cmdFlag:@"47"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readMotionModePosStrategyInTripWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadMotionModePosStrategyInTripOperation
                     cmdFlag:@"48"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readMotionModeTripEndTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadMotionModeTripEndTimeoutOperation
                     cmdFlag:@"49"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readMotionModeNumberOfFixOnEndWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadMotionModeNumberOfFixOnEndOperation
                     cmdFlag:@"4a"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readMotionModeReportIntervalOnEndWithSucBlock:(void (^)(id returnData))sucBlock
                                             failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadMotionModeReportIntervalOnEndOperation
                     cmdFlag:@"4b"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readMotionModePosStrategyOnEndWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadMotionModePosStrategyOnEndOperation
                     cmdFlag:@"4c"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark ****************************************定位参数************************************************

+ (void)mt_readWifiDataTypeWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadWifiDataTypeOperation
                     cmdFlag:@"50"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readWifiPositioningTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadWifiPositioningTimeoutOperation
                     cmdFlag:@"51"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readWifiNumberOfBSSIDWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadWifiNumberOfBSSIDOperation
                     cmdFlag:@"52"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readBlePositioningTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadBlePositioningTimeoutOperation
                     cmdFlag:@"53"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readBlePositioningNumberOfMacWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadBlePositioningNumberOfMacOperation
                     cmdFlag:@"54"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readRssiFilterValueWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadRssiFilterValueOperation
                     cmdFlag:@"55"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readScanningPHYTypeWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadScanningPHYTypeOperation
                     cmdFlag:@"56"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readFilterRelationshipWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadFilterRelationshipOperation
                     cmdFlag:@"57"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readFilterByMacPreciseMatchWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadFilterByMacPreciseMatchOperation
                     cmdFlag:@"58"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readFilterByMacReverseFilterWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadFilterByMacReverseFilterOperation
                     cmdFlag:@"59"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readFilterMACAddressListWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadFilterMACAddressListOperation
                     cmdFlag:@"5a"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readFilterByAdvNamePreciseMatchWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadFilterByAdvNamePreciseMatchOperation
                     cmdFlag:@"5b"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readFilterByAdvNameReverseFilterWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadFilterByAdvNameReverseFilterOperation
                     cmdFlag:@"5c"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readFilterAdvNameListWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ee005d00";
    [centralManager addTaskWithTaskID:mk_mt_taskReadFilterAdvNameListOperation
                       characteristic:peripheral.mt_custom
                          commandData:commandString
                         successBlock:^(id  _Nonnull returnData) {
        NSArray *advList = [MKMTSDKDataAdopter parseFilterAdvNameList:returnData[@"result"]];
        NSDictionary *resultDic = @{@"msg":@"success",
                                    @"code":@"1",
                                    @"result":@{
                                        @"nameList":advList,
                                    },
                                    };
        MKBLEBase_main_safe(^{
            if (sucBlock) {
                sucBlock(resultDic);
            }
        });
        
    } failureBlock:failedBlock];
}

+ (void)mt_readFilterTypeStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadFilterTypeStatusOperation
                     cmdFlag:@"5e"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readFilterByBeaconStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadFilterByBeaconStatusOperation
                     cmdFlag:@"5f"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readFilterByBeaconMajorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadFilterByBeaconMajorRangeOperation
                     cmdFlag:@"60"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readFilterByBeaconMinorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadFilterByBeaconMinorRangeOperation
                     cmdFlag:@"61"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readFilterByBeaconUUIDWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadFilterByBeaconUUIDOperation
                     cmdFlag:@"62"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readFilterByBXPBeaconStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadFilterByBXPBeaconStatusOperation
                     cmdFlag:@"63"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readFilterByBXPBeaconMajorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadFilterByBXPBeaconMajorRangeOperation
                     cmdFlag:@"64"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readFilterByBXPBeaconMinorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadFilterByBXPBeaconMinorRangeOperation
                     cmdFlag:@"65"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readFilterByBXPBeaconUUIDWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadFilterByBXPBeaconUUIDOperation
                     cmdFlag:@"66"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readFilterByBXPTagIDStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadFilterByBXPTagIDStatusOperation
                     cmdFlag:@"67"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readPreciseMatchTagIDStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadPreciseMatchTagIDStatusOperation
                     cmdFlag:@"68"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readReverseFilterTagIDStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadReverseFilterTagIDStatusOperation
                     cmdFlag:@"69"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readFilterBXPTagIDListWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadFilterBXPTagIDListOperation
                     cmdFlag:@"6a"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readFilterByUIDStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadFilterByUIDStatusOperation
                     cmdFlag:@"6b"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readFilterByUIDNamespaceIDWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadFilterByUIDNamespaceIDOperation
                     cmdFlag:@"6c"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readFilterByUIDInstanceIDWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadFilterByUIDInstanceIDOperation
                     cmdFlag:@"6d"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readFilterByURLStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadFilterByURLStatusOperation
                     cmdFlag:@"6e"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readFilterByURLContentWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadFilterByURLContentOperation
                     cmdFlag:@"6f"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readFilterByTLMStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadFilterByTLMStatusOperation
                     cmdFlag:@"70"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readFilterByTLMVersionWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadFilterByTLMVersionOperation
                     cmdFlag:@"71"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readBXPAccFilterStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadBXPAccFilterStatusOperation
                     cmdFlag:@"72"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readBXPTHFilterStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadBXPTHFilterStatusOperation
                     cmdFlag:@"73"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readFilterByOtherStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadFilterByOtherStatusOperation
                     cmdFlag:@"74"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readFilterByOtherRelationshipWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadFilterByOtherRelationshipOperation
                     cmdFlag:@"75"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readFilterByOtherConditionsWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadFilterByOtherConditionsOperation
                     cmdFlag:@"76"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readLCPositioningTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadLCPositioningTimeoutOperation
                     cmdFlag:@"77"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readLCPDOPWithSucBlock:(void (^)(id returnData))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadLCPDOPOperation
                     cmdFlag:@"78"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readLCGpsExtrmeModeStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadLCGpsExtrmeModeStatusOperation
                     cmdFlag:@"79"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readLRPositioningTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadLRPositioningTimeoutOperation
                     cmdFlag:@"7a"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readLRStatelliteThresholdWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadLRStatelliteThresholdOperation
                     cmdFlag:@"7b"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readLRGPSDataTypeWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadLRGPSDataTypeOperation
                     cmdFlag:@"7c"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readLRPositioningSystemWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadLRPositioningSystemOperation
                     cmdFlag:@"7d"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readLRAutonomousAidingWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadLRAutonomousAidingOperation
                     cmdFlag:@"7e"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readLRLatitudeLongitudeWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadLRLatitudeLongitudeOperation
                     cmdFlag:@"7f"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readLRNotifyOnEphemerisStartStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadLRNotifyOnEphemerisStartStatusOperation
                     cmdFlag:@"80"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readLRNotifyOnEphemerisEndStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadLRNotifyOnEphemerisEndStatusOperation
                     cmdFlag:@"81"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readBXPDeviceInfoFilterStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadBXPDeviceInfoFilterStatusOperation
                     cmdFlag:@"82"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readBXPButtonFilterStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadBXPButtonFilterStatusOperation
                     cmdFlag:@"83"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readBXPButtonAlarmFilterStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadBXPButtonAlarmFilterStatusOperation
                     cmdFlag:@"84"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readBluetoothFixMechanismWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadBluetoothFixMechanismOperation
                     cmdFlag:@"85"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark **************************************** LoRaWAN ************************************************

+ (void)mt_readLorawanNetworkStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadLorawanNetworkStatusOperation
                     cmdFlag:@"90"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readLorawanRegionWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadLorawanRegionOperation
                     cmdFlag:@"91"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readLorawanModemWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadLorawanModemOperation
                     cmdFlag:@"92"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readLorawanDEVEUIWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadLorawanDEVEUIOperation
                     cmdFlag:@"93"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readLorawanAPPEUIWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadLorawanAPPEUIOperation
                     cmdFlag:@"94"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readLorawanAPPKEYWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadLorawanAPPKEYOperation
                     cmdFlag:@"95"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readLorawanDEVADDRWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadLorawanDEVADDROperation
                     cmdFlag:@"96"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readLorawanAPPSKEYWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadLorawanAPPSKEYOperation
                     cmdFlag:@"97"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readLorawanNWKSKEYWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadLorawanNWKSKEYOperation
                     cmdFlag:@"98"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readLorawanMessageTypeWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadLorawanMessageTypeOperation
                     cmdFlag:@"99"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readLorawanCHWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadLorawanCHOperation
                     cmdFlag:@"9a"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readLorawanDRWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadLorawanDROperation
                     cmdFlag:@"9b"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readLorawanUplinkStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadLorawanUplinkStrategyOperation
                     cmdFlag:@"9c"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readLorawanDutyCycleStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadLorawanDutyCycleStatusOperation
                     cmdFlag:@"9d"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readLorawanTimeSyncIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadLorawanDevTimeSyncIntervalOperation
                     cmdFlag:@"9e"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readLorawanNetworkCheckIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadLorawanNetworkCheckIntervalOperation
                     cmdFlag:@"9f"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readLorawanADRACKLimitWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadLorawanADRACKLimitOperation
                     cmdFlag:@"a0"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readLorawanADRACKDelayWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadLorawanADRACKDelayOperation
                     cmdFlag:@"a1"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readLorawanMaxRetransmissionTimesWithSucBlock:(void (^)(id returnData))sucBlock
                                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadLorawanMaxRetransmissionTimesOperation
                     cmdFlag:@"a2"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark ****************************************辅助功能************************************************

+ (void)mt_readDownlinkPositioningStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadDownlinkPositioningStrategyOperation
                     cmdFlag:@"b0"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readThreeAxisWakeupConditionsWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadThreeAxisWakeupConditionsOperation
                     cmdFlag:@"b1"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readThreeAxisMotionParametersWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadThreeAxisMotionParametersOperation
                     cmdFlag:@"b2"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readShockDetectionStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadShockDetectionStatusOperation
                     cmdFlag:@"b3"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readShockThresholdsWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadShockThresholdsOperation
                     cmdFlag:@"b4"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readShockDetectionReportIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadShockDetectionReportIntervalOperation
                     cmdFlag:@"b5"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readShockTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadShockTimeoutOperation
                     cmdFlag:@"b6"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readManDownDetectionWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadManDownDetectionOperation
                     cmdFlag:@"b7"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readIdleDetectionTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadIdleDetectionTimeoutOperation
                     cmdFlag:@"b8"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readActiveStateCountStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadActiveStateCountStatusOperation
                     cmdFlag:@"ba"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mt_readActiveStateTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mt_taskReadActiveStateTimeoutOperation
                     cmdFlag:@"bb"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark - private method

+ (void)readDataWithTaskID:(mk_mt_taskOperationID)taskID
                   cmdFlag:(NSString *)flag
                  sucBlock:(void (^)(id returnData))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed00",flag,@"00"];
    [centralManager addTaskWithTaskID:taskID
                       characteristic:peripheral.mt_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

@end
