//
//  MKMTInterface+MKMTConfig.h
//  MKLoRaWAN-MT_Example
//
//  Created by aa on 2022/6/9.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKMTInterface.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKMTInterface (MKMTConfig)

#pragma mark ****************************************System************************************************

/// Device shutdown.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_powerOffWithSucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Restart the device.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_restartDeviceWithSucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Reset.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_factoryResetWithSucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Sync device time.
/// @param timestamp UTC
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configDeviceTime:(unsigned long)timestamp
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the time zone of the device.
/// @param timeZone -24~28  //(The time zone is in units of 30 minutes, UTC-12:00~UTC+14:00.eg:timeZone = -23 ,--> UTC-11:30)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configTimeZone:(NSInteger)timeZone
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the working mode of the device.
/// @param deviceMode device mode
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configWorkMode:(mk_mt_deviceMode)deviceMode
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Indicator Settings.
/// @param protocol protocol.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configIndicatorSettings:(id <mk_mt_indicatorSettingsProtocol>)protocol
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Heartbeat Interval.
/// @param interval 300S~86400S
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configHeartbeatInterval:(NSInteger)interval
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Shutdown Payload Status.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configShutdownPayloadStatus:(BOOL)isOn
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

///  Whether to enable positioning when the device fails to connect to the Lorawan network.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configOfflineFix:(BOOL)isOn
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock;

///  Whether to trigger a heartbeat when the device is low on battery.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configLowPowerPayloadStatus:(BOOL)isOn
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// When the power of the device is lower than how much, it is judged as a low power state.
/// @param prompt prompt
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configLowPowerPrompt:(mk_mt_lowPowerPrompt)prompt
                       sucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark ****************************************蓝牙相关参数************************************************

/// Do you need a password when configuring the device connection.
/// @param need need
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configNeedPassword:(BOOL)need
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the connection password of device.
/// @param password 8-character ascii code
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configPassword:(NSString *)password
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the broadcast timeout time in Bluetooth configuration mode.
/// @param timeout 1Min~60Mins
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configBroadcastTimeout:(NSInteger)timeout
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the txPower of device.
/// @param txPower txPower
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configTxPower:(mk_mt_txPower)txPower
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the broadcast name of the device.
/// @param deviceName 0~16 ascii characters
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configDeviceName:(NSString *)deviceName
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark ****************************************模式相关参数************************************************

/// Configure Periodic Mode positioning strategy.
/// @param strategy strategy
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configPeriodicModePositioningStrategy:(mk_mt_positioningStrategy)strategy
                                        sucBlock:(void (^)(void))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Periodic Mode reporting interval.
/// @param interval 30s~86400s
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configPeriodicModeReportInterval:(long long)interval
                                   sucBlock:(void (^)(void))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Timing Mode positioning strategy.
/// @param strategy strategy
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configTimingModePositioningStrategy:(mk_mt_positioningStrategy)strategy
                                      sucBlock:(void (^)(void))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Timing Mode Reporting Time Point.
/// @param dataList up to 10 groups of filters.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configTimingModeReportingTimePoint:(NSArray <mk_mt_timingModeReportingTimePointProtocol>*)dataList
                                     sucBlock:(void (^)(void))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Motion Mode Events.
/// @param protocol protocol
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configMotionModeEvents:(id <mk_mt_motionModeEventsProtocol>)protocol
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Motion Mode Number Of Fix On Start.
/// @param number 1~255
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configMotionModeNumberOfFixOnStart:(NSInteger)number
                                     sucBlock:(void (^)(void))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Motion Mode Pos-Strategy On Start.
/// @param strategy strategy
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configMotionModePosStrategyOnStart:(mk_mt_positioningStrategy)strategy
                                     sucBlock:(void (^)(void))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Motion Mode Report Interval In Trip.
/// @param interval 10s~86400s
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configMotionModeReportIntervalInTrip:(long long)interval
                                       sucBlock:(void (^)(void))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Motion Mode Pos-Strategy In Trip.
