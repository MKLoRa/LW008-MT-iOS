
typedef NS_ENUM(NSInteger, mk_mt_taskOperationID) {
    mk_mt_defaultTaskOperationID,
    
#pragma mark - Read
    mk_mt_taskReadDeviceModelOperation,        //读取产品型号
    mk_mt_taskReadFirmwareOperation,           //读取固件版本
    mk_mt_taskReadHardwareOperation,           //读取硬件类型
    mk_mt_taskReadSoftwareOperation,           //读取软件版本
    mk_mt_taskReadManufacturerOperation,       //读取厂商信息
    mk_mt_taskReadDeviceTypeOperation,         //读取产品类型
    
#pragma mark - 系统参数读取
    mk_mt_taskReadTimeZoneOperation,            //读取时区
    mk_mt_taskReadWorkModeOperation,            //读取工作模式
    mk_mt_taskReadIndicatorSettingsOperation,   //读取指示灯开关状态
    mk_mt_taskReadHeartbeatIntervalOperation,   //读取设备心跳间隔
    mk_mt_taskReadShutdownPayloadStatusOperation,   //读取关机信息上报状态
    mk_mt_taskReadOfflineFixStatusOperation,    //读取离线定位功能开关状态
    mk_mt_taskReadLowPowerPayloadStatusOperation,   //读取低电触发心跳开关状态
    mk_mt_taskReadLowPowerPromptOperation,          //读取低电百分比
    mk_mt_taskReadBatteryVoltageOperation,          //读取电池电量
    mk_mt_taskReadMacAddressOperation,              //读取mac地址
    mk_mt_taskReadPCBAStatusOperation,              //读取产测状态
    mk_mt_taskReadSelftestStatusOperation,          //读取自检故障原因
    mk_mt_taskReadBatteryInformationOperation,      //读取电池电量消耗
    
#pragma mark - 蓝牙参数读取
    mk_mt_taskReadConnectationNeedPasswordOperation,    //读取连接是否需要密码
    mk_mt_taskReadPasswordOperation,                    //读取连接密码
    mk_mt_taskReadBroadcastTimeoutOperation,            //读取蓝牙广播超时时间
    mk_mt_taskReadTxPowerOperation,                     //读取蓝牙TX Power
    mk_mt_taskReadDeviceNameOperation,                  //读取广播名称
    
#pragma mark - 模式相关参数读取
    mk_mt_taskReadPeriodicModePositioningStrategyOperation,         //读取定期模式定位策略
    mk_mt_taskReadPeriodicModeReportIntervalOperation,              //读取定期模式上报间隔
    mk_mt_taskReadTimingModePositioningStrategyOperation,           //读取定时模式定位策略
    mk_mt_taskReadTimingModeReportingTimePointOperation,            //读取定时模式时间点
    mk_mt_taskReadMotionModeEventsOperation,                        //读取运动模式事件
    mk_mt_taskReadMotionModeNumberOfFixOnStartOperation,            //读取运动开始定位上报次数
    mk_mt_taskReadMotionModePosStrategyOnStartOperation,            //读取运动开始定位策略
    mk_mt_taskReadMotionModeReportIntervalInTripOperation,          //读取运动中定位间隔
    mk_mt_taskReadMotionModePosStrategyInTripOperation,             //读取运动中定位策略
    mk_mt_taskReadMotionModeTripEndTimeoutOperation,                //读取运动结束判断时间
    mk_mt_taskReadMotionModeNumberOfFixOnEndOperation,              //读取运动结束定位次数
    mk_mt_taskReadMotionModeReportIntervalOnEndOperation,           //读取运动结束定位间隔
    mk_mt_taskReadMotionModePosStrategyOnEndOperation,              //读取运动结束定位策略
    mk_mt_taskReadDownlinkForPositioningStrategyOperation,          //读取下行请求定位策略
    
#pragma mark - 定位参数读取
    mk_mt_taskReadWifiDataTypeOperation,        //读取WIFI定位数据格式
    mk_mt_taskReadWifiPositioningTimeoutOperation,  //读取WIFI扫描超时时间
    mk_mt_taskReadWifiNumberOfBSSIDOperation,       //读取WIFI定位成功BSSID数量
    mk_mt_taskReadBlePositioningTimeoutOperation,   //读取蓝牙定位超时时间
    mk_mt_taskReadBlePositioningNumberOfMacOperation,   //读取蓝牙定位成功MAC数量
    mk_mt_taskReadRssiFilterValueOperation,             //读取RSSI过滤规则
    mk_mt_taskReadScanningPHYTypeOperation,             //读取蓝牙扫描PHY选择
    mk_mt_taskReadFilterRelationshipOperation,          //读取广播内容过滤逻辑
    mk_mt_taskReadFilterByMacPreciseMatchOperation, //读取精准过滤MAC开关
    mk_mt_taskReadFilterByMacReverseFilterOperation,    //读取反向过滤MAC开关
    mk_mt_taskReadFilterMACAddressListOperation,        //读取MAC过滤列表
    mk_mt_taskReadFilterByAdvNamePreciseMatchOperation, //读取精准过滤ADV Name开关
    mk_mt_taskReadFilterByAdvNameReverseFilterOperation,    //读取反向过滤ADV Name开关
    mk_mt_taskReadFilterAdvNameListOperation,           //读取ADV Name过滤列表
    mk_mt_taskReadFilterTypeStatusOperation,            //读取过滤设备类型开关
    mk_mt_taskReadFilterByBeaconStatusOperation,        //读取iBeacon类型过滤开关
    mk_mt_taskReadFilterByBeaconMajorRangeOperation,    //读取iBeacon类型Major范围
    mk_mt_taskReadFilterByBeaconMinorRangeOperation,    //读取iBeacon类型Minor范围
    mk_mt_taskReadFilterByBeaconUUIDOperation,          //读取iBeacon类型UUID
    mk_mt_taskReadFilterByBXPBeaconStatusOperation,      //读取BXP-iBeacon类型过滤开关
    mk_mt_taskReadFilterByBXPBeaconMajorRangeOperation,    //读取BXP-iBeacon类型Major范围
    mk_mt_taskReadFilterByBXPBeaconMinorRangeOperation,    //读取BXP-iBeacon类型Minor范围
    mk_mt_taskReadFilterByBXPBeaconUUIDOperation,          //读取BXP-iBeacon类型UUID
    mk_mt_taskReadFilterByBXPTagIDStatusOperation,         //读取BXP-TagID类型开关
    mk_mt_taskReadPreciseMatchTagIDStatusOperation,        //读取BXP-TagID类型精准过滤tagID开关
    mk_mt_taskReadReverseFilterTagIDStatusOperation,    //读取读取BXP-TagID类型反向过滤tagID开关
    mk_mt_taskReadFilterBXPTagIDListOperation,             //读取BXP-TagID过滤规则
    mk_mt_taskReadFilterByUIDStatusOperation,                //读取UID类型过滤开关
    mk_mt_taskReadFilterByUIDNamespaceIDOperation,           //读取UID类型过滤的Namespace ID
    mk_mt_taskReadFilterByUIDInstanceIDOperation,            //读取UID类型过滤的Instance ID
    mk_mt_taskReadFilterByURLStatusOperation,               //读取URL类型过滤开关
    mk_mt_taskReadFilterByURLContentOperation,              //读取URL过滤的内容
    mk_mt_taskReadFilterByTLMStatusOperation,               //读取TLM过滤开关
    mk_mt_taskReadFilterByTLMVersionOperation,              //读取TLM过滤类型
    mk_mt_taskReadBXPAccFilterStatusOperation,          //读取BeaconX Pro-ACC设备过滤开关
    mk_mt_taskReadBXPTHFilterStatusOperation,           //读取BeaconX Pro-T&H设备过滤开关
    mk_mt_taskReadFilterByOtherStatusOperation,         //读取Other过滤条件开关
    mk_mt_taskReadFilterByOtherRelationshipOperation,   //读取Other过滤条件的逻辑关系
    mk_mt_taskReadFilterByOtherConditionsOperation,     //读取Other的过滤条件列表
    mk_mt_taskReadLCPositioningTimeoutOperation,        //读取GPS定位超时时间(L76C)
    mk_mt_taskReadLCPDOPOperation,                      //读取GPSPDOP配置(L76C)
    mk_mt_taskReadLCGpsExtrmeModeStatusOperation,       //读取GPS极限上传模式
    mk_mt_taskReadLRPositioningTimeoutOperation,        //读取GPS定位超时时间(LR1110)
    mk_mt_taskReadLRStatelliteThresholdOperation,       //读取GPS搜星数量(LR1110)
    mk_mt_taskReadLRGPSDataTypeOperation,               //读取GPS定位数据格式(LR1110)
    mk_mt_taskReadLRPositioningSystemOperation,         //读取定位系统(LR1110)
    mk_mt_taskReadLRAutonomousAidingOperation,          //读取定位方式选择(LR1110)
    mk_mt_taskReadLRLatitudeLongitudeOperation,         //读取辅助定位经纬度(LR1110)
    mk_mt_taskReadLRNotifyOnEphemerisStartStatusOperation,  //读取星历开始更新事件开关(LR1110)
    mk_mt_taskReadLRNotifyOnEphemerisEndStatusOperation,    //读取星历结束更新事件开关(LR1110)
    mk_mt_taskReadBXPDeviceInfoFilterStatusOperation,       //读取BXP-DeviceInfo过滤条件开关
    mk_mt_taskReadBXPButtonFilterStatusOperation,           //读取BXP-Button过滤条件开关
    mk_mt_taskReadBXPButtonAlarmFilterStatusOperation,      //读取BXP-Button报警过滤开关
    mk_mt_taskReadBluetoothFixMechanismOperation,           //读取蓝牙定位机制选择
    
#pragma mark - 设备控制参数配置
    mk_mt_taskPowerOffOperation,                        //关机
    mk_mt_taskRestartDeviceOperation,                   //配置设备重新入网
    mk_mt_taskFactoryResetOperation,                    //设备恢复出厂设置
    mk_mt_taskConfigDeviceTimeOperation,                //配置时间戳
    mk_mt_taskConfigTimeZoneOperation,                  //配置时区
    mk_mt_taskConfigWorkModeOperation,                  //配置工作模式
    mk_mt_taskConfigIndicatorSettingsOperation,         //配置指示灯开关状态
    mk_mt_taskConfigHeartbeatIntervalOperation,         //配置设备心跳间隔
    mk_mt_taskConfigShutdownPayloadStatusOperation,     //配置关机信息上报状态
    mk_mt_taskConfigOfflineFixOperation,                //配置离线定位功能开关状态
    mk_mt_taskConfigLowPowerPayloadStatusOperation,     //配置低电触发心跳开关状态
    mk_mt_taskConfigLowPowerPromptOperation,            //配置低电百分比
    mk_mt_taskBatteryResetOperation,                    //清除电池电量数据
    
#pragma mark - 蓝牙参数配置
    mk_mt_taskConfigNeedPasswordOperation,              //配置是否需要连接密码
    mk_mt_taskConfigPasswordOperation,                  //配置连接密码
    mk_mt_taskConfigBroadcastTimeoutOperation,          //配置蓝牙广播超时时间
    mk_mt_taskConfigTxPowerOperation,                   //配置蓝牙TX Power
    mk_mt_taskConfigDeviceNameOperation,                //配置蓝牙广播名称
    
#pragma mark - 配置模式相关参数
    mk_mt_taskConfigPeriodicModePositioningStrategyOperation,       //配置定期模式定位策略
    mk_mt_taskConfigPeriodicModeReportIntervalOperation,            //配置定期模式上报间隔
    mk_mt_taskConfigTimingModePositioningStrategyOperation,         //配置定时模式定位策略
    mk_mt_taskConfigTimingModeReportingTimePointOperation,          //配置定时模式时间点
    mk_mt_taskConfigMotionModeEventsOperation,                      //配置运动模式事件
    mk_mt_taskConfigMotionModeNumberOfFixOnStartOperation,          //配置运动开始定位上报次数
    mk_mt_taskConfigMotionModePosStrategyOnStartOperation,          //配置运动开始定位策略
    mk_mt_taskConfigMotionModeReportIntervalInTripOperation,        //配置运动中定位间隔
    mk_mt_taskConfigMotionModePosStrategyInTripOperation,           //配置运动中定位策略
    mk_mt_taskConfigMotionModeTripEndTimeoutOperation,              //配置运动结束判断时间
    mk_mt_taskConfigMotionModeNumberOfFixOnEndOperation,            //配置运动结束定位次数
    mk_mt_taskConfigMotionModeReportIntervalOnEndOperation,         //配置运动结束定位间隔
    mk_mt_taskConfigMotionModePosStrategyOnEndOperation,            //配置运动结束定位策略
    mk_mt_taskConfigDownlinkForPositioningStrategyOperation,        //配置下行请求定位策略

#pragma mark - 定位参数配置
    mk_mt_taskConfigWifiDataTypeOperation,              //配置WIFI定位数据格式
    mk_mt_taskConfigWifiPositioningTimeoutOperation,    //配置WIFI扫描超时时间
    mk_mt_taskConfigWifiNumberOfBSSIDOperation,         //配置WIFI定位成功BSSID数量
    mk_mt_taskConfigBlePositioningTimeoutOperation,     //配置蓝牙定位超时时间
    mk_mt_taskConfigBlePositioningNumberOfMacOperation,     //配置蓝牙定位mac数量
    mk_mt_taskConfigRssiFilterValueOperation,           //配置rssi过滤规则
    mk_mt_taskConfigScanningPHYTypeOperation,           //配置蓝牙扫描PHY选择
    mk_mt_taskConfigFilterRelationshipOperation,        //配置广播内容过滤逻辑
    mk_mt_taskConfigFilterByMacPreciseMatchOperation,   //配置精准过滤MAC开关
    mk_mt_taskConfigFilterByMacReverseFilterOperation,  //配置反向过滤MAC开关
    mk_mt_taskConfigFilterMACAddressListOperation,      //配置MAC过滤规则
    mk_mt_taskConfigFilterByAdvNamePreciseMatchOperation,   //配置精准过滤Adv Name开关
    mk_mt_taskConfigFilterByAdvNameReverseFilterOperation,  //配置反向过滤Adv Name开关
    mk_mt_taskConfigFilterAdvNameListOperation,             //配置Adv Name过滤规则
    mk_mt_taskConfigFilterByBeaconStatusOperation,          //配置iBeacon类型过滤开关
    mk_mt_taskConfigFilterByBeaconMajorOperation,           //配置iBeacon类型过滤的Major范围
    mk_mt_taskConfigFilterByBeaconMinorOperation,           //配置iBeacon类型过滤的Minor范围
    mk_mt_taskConfigFilterByBeaconUUIDOperation,            //配置iBeacon类型过滤的UUID
    mk_mt_taskConfigFilterByBXPBeaconStatusOperation,          //配置BXP-iBeacon类型过滤开关
    mk_mt_taskConfigFilterByBXPBeaconMajorOperation,           //配置BXP-iBeacon类型过滤的Major范围
    mk_mt_taskConfigFilterByBXPBeaconMinorOperation,           //配置BXP-iBeacon类型过滤的Minor范围
    mk_mt_taskConfigFilterByBXPBeaconUUIDOperation,            //配置BXP-iBeacon类型过滤的UUID
    mk_mt_taskConfigFilterByBXPTagIDStatusOperation,            //配置BXP-TagID类型过滤开关
    mk_mt_taskConfigPreciseMatchTagIDStatusOperation,           //配置BXP-TagID类型精准过滤Tag-ID开关
    mk_mt_taskConfigReverseFilterTagIDStatusOperation,          //配置BXP-TagID类型反向过滤Tag-ID开关
    mk_mt_taskConfigFilterBXPTagIDListOperation,                //配置BXP-TagID过滤规则
    mk_mt_taskConfigFilterByUIDStatusOperation,                 //配置UID类型过滤的开关状态
    mk_mt_taskConfigFilterByUIDNamespaceIDOperation,            //配置UID类型过滤的Namespace ID
    mk_mt_taskConfigFilterByUIDInstanceIDOperation,             //配置UID类型过滤的Instance ID
    mk_mt_taskConfigFilterByURLStatusOperation,                 //配置URL类型过滤的开关状态
    mk_mt_taskConfigFilterByURLContentOperation,                //配置URL类型过滤的内容
    mk_mt_taskConfigFilterByTLMStatusOperation,                 //配置TLM过滤开关
    mk_mt_taskConfigFilterByTLMVersionOperation,                //配置TLM过滤数据类型
    mk_mt_taskConfigBXPAccFilterStatusOperation,            //配置BeaconX Pro-ACC设备过滤开关
    mk_mt_taskConfigBXPTHFilterStatusOperation,             //配置BeaconX Pro-TH设备过滤开关
    mk_mt_taskConfigFilterByOtherStatusOperation,           //配置Other过滤关系开关
    mk_mt_taskConfigFilterByOtherRelationshipOperation,     //配置Other过滤条件逻辑关系
    mk_mt_taskConfigFilterByOtherConditionsOperation,       //配置Other过滤条件列表
    mk_mt_taskConfigLCPositioningTimeoutOperation,          //配置GPS定位超时时间(L76C)
    mk_mt_taskConfigLCPDOPOperation,                        //配置PDOP(L76C)
    mk_mt_taskConfigLCGpsExtrmeModeStatusOperation,         //配置GPS极限上传模式(L76C)
    mk_mt_taskConfigLRPositioningTimeoutOperation,          //配置GPS定位超时时间(LR1110)
    mk_mt_taskConfigLRStatelliteThresholdOperation,         //配置GPS搜星数量(LR1110)
    mk_mt_taskConfigLRGPSDataTypeOperation,                 //配置GPS定位数据格式(LR1110)
    mk_mt_taskConfigLRPositioningSystemOperation,           //配置GPS定位星座(LR1110)
    mk_mt_taskConfigLRAutonomousAidingOperation,            //配置定位方式选择(LR1110)
    mk_mt_taskConfigLRLatitudeLongitudeOperation,           //配置辅助定位经纬度(LR1110)
    mk_mt_taskConfigLRNotifyOnEphemerisStartStatusOperation,    //配置星历开始更新事件开关(LR1110)
    mk_mt_taskConfigLRNotifyOnEphemerisEndStatusOperation,      //配置星历结束更新事件开关(LR1110)
    mk_mt_taskConfigFilterByBXPDeviceInfoStatusOperation,       //配置BXP-DeviceInfo过滤开关
    mk_mt_taskConfigFilterByBXPButtonStatusOperation,           //配置BXP-Button过滤开关
    mk_mt_taskConfigFilterByBXPButtonAlarmStatusOperation,      //配置BXP-Button类型过滤内容
    mk_mt_taskConfigBluetoothFixMechanismOperation,             //配置蓝牙定位机制
    
#pragma mark - 密码特征
    mk_mt_connectPasswordOperation,             //连接设备时候发送密码
    
#pragma mark - 设备LoRa参数读取
    mk_mt_taskReadLorawanNetworkStatusOperation,    //读取LoRaWAN网络状态
    mk_mt_taskReadLorawanRegionOperation,           //读取LoRaWAN频段
    mk_mt_taskReadLorawanModemOperation,            //读取LoRaWAN入网类型
    mk_mt_taskReadLorawanDEVEUIOperation,           //读取LoRaWAN DEVEUI
    mk_mt_taskReadLorawanAPPEUIOperation,           //读取LoRaWAN APPEUI
    mk_mt_taskReadLorawanAPPKEYOperation,           //读取LoRaWAN APPKEY
    mk_mt_taskReadLorawanDEVADDROperation,          //读取LoRaWAN DEVADDR
    mk_mt_taskReadLorawanAPPSKEYOperation,          //读取LoRaWAN APPSKEY
    mk_mt_taskReadLorawanNWKSKEYOperation,          //读取LoRaWAN NWKSKEY
    mk_mt_taskReadLorawanMessageTypeOperation,      //读取上行数据类型
    mk_mt_taskReadLorawanCHOperation,               //读取LoRaWAN CH
    mk_mt_taskReadLorawanDROperation,               //读取LoRaWAN DR
    mk_mt_taskReadLorawanUplinkStrategyOperation,   //读取LoRaWAN数据发送策略
    mk_mt_taskReadLorawanDutyCycleStatusOperation,  //读取dutycyle
    mk_mt_taskReadLorawanDevTimeSyncIntervalOperation,  //读取同步时间同步间隔
    mk_mt_taskReadLorawanNetworkCheckIntervalOperation, //读取网络确认间隔
    mk_mt_taskReadLorawanADRACKLimitOperation,              //读取ADR_ACK_LIMIT
    mk_mt_taskReadLorawanADRACKDelayOperation,              //读取ADR_ACK_DELAY
    mk_mt_taskReadLorawanMaxRetransmissionTimesOperation,   //读取LoRaWAN重传次数
    
#pragma mark - 辅助功能读取
    mk_mt_taskReadDownlinkPositioningStrategyOperation,     //读取下行请求定位策略
    mk_mt_taskReadThreeAxisWakeupConditionsOperation,       //读取三轴唤醒条件
    mk_mt_taskReadThreeAxisMotionParametersOperation,       //读取运动检测判断条件
    mk_mt_taskReadShockDetectionStatusOperation,            //读取震动检测状态
    mk_mt_taskReadShockThresholdsOperation,                 //读取震动检测阈值
    mk_mt_taskReadShockDetectionReportIntervalOperation,    //读取震动上法间隔
    mk_mt_taskReadShockTimeoutOperation,                    //读取震动次数判断间隔
    mk_mt_taskReadManDownDetectionOperation,                //读取闲置功能使能
    mk_mt_taskReadIdleDetectionTimeoutOperation,            //读取闲置超时时间
    mk_mt_taskReadActiveStateCountStatusOperation,          //读取活动记录使能
    mk_mt_taskReadActiveStateTimeoutOperation,              //读取活动判定间隔
    
#pragma mark - 设备LoRa参数配置
    mk_mt_taskConfigRegionOperation,                    //配置LoRaWAN的region
    mk_mt_taskConfigModemOperation,                     //配置LoRaWAN的入网类型
    mk_mt_taskConfigDEVEUIOperation,                    //配置LoRaWAN的devEUI
    mk_mt_taskConfigAPPEUIOperation,                    //配置LoRaWAN的appEUI
    mk_mt_taskConfigAPPKEYOperation,                    //配置LoRaWAN的appKey
    mk_mt_taskConfigDEVADDROperation,                   //配置LoRaWAN的DevAddr
    mk_mt_taskConfigAPPSKEYOperation,                   //配置LoRaWAN的APPSKEY
    mk_mt_taskConfigNWKSKEYOperation,                   //配置LoRaWAN的NwkSKey
    mk_mt_taskConfigMessageTypeOperation,               //配置LoRaWAN的message type
    mk_mt_taskConfigCHValueOperation,                   //配置LoRaWAN的CH值
    mk_mt_taskConfigDRValueOperation,                   //配置LoRaWAN的DR值
    mk_mt_taskConfigUplinkStrategyOperation,            //配置LoRaWAN数据发送策略
    mk_mt_taskConfigDutyCycleStatusOperation,           //配置LoRaWAN的duty cycle
    mk_mt_taskConfigTimeSyncIntervalOperation,          //配置LoRaWAN的同步指令间隔
    mk_mt_taskConfigNetworkCheckIntervalOperation,      //配置LoRaWAN的LinkCheckReq间隔
    mk_mt_taskConfigLorawanADRACKLimitOperation,        //配置ADR_ACK_LIMIT
    mk_mt_taskConfigLorawanADRACKDelayOperation,        //配置ADR_ACK_DELAY
    mk_mt_taskConfigMaxRetransmissionTimesOperation,    //配置LoRaWAN的重传次数
    
    
#pragma mark - 辅助功能配置
    mk_mt_taskConfigDownlinkPositioningStrategyyOperation,  //配置下行请求定位策略
    mk_mt_taskConfigThreeAxisWakeupConditionsOperation,         //配置三轴唤醒条件
    mk_mt_taskConfigThreeAxisMotionParametersOperation,         //配置运动检测判断
    mk_mt_taskConfigShockDetectionStatusOperation,          //配置震动检测使能
    mk_mt_taskConfigShockThresholdsOperation,               //配置震动检测阈值
    mk_mt_taskConfigShockDetectionReportIntervalOperation,  //配置震动上发间隔
    mk_mt_taskConfigShockTimeoutOperation,                  //配置震动次数判断间隔
    mk_mt_taskConfigManDownDetectionStatusOperation,            //配置闲置功能使能
    mk_mt_taskConfigIdleDetectionTimeoutOperation,              //配置闲置超时时间
    mk_mt_taskConfigIdleStutasResetOperation,                   //闲置状态清除
    mk_mt_taskConfigActiveStateCountStatusOperation,            //配置活动记录使能
    mk_mt_taskConfigActiveStateTimeoutOperation,                //配置活动判定间隔
    
#pragma mark - 存储数据协议
    mk_mt_taskReadNumberOfDaysStoredDataOperation,      //读取多少天本地存储的数据
    mk_mt_taskClearAllDatasOperation,                   //清除存储的所有数据
    mk_mt_taskPauseSendLocalDataOperation,              //暂停/恢复数据传输
};
