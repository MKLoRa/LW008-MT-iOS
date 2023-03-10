//
//  MKMTInterface.h
//  MKLoRaWAN-MT_Example
//
//  Created by aa on 2022/6/9.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKMTSDKNormalDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKMTInterface : NSObject

#pragma mark ****************************************Device Service Information************************************************

/// Read product model
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readDeviceModelWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Read device firmware information
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readFirmwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Read device hardware information
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readHardwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Read device software information
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readSoftwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Read device manufacturer information
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readManufacturerWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark ****************************************System************************************************

/// Read the time zone of the device.
/*
 @{
 @"timeZone":@(-23)       //UTC-11:30
 }
 //-24~28((The time zone is in units of 30 minutes, UTC-12:00~UTC+14:00))
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readTimeZoneWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the working mode of the device.
/*
 @{
 @"mode":@"2"
 }
 
 0：Standby mode
 1：Timing mode
 2：Periodic mode
 3：Motion Mode
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readWorkModeWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Indicator Settings.
/*
 @{
    @"lowPower":@(YES),
    @"networkCheck":@(NO),
    @"inFix":@(YES),
    @"fixSuccessful":@(NO),
    @"failToFix":@(YES),
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readIndicatorSettingsWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Heartbeat Interval.
/*
 @{
 @"interval":@"720"     //Unit:S.
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readHeartbeatIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Shutdown Payload Status.
/*
 @{
    @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readShutdownPayloadStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Whether to enable positioning when the device fails to connect to the Lorawan network.
/*
    @{
    @"isOn":@(YES),
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readOfflineFixStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Whether to trigger a heartbeat when the device is low on battery.
/*
    @{
    @"isOn":@(YES),
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readLowPowerPayloadStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// When the power of the device is lower than how much, it is judged as a low power state.
/*
    @{
    @"prompt":@"0",         //@"0":5%   @"1":10%
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readLowPowerPromptWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Read battery voltage.
/*
 @{
 @"voltage":@"3000",        //Unit:mV
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readBatteryVoltageWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the mac address of the device.
/*
 @{
    @"macAddress":@"AA:BB:CC:DD:EE:FF"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readMacAddressWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the PCBA Status of the device.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readPCBAStatusWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the Selftest Status of the device.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readSelftestStatusWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Information of the battery.
/*
 @{
     @"workTimes":@"65535",         //Device working times.(Unit:s)
     @"advCount":@"65535",          //The number of Bluetooth broadcasts by the device.
     @"flashOperationCount":@"3000",    //Flash read and write times.
     @"axisWakeupTimes":@"11111",       //Three-axis sensor wake-up times.(Unit:ms)
     @"blePostionTimes":@"11111",       //Bluetooth positioning times.(Unit:ms)
     @"wifiPostionTimes":@"11111",      //WIFI positioning times.(Unit:ms)
     @"gpsPostionTimes":@"11111",       //GPS positioning times.(Unit:ms)
     @"loraPowerConsumption":@"50000",      //Power consumption of LoRaWAN sending and receiving data.(Unit:mAS)
     @"loraSendCount":@"10000",     //Number of LoRaWAN transmissions.
     @"batteryPower":@"33500"       //Total battery power consumption.(Unit:0.001mAH)
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readBatteryInformationWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;


#pragma mark ****************************************蓝牙相关参数************************************************

/// Is a password required when the device is connected.
/*
 @{
 @"need":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readConnectationNeedPasswordWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;

/// When the connected device requires a password, read the current connection password.
/*
 @{
 @"password":@"xxxxxxxxx"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readPasswordWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the broadcast timeout time in Bluetooth configuration mode.
/*
 @{
 @"timeout":@"10"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readBroadcastTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the txPower of device.
/*
 @{
 @"txPower":@"0dBm"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readTxPowerWithSucBlock:(void (^)(id returnData))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;


/// Read the broadcast name of the device.
/*
 @{
 @"deviceName":@"MOKO"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readDeviceNameWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark ****************************************模式相关参数************************************************

/// Read Periodic Mode positioning strategy.
/*
 @{
 @"strategy":@(1)
 }
 
 0:Wifi
 1:BLE
 2:GPS
 3:WIFI+GPS
 4:BLE+GPS
 5:WIFI+BLE
 6:WIFI+BLE+GPS
 
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readPeriodicModePositioningStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Periodic Mode reporting interval.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readPeriodicModeReportIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Timing Mode positioning strategy.
/*
 @{
 @"strategy":@(1)
 }
 
 0:Wifi
 1:BLE
 2:GPS
 3:WIFI+GPS
 4:BLE+GPS
 5:WIFI+BLE
 6:WIFI+BLE+GPS
 
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readTimingModePositioningStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Timing Mode Reporting Time Point.
/*
 @[@{
 @"hour":@(0),
 @"minuteGear":@(0)
 },
 @{
 @"hour":@(0),
 @"minuteGear":@(1)
 }]
 
 hour:0~23,
 minuteGear:  0:00, 1:15, 2:30, 3:45
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readTimingModeReportingTimePointWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError * error))failedBlock;

/// Read Motion Mode Events.
/*
 @{
     @"fixOnStart":@(YES),
     @"fixInTrip":@(NO),
     @"fixOnEnd":@(YES),
     @"notifyEventOnStart":@(NO),
     @"notifyEventInTrip":@(NO),
     @"notifyEventOnEnd":@(YES),
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readMotionModeEventsWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError * error))failedBlock;

/// Read Motion Mode Number Of Fix On Start.
/*
 @{
    @"number":@"1"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readMotionModeNumberOfFixOnStartWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError * error))failedBlock;

/// Read Motion Mode Pos-Strategy On Start.
/*
 @{
 @"strategy":@(1)
 }
 
 0:Wifi
 1:BLE
 2:GPS
 3:WIFI+GPS
 4:BLE+GPS
 5:WIFI+BLE
 6:WIFI+BLE+GPS
 
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readMotionModePosStrategyOnStartWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError * error))failedBlock;

/// Read Motion Mode Report Interval In Trip.
/*
 @{
    @"interval":@"5"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readMotionModeReportIntervalInTripWithSucBlock:(void (^)(id returnData))sucBlock
                                              failedBlock:(void (^)(NSError * error))failedBlock;

/// Read Motion Mode Pos-Strategy In Trip.
/*
 @{
 @"strategy":@(1)
 }
 
 0:Wifi
 1:BLE
 2:GPS
 3:WIFI+GPS
 4:BLE+GPS
 5:WIFI+BLE
 6:WIFI+BLE+GPS
 
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readMotionModePosStrategyInTripWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError * error))failedBlock;

/// Read Motion Mode Trip End Timeout.(Unit:10s)
/*
 @{
    @"time":@"5"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readMotionModeTripEndTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError * error))failedBlock;

/// Read Motion Mode Number Of Fix On End.
/*
 @{
 @"number":@"1"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readMotionModeNumberOfFixOnEndWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError * error))failedBlock;

/// Read Motion Mode Report Interval On End.
/*
 @{
 @"interval":@"120"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readMotionModeReportIntervalOnEndWithSucBlock:(void (^)(id returnData))sucBlock
                                             failedBlock:(void (^)(NSError * error))failedBlock;

/// Read Motion Mode Pos-Strategy On End.
/*
 @{
 @"strategy":@(1)
 }
 
 0:Wifi
 1:BLE
 2:GPS
 3:WIFI+GPS
 4:BLE+GPS
 5:WIFI+BLE
 6:WIFI+BLE+GPS
 
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readMotionModePosStrategyOnEndWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError * error))failedBlock;


#pragma mark ****************************************定位参数************************************************

/// Read WIFI positioning data format.
/*
 @{
    @"dataType":@"0"        //@"0":DAS   @"1":@"Customer"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readWifiDataTypeWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the WIFI positioning timeout.The current value multiplied by 2.5 is the actual time (unit: s).
/*
 @{
    @"interval":@"1"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readWifiPositioningTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the number of BSSIDs with successful WIFI positioning.
/*
 @{
    @"number":@"3"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readWifiNumberOfBSSIDWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Positioning Timeout Of Ble.
/*
 @{
 @"timeout":@"5"            //unit:s
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readBlePositioningTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// The number of MACs for Bluetooth positioning.
/*
 @{
 @"number":@"3"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readBlePositioningNumberOfMacWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock;

/// The device will uplink valid ADV data with RSSI no less than xx dBm.
/*
 @{
 @"rssi":@"-127"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readRssiFilterValueWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the Scanning Type/PHY.
/*
 @{
    @"phyType":@"0",            //0:1M PHY (BLE 4.x)      1:1M PHY (BLE 5)    2:1M PHY (BLE 4.x + BLE 5)     3:Coded PHY(BLE 5)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readScanningPHYTypeWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Broadcast content filtering logic.
/*
 @{
 @"relationship":@"4"
 }
 @"0":Null
 @"1":MAC
 @"2":ADV Name
 @"3":Raw Data
 @"4":ADV Name & Raw Data
 @"5":MAC & ADV Name & Raw Data
 @"6":ADV Name | Raw Data
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readFilterRelationshipWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// A switch to accurately filter Mac addresses.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readFilterByMacPreciseMatchWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch for reverse filtering of MAC addresses.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readFilterByMacReverseFilterWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Filtered list of mac addresses.
/*
 @{
 @"macList":@[
    @"aabb",
 @"aabbccdd",
 @"ddeeff"
 ],
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readFilterMACAddressListWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// A switch to accurately filter Adv Name.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readFilterByAdvNamePreciseMatchWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch for reverse filtering of Adv Name.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readFilterByAdvNameReverseFilterWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Filtered list of mac addresses.
/*
 @{
 @"nameList":@[
    @"moko",
 @"LW004-PB",
 @"asdf"
 ],
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readFilterAdvNameListWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Read switch status of filtered device types.
/*
 @{
     @"iBeacon":@(YES),
     @"uid":@(YES),
     @"url":@(YES),
     @"tlm":@(YES),
     @"bxp_beacon":@(YES),
     @"bxp_deviceInfo":@(YES),
     @"bxp_acc":@(YES),
     @"bxp_th":@(YES),
     @"bxp_button":@(YES),
     @"bxp_tag":@(YES),
     @"other":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readFilterTypeStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by iBeacon.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readFilterByBeaconStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Major filter range of iBeacon.
/*
 @{
     @"isOn":@(YES),
     @"minValue":@"00",         //isOn=YES
     @"maxValue":@"11",         //isOn=YES
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readFilterByBeaconMajorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Minor filter range of iBeacon.
/*
 @{
     @"isOn":@(YES),
     @"minValue":@"00",         //isOn=YES
     @"maxValue":@"11",         //isOn=YES
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readFilterByBeaconMinorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;

/// UUID status of filter by iBeacon.
/*
 @{
 @"uuid":@"xx"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readFilterByBeaconUUIDWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by BXP-iBeacon.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readFilterByBXPBeaconStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Major filter range of BXP-iBeacon.
/*
 @{
     @"isOn":@(YES),
     @"minValue":@"00",         //isOn=YES
     @"maxValue":@"11",         //isOn=YES
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readFilterByBXPBeaconMajorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Minor filter range of BXP-iBeacon.
/*
 @{
     @"isOn":@(YES),
     @"minValue":@"00",         //isOn=YES
     @"maxValue":@"11",         //isOn=YES
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readFilterByBXPBeaconMinorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock;

/// UUID status of filter by BXP-iBeacon.
/*
 @{
 @"uuid":@"xx"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readFilterByBXPBeaconUUIDWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;


/// Switch status of filter by BXP-TagID.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readFilterByBXPTagIDStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Precise Match Tag ID.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readPreciseMatchTagIDStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Reverse Filter Tag ID.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readReverseFilterTagIDStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Filtered list of BXP-TagID addresses.
/*
 @{
 @"tagIDList":@[
    @"aabb",
 @"aabbccdd",
 @"ddeeff"
 ],
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readFilterBXPTagIDListWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by UID.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readFilterByUIDStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Namespace ID of filter by UID.
/*
 @{
 @"namespaceID":@"aabb"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readFilterByUIDNamespaceIDWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Instance ID of filter by UID.
/*
 @{
 @"instanceID":@"aabb"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readFilterByUIDInstanceIDWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by URL.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readFilterByURLStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Content of filter by URL.
/*
 @{
 @"url":@"moko.com"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readFilterByURLContentWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by TLM.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readFilterByTLMStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// TLM Version of filter by TLM.
/*
 @{
 @"version":@"0",           //@"0":Null(Do not filter data)   @"1":Unencrypted TLM data. @"2":Encrypted TLM data.
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readFilterByTLMVersionWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;


/// Read the filter status of the BeaconX Pro-ACC device.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readBXPAccFilterStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the filter status of the BeaconX Pro-T&H device.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readBXPTHFilterStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by Other.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readFilterByOtherStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Add logical relationships for up to three sets of filter conditions.
/*
 @{
 @"relationship":@"0",
 }
  0:A
  1:A & B
  2:A | B
  3:A & B & C
  4:(A & B) | C
  5:A | B | C
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readFilterByOtherRelationshipWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Current filter.
/*
 @{
    @"conditionList":@[
            @{
                @"type":@"00",
                @"start":@"0"
                @"end":@"3",
                @"data":@"001122"
            },
            @{
                @"type":@"03",
                @"start":@"1"
                @"end":@"2",
                @"data":@"0011"
            }
        ]
    }
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readFilterByOtherConditionsWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Read GPS positioning timeout.(L76C)
/*
 @{
    @"timeout":@"1",        //Unit:s
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readLCPositioningTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// PDOP.(L76C)
/*
 @{
    @"pdop":@"1",        //Unit:0.1
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readLCPDOPWithSucBlock:(void (^)(id returnData))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

/// GPS limit upload mode status.(L76C)
/*
 @{
    @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readLCGpsExtrmeModeStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;


/// Read GPS positioning timeout.(LR1110)
/*
 @{
    @"timeout":@"1",        //Unit:9s
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readLRPositioningTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the number of GPS search satellites.(LR1110)
/*
 @{
    @"number":@"7"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readLRStatelliteThresholdWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Read GPS data transfer format.(LR1110)
/*
 @{
    @"dataType":@"0",       //@"0":DAS   @"Customer"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readLRGPSDataTypeWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

///Read GPS positioning system.(LR1110)
/*
 @{
    @"type":@"0",       //@"0":GPS  @"1":Beidou     @"2":GPS+Beidou
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readLRPositioningSystemWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock;

///Whether reading auxiliary positioning is turned on (when turned off, the device will switch to automatic scanning and positioning).(LR1110)
/*
 @{
    @"isOn":@(YES),     //YES:Assisted positioning.  NO:Automatic scanning and positioning
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readLRAutonomousAidingWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

///Read auxiliary positioning latitude and longitude.(LR1110)
/*
 @{
     @"latitude":@"999999",         //0.00001
     @"longitude":@"-11111111111"   //0.00001
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readLRLatitudeLongitudeWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock;

///Read ephemeris start update notification status.(LR1110)
/*
 @{
    @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readLRNotifyOnEphemerisStartStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                              failedBlock:(void (^)(NSError *error))failedBlock;

///Read ephemeris end update notification status.(LR1110)
/*
 @{
    @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readLRNotifyOnEphemerisEndStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the filter status of the BXP Device Info.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readBXPDeviceInfoFilterStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the filter status of the BXP Button Info.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readBXPButtonFilterStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the Alarm Filter status of the BXP Button Info.
/*
 @{
     @"singlePresse":@(YES),
     @"doublePresse":@(YES),
     @"longPresse":@(YES),
     @"abnormal":@(YES),
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readBXPButtonAlarmFilterStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Bluetooth Fix Mechanism.
/*
 @{
    @"priority":@"0",       //@"0":Time Priority, @"1":Rssi Priority.
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readBluetoothFixMechanismWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark **************************************** LoRaWAN ************************************************
/// Read the current network status of LoRaWAN.
/*
    0:Connecting
    1:OTAA network access or ABP mode.
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readLorawanNetworkStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the region information of LoRaWAN.
/*
 0:AS923 
 1:AU915
 2:CN470
 3:CN779
 4:EU433
 5:EU868
 6:KR920
 7:IN865
 8:US915
 9:RU864
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readLorawanRegionWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Read LoRaWAN network access type.
/*
 1:ABP
 2:OTAA
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readLorawanModemWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the DEVEUI of LoRaWAN.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readLorawanDEVEUIWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the APPEUI of LoRaWAN.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readLorawanAPPEUIWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the APPKEY of LoRaWAN.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readLorawanAPPKEYWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the DEVADDR of LoRaWAN.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readLorawanDEVADDRWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the APPSKEY of LoRaWAN.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readLorawanAPPSKEYWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the NWKSKEY of LoRaWAN.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readLorawanNWKSKEYWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Read lorawan upstream data type.
/*
 0:Non-acknowledgement frame.
 1:Confirm the frame.
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readLorawanMessageTypeWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Read lorawan CH.It is only used for US915,AU915,CN470.
/*
 @{
 @"CHL":0
 @"CHH":2
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readLorawanCHWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Read lorawan DR.It is only used for CN470, CN779, EU433, EU868,KR920, IN865, RU864.
/*
 @{
 @"DR":1
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readLorawanDRWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Uplink Strategy  Of Lorawan.
/*
 @{
 @"isOn":@(isOn),
 @"transmissions":transmissions,
 @"DRL":DRL,            //DR For Payload Low.
 @"DRH":DRH,            //DR For Payload High.
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readLorawanUplinkStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Read lorawan duty cycle status.It is only used for EU868,CN779, EU433 and RU864.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readLorawanDutyCycleStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Read lorawan devtime command synchronization interval.(Hour)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readLorawanTimeSyncIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Network Check Interval Of Lorawan.(Hour)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readLorawanNetworkCheckIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Read The ADR ACK LIMIT Of Lorawan.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readLorawanADRACKLimitWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Read The ADR ACK DELAY Of Lorawan.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readLorawanADRACKDelayWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Read The Max retransmission times  Of Lorawan.(Only for the message type is confirmed.)
/*
 @{
 @"number":@"2"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readLorawanMaxRetransmissionTimesWithSucBlock:(void (^)(id returnData))sucBlock
                                             failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark ****************************************辅助功能************************************************

/// Read the Positioning Strategy Downlink  For Position.
/*
 @{
 @"strategy":@(1)
 }
 
 0:Wifi
 1:BLE
 2:GPS
 3:WIFI+GPS
 4:BLE+GPS
 5:WIFI+BLE
 6:WIFI+BLE+GPS
 
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readDownlinkPositioningStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError * error))failedBlock;

/// Read three-axis sensor wake-up conditions.
/*
 @{
     @"threshold":threshold,        //x 16mg
     @"duration":duration,          //x 10ms
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readThreeAxisWakeupConditionsWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Read three-axis data motion detection judgment parameters.
/*
 @{
     @"threshold":threshold,        //x 2mg
     @"duration":duration,          //x 5ms
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readThreeAxisMotionParametersWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the state of the Shock detection switch.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readShockDetectionStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the Shock detection threshold.
/*
 @{
     @"threshold":threshold,        //x 10mg
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readShockThresholdsWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the report interval of the Shock detection.(Unit:s)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readShockDetectionReportIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Shock Timeout.(Unit:s)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readShockTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Read  Man Down Detection.
/*
 @{
     @"isOn":@(YES)
 };
*/
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readManDownDetectionWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Idle Detection Timeout.(Unit:h)
/*
 @{
    @"interval":@"168"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readIdleDetectionTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Active State Count.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readActiveStateCountStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Active State Timeout.(Unit:s)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readActiveStateTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