/// @param strategy strategy
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configMotionModePosStrategyInTrip:(mk_mt_positioningStrategy)strategy
                                    sucBlock:(void (^)(void))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Motion Mode Trip End Timeout.
/// @param time 3~180(Unit:10s)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configMotionModeTripEndTimeout:(NSInteger)time
                                 sucBlock:(void (^)(void))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Motion Mode Number Of Fix On End.
/// @param number 1~255
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configMotionModeNumberOfFixOnEnd:(NSInteger)number
                                   sucBlock:(void (^)(void))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Motion Mode Report Interval On End.
/// @param interval 10s~300s
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configMotionModeReportIntervalOnEnd:(NSInteger)interval
                                      sucBlock:(void (^)(void))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Motion Mode Pos-Strategy On End.
/// @param strategy strategy
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configMotionModePosStrategyOnEnd:(mk_mt_positioningStrategy)strategy
                                   sucBlock:(void (^)(void))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;


#pragma mark ****************************************定位参数************************************************

/// Configure the WIFI positioning data format.
/// @param dataType format.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configWifiDataType:(mk_mt_dataFormat)dataType
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the WIFI positioning timeout.
/// @param interval 1~4.   unit : 2.5s.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configWifiPositioningTimeout:(NSInteger)interval
                               sucBlock:(void (^)(void))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the number of BSSIDs with successful WIFI positioning.
/// @param number 1~5.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configWifiNumberOfBSSID:(NSInteger)number
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Positioning Timeout Of Ble.
/// @param timeout 1s~10s
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configBlePositioningTimeout:(NSInteger)timeout
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// The number of MACs for Bluetooth positioning.
/// @param number 1~5
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configBlePositioningNumberOfMac:(NSInteger)number
                                  sucBlock:(void (^)(void))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// The device will uplink valid ADV data with RSSI no less than rssi dBm.
/// @param rssi -127 dBm ~ 0 dBm.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configRssiFilterValue:(NSInteger)rssi
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the Scanning Type/PHY.
/// @param mode mode
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configScanningPHYType:(mk_mt_PHYMode)mode
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Broadcast content filtering logic.
/// @param relationship relationship
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configFilterRelationship:(mk_mt_filterRelationship)relationship
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// A switch to accurately filter Mac addresses.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configFilterByMacPreciseMatch:(BOOL)isOn
                                sucBlock:(void (^)(void))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch for reverse filtering of MAC addresses.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configFilterByMacReverseFilter:(BOOL)isOn
                                 sucBlock:(void (^)(void))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Filtered list of mac addresses.
/// @param macList You can set up to 10 filters.1-6 Bytes.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configFilterMACAddressList:(NSArray <NSString *>*)macList
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// A switch to accurately filter Adv Name.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configFilterByAdvNamePreciseMatch:(BOOL)isOn
                                    sucBlock:(void (^)(void))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch for reverse filtering of Adv Name.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configFilterByAdvNameReverseFilter:(BOOL)isOn
                                     sucBlock:(void (^)(void))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Filtered list of Adv Name.
/// @param nameList You can set up to 10 filters.1-20 Characters.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configFilterAdvNameList:(NSArray <NSString *>*)nameList
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by iBeacon.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configFilterByBeaconStatus:(BOOL)isOn
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Major filter range of iBeacon.
/// @param isOn isOn
/// @param minValue 0~65535(isOn=YES)
/// @param maxValue minValue~65535(isOn=YES)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configFilterByBeaconMajor:(BOOL)isOn
                            minValue:(NSInteger)minValue
                            maxValue:(NSInteger)maxValue
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Minor filter range of iBeacon.
/// @param isOn isOn
/// @param minValue 0~65535(isOn=YES)
/// @param maxValue minValue~65535(isOn=YES)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configFilterByBeaconMinor:(BOOL)isOn
                            minValue:(NSInteger)minValue
                            maxValue:(NSInteger)maxValue
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// UUID status of filter by iBeacon.
/// @param uuid 0~16 Bytes.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configFilterByBeaconUUID:(NSString *)uuid
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by BXP-iBeacon.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configFilterByBXPBeaconStatus:(BOOL)isOn
                               sucBlock:(void (^)(void))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Major filter range of BXP-iBeacon.
