#pragma mark ****************************************Enumerate************************************************

#pragma mark - MKMTCentralManager

typedef NS_ENUM(NSInteger, mk_mt_centralConnectStatus) {
    mk_mt_centralConnectStatusUnknow,                                           //未知状态
    mk_mt_centralConnectStatusConnecting,                                       //正在连接
    mk_mt_centralConnectStatusConnected,                                        //连接成功
    mk_mt_centralConnectStatusConnectedFailed,                                  //连接失败
    mk_mt_centralConnectStatusDisconnect,
};

typedef NS_ENUM(NSInteger, mk_mt_centralManagerStatus) {
    mk_mt_centralManagerStatusUnable,                           //不可用
    mk_mt_centralManagerStatusEnable,                           //可用状态
};

typedef NS_ENUM(NSInteger, mk_mt_deviceMode) {
    mk_mt_deviceMode_standbyMode,         //Standby mode
    mk_mt_deviceMode_timingMode,          //Timing mode
    mk_mt_deviceMode_periodicMode,        //Periodic mode
    mk_mt_deviceMode_motionMode,          //Motion Mode
};

typedef NS_ENUM(NSInteger, mk_mt_lowPowerPrompt) {
    mk_mt_lowPowerPrompt_fivePercent,
    mk_mt_lowPowerPrompt_tenPercent
};

typedef NS_ENUM(NSInteger, mk_mt_positioningStrategy) {
    mk_mt_positioningStrategy_wifi,
    mk_mt_positioningStrategy_ble,
    mk_mt_positioningStrategy_gps,
    mk_mt_positioningStrategy_wifiAndGps,
    mk_mt_positioningStrategy_bleAndGps,
    mk_mt_positioningStrategy_wifiAndBle,
    mk_mt_positioningStrategy_wifiAndBleAndGps,
};

typedef NS_ENUM(NSInteger, mk_mt_filterRelationship) {
    mk_mt_filterRelationship_null,
    mk_mt_filterRelationship_mac,
    mk_mt_filterRelationship_advName,
    mk_mt_filterRelationship_rawData,
    mk_mt_filterRelationship_advNameAndRawData,
    mk_mt_filterRelationship_macAndadvNameAndRawData,
    mk_mt_filterRelationship_advNameOrRawData,
};

typedef NS_ENUM(NSInteger, mk_mt_filterByTLMVersion) {
    mk_mt_filterByTLMVersion_null,             //Do not filter data.
    mk_mt_filterByTLMVersion_0,                //Unencrypted TLM data.
    mk_mt_filterByTLMVersion_1,                //Encrypted TLM data.
};

typedef NS_ENUM(NSInteger, mk_mt_filterByOther) {
    mk_mt_filterByOther_A,                 //Filter by A condition.
    mk_mt_filterByOther_AB,                //Filter by A & B condition.
    mk_mt_filterByOther_AOrB,              //Filter by A | B condition.
    mk_mt_filterByOther_ABC,               //Filter by A & B & C condition.
    mk_mt_filterByOther_ABOrC,             //Filter by (A & B) | C condition.
    mk_mt_filterByOther_AOrBOrC,           //Filter by A | B | C condition.
};

typedef NS_ENUM(NSInteger, mk_mt_dataFormat) {
    mk_mt_dataFormat_DAS,
    mk_mt_dataFormat_Custome,
};

typedef NS_ENUM(NSInteger, mk_mt_PHYMode) {
    mk_mt_PHYMode_BLE4,                     //1M PHY (BLE 4.x)
    mk_mt_PHYMode_BLE5,                     //1M PHY (BLE 5)
    mk_mt_PHYMode_BLE4AndBLE5,              //1M PHY (BLE 4.x + BLE 5)
    mk_mt_PHYMode_CodedBLE5,                //Coded PHY(BLE 5)
};

typedef NS_ENUM(NSInteger, mk_mt_loraWanRegion) {
    mk_mt_loraWanRegionAS923,
    mk_mt_loraWanRegionAU915,
    mk_mt_loraWanRegionCN470,
    mk_mt_loraWanRegionCN779,
    mk_mt_loraWanRegionEU433,
    mk_mt_loraWanRegionEU868,
    mk_mt_loraWanRegionKR920,
    mk_mt_loraWanRegionIN865,
    mk_mt_loraWanRegionUS915,
    mk_mt_loraWanRegionRU864,
};

typedef NS_ENUM(NSInteger, mk_mt_loraWanModem) {
    mk_mt_loraWanModemABP,
    mk_mt_loraWanModemOTAA,
};

