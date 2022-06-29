//
//  CBPeripheral+MKMTAdd.h
//  MKLoRaWAN-MT_Example
//
//  Created by aa on 2022/6/9.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>

NS_ASSUME_NONNULL_BEGIN

@interface CBPeripheral (MKMTAdd)

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *mt_manufacturer;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *mt_deviceModel;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *mt_hardware;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *mt_software;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *mt_firmware;

#pragma mark - custom

/// W/N
@property (nonatomic, strong, readonly)CBCharacteristic *mt_password;

/// N
@property (nonatomic, strong, readonly)CBCharacteristic *mt_disconnectType;

/// W/N
@property (nonatomic, strong, readonly)CBCharacteristic *mt_custom;

/// N
@property (nonatomic, strong, readonly)CBCharacteristic *mt_storageData;

/// N
@property (nonatomic, strong, readonly)CBCharacteristic *mt_log;

- (void)mt_updateCharacterWithService:(CBService *)service;

- (void)mt_updateCurrentNotifySuccess:(CBCharacteristic *)characteristic;

- (BOOL)mt_connectSuccess;

- (void)mt_setNil;

@end

NS_ASSUME_NONNULL_END