/// @param isOn isOn
/// @param minValue 0~65535(isOn=YES)
/// @param maxValue minValue~65535(isOn=YES)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configFilterByBXPBeaconMajor:(BOOL)isOn
                              minValue:(NSInteger)minValue
                              maxValue:(NSInteger)maxValue
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Minor filter range of BXP-iBeacon.
/// @param isOn isOn
/// @param minValue 0~65535(isOn=YES)
/// @param maxValue minValue~65535(isOn=YES)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configFilterByBXPBeaconMinor:(BOOL)isOn
                              minValue:(NSInteger)minValue
                              maxValue:(NSInteger)maxValue
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// UUID status of filter by BXP-iBeacon.
/// @param uuid 0~16 Bytes.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configFilterByBXPBeaconUUID:(NSString *)uuid
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by BXP-TagID.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configFilterByBXPTagIDStatus:(BOOL)isOn
                               sucBlock:(void (^)(void))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Precise Match Tag ID.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configPreciseMatchTagIDStatus:(BOOL)isOn
                                sucBlock:(void (^)(void))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Reverse Filter Tag ID.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configReverseFilterTagIDStatus:(BOOL)isOn
                                 sucBlock:(void (^)(void))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Filtered list of BXP-TagID.
/// @param macList You can set up to 10 filters.1-6 Bytes.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configFilterBXPTagIDList:(NSArray <NSString *>*)tagIDList
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by UID.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configFilterByUIDStatus:(BOOL)isOn
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Namespace ID of filter by UID.
/// @param namespaceID 0~10 Bytes
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configFilterByUIDNamespaceID:(NSString *)namespaceID
                               sucBlock:(void (^)(void))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Instance ID of filter by UID.
/// @param instanceID 0~6 Bytes
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configFilterByUIDInstanceID:(NSString *)instanceID
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by URL.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configFilterByURLStatus:(BOOL)isOn
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Content of filter by URL.
/// @param content 0~100 Characters.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configFilterByURLContent:(NSString *)content
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by TLM.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configFilterByTLMStatus:(BOOL)isOn
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// TLM Version of filter by TLM.
/// @param version version
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configFilterByTLMVersion:(mk_mt_filterByTLMVersion)version
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// The filter status of the BeaconX Pro-ACC device.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configBXPAccFilterStatus:(BOOL)isOn
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// The filter status of the BeaconX Pro-T&H device.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configBXPTHFilterStatus:(BOOL)isOn
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by Other.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configFilterByOtherStatus:(BOOL)isOn
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Add logical relationships for up to three sets of filter conditions.
/// @param relationship relationship
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configFilterByOtherRelationship:(mk_mt_filterByOther)relationship
                                  sucBlock:(void (^)(void))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Current filter conditions.
/// @param conditions conditions
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configFilterByOtherConditions:(NSArray <mk_mt_BLEFilterRawDataProtocol>*)conditions
                                sucBlock:(void (^)(void))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure GPS positioning timeout.(L76C)
/// @param timeout 60s~600s
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configLCPositioningTimeout:(NSInteger)timeout
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// PDOP.(L76C)
/// @param pdop 25~100(Unit:0.1)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configLCPDOP:(NSInteger)pdop
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock;

