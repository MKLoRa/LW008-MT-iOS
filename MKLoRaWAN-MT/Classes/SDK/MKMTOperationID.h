
typedef NS_ENUM(NSInteger, mk_mt_taskOperationID) {
    mk_mt_defaultTaskOperationID,
    
#pragma mark - Read
    mk_mt_taskReadDeviceModelOperation,        //读取产品型号
    mk_mt_taskReadFirmwareOperation,           //读取固件版本
    mk_mt_taskReadHardwareOperation,           //读取硬件类型
    mk_mt_taskReadSoftwareOperation,           //读取软件版本
    mk_mt_taskReadManufacturerOperation,       //读取厂商信息
    mk_mt_taskReadDeviceTypeOperation,         //读取产品类型
    
#pragma mark - 密码特征
    mk_mt_connectPasswordOperation,             //连接设备时候发送密码
    
#pragma mark - 设备LoRa参数读取
    mk_mt_taskReadLorawanRegionOperation,           //读取LoRaWAN频段
    mk_mt_taskReadLorawanModemOperation,            //读取LoRaWAN入网类型
    mk_mt_taskReadLorawanNetworkStatusOperation,    //读取LoRaWAN网络状态
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
    mk_mt_taskReadLorawanMaxRetransmissionTimesOperation,   //读取LoRaWAN重传次数
    mk_mt_taskReadLorawanADRACKLimitOperation,              //读取ADR_ACK_LIMIT
    mk_mt_taskReadLorawanADRACKDelayOperation,              //读取ADR_ACK_DELAY
    
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
    mk_mt_taskConfigMaxRetransmissionTimesOperation,    //配置LoRaWAN的重传次数
    mk_mt_taskConfigLorawanADRACKLimitOperation,        //配置ADR_ACK_LIMIT
    mk_mt_taskConfigLorawanADRACKDelayOperation,        //配置ADR_ACK_DELAY
};