typedef NS_ENUM(NSInteger, mk_mt_loraWanMessageType) {
    mk_mt_loraWanUnconfirmMessage,          //Non-acknowledgement frame.
    mk_mt_loraWanConfirmMessage,            //Confirm the frame.
};

typedef NS_ENUM(NSInteger, mk_mt_txPower) {
    mk_mt_txPowerNeg40dBm,   //RadioTxPower:-40dBm
    mk_mt_txPowerNeg20dBm,   //-20dBm
    mk_mt_txPowerNeg16dBm,   //-16dBm
    mk_mt_txPowerNeg12dBm,   //-12dBm
    mk_mt_txPowerNeg8dBm,    //-8dBm
    mk_mt_txPowerNeg4dBm,    //-4dBm
    mk_mt_txPower0dBm,       //0dBm
    mk_mt_txPower2dBm,       //2dBm
    mk_mt_txPower3dBm,       //3dBm
    mk_mt_txPower4dBm,       //4dBm
    mk_mt_txPower5dBm,       //5dBm
    mk_mt_txPower6dBm,       //6dBm
    mk_mt_txPower7dBm,       //7dBm
    mk_mt_txPower8dBm,       //8dBm
};

@protocol mk_mt_indicatorSettingsProtocol <NSObject>

@property (nonatomic, assign)BOOL LowPower;
@property (nonatomic, assign)BOOL NetworkCheck;
@property (nonatomic, assign)BOOL InFix;
@property (nonatomic, assign)BOOL FixSuccessful;
@property (nonatomic, assign)BOOL FailToFix;

@end

@protocol mk_mt_timingModeReportingTimePointProtocol <NSObject>

/// 0~23
@property (nonatomic, assign)NSInteger hour;

/// 0:00   1:15   2:30   3:45
@property (nonatomic, assign)NSInteger minuteGear;

@end

@protocol mk_mt_motionModeEventsProtocol <NSObject>

@property (nonatomic, assign)BOOL notifyEventOnStart;

@property (nonatomic, assign)BOOL fixOnStart;

@property (nonatomic, assign)BOOL notifyEventInTrip;

@property (nonatomic, assign)BOOL fixInTrip;

@property (nonatomic, assign)BOOL notifyEventOnEnd;

@property (nonatomic, assign)BOOL fixOnEnd;

@end

@protocol mk_mt_BLEFilterRawDataProtocol <NSObject>

/// The currently filtered data type, refer to the definition of different Bluetooth data types by the International Bluetooth Organization, 1 byte of hexadecimal data
@property (nonatomic, copy)NSString *dataType;

/// Data location to start filtering.
@property (nonatomic, assign)NSInteger minIndex;

/// Data location to end filtering.
@property (nonatomic, assign)NSInteger maxIndex;

/// The currently filtered content. If minIndex==0,maxIndex must be 0.The data length should be maxIndex-minIndex, if maxIndex=0&&minIndex==0, the item length is not checked whether it meets the requirements.MAX length:29 Bytes
@property (nonatomic, copy)NSString *rawData;

@end

#pragma mark ****************************************Delegate************************************************

@protocol mk_mt_centralManagerScanDelegate <NSObject>

/// Scan to new device.
/// @param deviceModel device
/*
 @{
 @"rssi":@(-55),
 @"peripheral":peripheral,
 @"deviceName":@"LW008-MT",
 
 @"deviceType":@"00",           //@"00":LR1110  @"01":L76
 @"txPower":@(-55),             //dBm
 @"deviceState":@"0",           //0 (Standby Mode), 1 (Timing Mode), 2 (Periodic Mode), 3 (Motion Mode)
 @"lowPower":@(lowPower),       //Whether the device is in a low battery state.
 @"needPassword":@(YES),
 @"idle":@(NO),               //Whether the device is idle.
 @"move":@(YES),               //Whether there is any movement from the last lora payload to the current broadcast moment (for example, 0 means no movement, 1 means movement).
 @"voltage":@"3.333",           //V
 @"macAddress":@"AA:BB:CC:DD:EE:FF",
 @"connectable":advDic[CBAdvertisementDataIsConnectable],
 }
 */
- (void)mk_mt_receiveDevice:(NSDictionary *)deviceModel;

@optional

/// Starts scanning equipment.
- (void)mk_mt_startScan;

/// Stops scanning equipment.
- (void)mk_mt_stopScan;

@end

@protocol mk_mt_storageDataDelegate <NSObject>

- (void)mk_mt_receiveStorageData:(NSString *)content;

@end


@protocol mk_mt_centralManagerLogDelegate <NSObject>

- (void)mk_mt_receiveLog:(NSString *)deviceLog;

@end