/// GPS limit upload mode status.(L76C)
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configLCGpsExtrmeModeStatus:(BOOL)isOn
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure GPS positioning timeout.(LR1110)
/// @param timeout 1~5(x 9s)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configLRPositioningTimeout:(NSInteger)timeout
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the number of GPS search satellites.(LR1110)
/// @param threshold 4~10
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configLRStatelliteThreshold:(NSInteger)threshold
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure GPS data transfer format.(LR1110)
/// @param format format
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configLRGPSDataType:(mk_mt_dataFormat)format
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure GPS positioning system.(LR1110)
/// @param system system
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configLRPositioningSystem:(mk_mt_positioningSystem)system
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Whether reading auxiliary positioning is turned on (when turned off, the device will switch to automatic scanning and positioning).(LR1110)
/// @param aiding YES:Assisted positioning.   NO:Automatic scanning and positioning.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configLRAutonomousAiding:(BOOL)aiding
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure auxiliary positioning latitude and longitude.(LR1110)
/// @param latitude -9000000~9000000
/// @param longitude -18000000~18000000
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configLRLatitude:(NSInteger)latitude
                  longitude:(NSInteger)longitude
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure ephemeris start update notification status.(LR1110)
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configLRNotifyOnEphemerisStartStatus:(BOOL)isOn
                                       sucBlock:(void (^)(void))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure ephemeris end update notification status.(LR1110)
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configLRNotifyOnEphemerisEndStatus:(BOOL)isOn
                                     sucBlock:(void (^)(void))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by BXP Device Info.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configFilterByBXPDeviceInfoStatus:(BOOL)isOn
                                    sucBlock:(void (^)(void))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by BXP Button.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configFilterByBXPButtonStatus:(BOOL)isOn
                                sucBlock:(void (^)(void))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// BXP-Button type filter content.
/// @param singlePress Filter Single Press alarm message switch.
/// @param doublePress Filter Double Press alarm message switch
/// @param longPress Filter Long Press alarm message switch
/// @param abnormalInactivity Abnormal Inactivity
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configFilterByBXPButtonAlarmStatus:(BOOL)singlePress
                                  doublePress:(BOOL)doublePress
                                    longPress:(BOOL)longPress
                           abnormalInactivity:(BOOL)abnormalInactivity
                                     sucBlock:(void (^)(void))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Bluetooth Fix Mechanism.
/// @param priority priority
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configBluetoothFixMechanism:(mk_mt_bluetoothFixMechanism)priority
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark ****************************************设备lorawan信息设置************************************************

/// Configure the region information of LoRaWAN.
/// @param region region
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configRegion:(mk_mt_loraWanRegion)region
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure LoRaWAN network access type.
/// @param modem modem
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configModem:(mk_mt_loraWanModem)modem
              sucBlock:(void (^)(void))sucBlock
           failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the DEVEUI of LoRaWAN.
/// @param devEUI Hexadecimal characters, length must be 16.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configDEVEUI:(NSString *)devEUI
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the APPEUI of LoRaWAN.
/// @param appEUI Hexadecimal characters, length must be 16.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configAPPEUI:(NSString *)appEUI
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the APPKEY of LoRaWAN.
/// @param appKey Hexadecimal characters, length must be 32.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configAPPKEY:(NSString *)appKey
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the DEVADDR of LoRaWAN.
/// @param devAddr Hexadecimal characters, length must be 8.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configDEVADDR:(NSString *)devAddr
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the APPSKEY of LoRaWAN.
/// @param appSkey Hexadecimal characters, length must be 32.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configAPPSKEY:(NSString *)appSkey
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the NWKSKEY of LoRaWAN.
/// @param nwkSkey Hexadecimal characters, length must be 32.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configNWKSKEY:(NSString *)nwkSkey
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the message type of LoRaWAN.
/// @param messageType messageType
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configMessageType:(mk_mt_loraWanMessageType)messageType
                    sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the CH of LoRaWAN.It is only used for US915,AU915,CN470.
/// @param chlValue Minimum value of CH.0 ~ 95
/// @param chhValue Maximum value of CH. chlValue ~ 95
/// @param sucBlock Success callback
/// @param failedBlock  Failure callback
+ (void)mt_configCHL:(NSInteger)chlValue
                 CHH:(NSInteger)chhValue
            sucBlock:(void (^)(void))sucBlock
         failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the DR of LoRaWAN.It is only used for CN470, CN779, EU433, EU868,KR920, IN865, RU864.
/// @param drValue 0~5
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configDR:(NSInteger)drValue
           sucBlock:(void (^)(void))sucBlock
        failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure LoRaWAN uplink data sending strategy.
/// @param isOn ADR is on.
/// @param transmissions 1/2
/// @param DRL When the ADR switch is off, the range is 0~6.
/// @param DRH When the ADR switch is off, the range is DRL~6
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configUplinkStrategy:(BOOL)isOn
                  transmissions:(NSInteger)transmissions
                            DRL:(NSInteger)DRL
                            DRH:(NSInteger)DRH
                       sucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock;

/// It is only used for EU868,CN779, EU433 and RU864. Off: The uplink report interval will not be limit by region freqency. On:The uplink report interval will be limit by region freqency.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configDutyCycleStatus:(BOOL)isOn
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Time Sync Interval.
/// @param interval 0h~255h.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configTimeSyncInterval:(NSInteger)interval
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Network Check Interval Of Lorawan.
/// @param interval 0h~255h.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configLorawanNetworkCheckInterval:(NSInteger)interval
                                    sucBlock:(void (^)(void))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// The ADR ACK LIMIT Of Lorawan.
/// @param value 1~255
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configLorawanADRACKLimit:(NSInteger)value
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// The ADR ACK DELAY Of Lorawan.
/// @param value 1~255
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configLorawanADRACKDelay:(NSInteger)value
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure The Max retransmission times  Of Lorawan.(Only for the message type is confirmed.)
/// @param times 1~4
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configLorawanMaxRetransmissionTimes:(NSInteger)times
                                      sucBlock:(void (^)(void))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark ****************************************辅助功能************************************************

/// Configure the Positioning Strategy Downlink  For Position.
/// @param strategy strategy
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configDownlinkPositioningStrategy:(mk_mt_positioningStrategy)strategy
                                    sucBlock:(void (^)(void))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure three-axis sensor wake-up conditions.
/// @param threshold 1 x 16ms ~20 x 16ms
/// @param duration 1 x 10ms ~ 10 x 10ms
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configThreeAxisWakeupConditions:(NSInteger)threshold
                                  duration:(NSInteger)duration
                                  sucBlock:(void (^)(void))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure three-axis data motion detection judgment parameters.
/// @param threshold 10 x 2mg ~ 250 x 2mg
/// @param duration 1 x 5ms ~ 50 x 5ms
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configThreeAxisMotionParameters:(NSInteger)threshold
                                  duration:(NSInteger)duration
                                  sucBlock:(void (^)(void))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the state of the Shock detection switch.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configShockDetectionStatus:(BOOL)isOn
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the Shock detection threshold.
/// @param threshold 10 x 10mg ~ 255 x 10mg
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configShockThresholds:(NSInteger)threshold
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the report interval of the Shock detection.
/// @param interval 3s~255s
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configShockDetectionReportInterval:(NSInteger)interval
                                     sucBlock:(void (^)(void))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Shock Timeout.
/// @param interval 1s~20s
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configShockTimeout:(NSInteger)interval
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure  Man Down Detection.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configManDownDetectionStatus:(BOOL)isOn
                               sucBlock:(void (^)(void))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Idle Detection Timeout.
/// @param interval 1h~8760h
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configIdleDetectionTimeout:(NSInteger)interval
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Clear the idle state of the device.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configIdleStutasResetWithSucBlock:(void (^)(void))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Active State Count.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configActiveStateCountStatus:(BOOL)isOn
                               sucBlock:(void (^)(void))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Active State Timeout.
/// @param interval 1s~86400s
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_configActiveStateTimeout:(long long)interval
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark ****************************************存储协议************************************************
/// Read the data stored by the device every day.
/// @param days 1 ~ 65535
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_readNumberOfDaysStoredData:(NSInteger)days
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Clear all data stored in the device.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_clearAllDatasWithSucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Pause/resume data transmission of local data.
/// @param pause YES:pause,NO:resume
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mt_pauseSendLocalData:(BOOL)pause
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
