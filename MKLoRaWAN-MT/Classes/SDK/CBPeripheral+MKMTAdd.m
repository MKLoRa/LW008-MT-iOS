//
//  CBPeripheral+MKMTAdd.m
//  MKLoRaWAN-MT_Example
//
//  Created by aa on 2022/6/9.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "CBPeripheral+MKMTAdd.h"

#import <objc/runtime.h>

static const char *mt_manufacturerKey = "mt_manufacturerKey";
static const char *mt_deviceModelKey = "mt_deviceModelKey";
static const char *mt_hardwareKey = "mt_hardwareKey";
static const char *mt_softwareKey = "mt_softwareKey";
static const char *mt_firmwareKey = "mt_firmwareKey";

static const char *mt_passwordKey = "mt_passwordKey";
static const char *mt_disconnectTypeKey = "mt_disconnectTypeKey";
static const char *mt_customKey = "mt_customKey";
static const char *mt_storageDataKey = "mt_storageDataKey";
static const char *mt_logKey = "mt_logKey";

static const char *mt_passwordNotifySuccessKey = "mt_passwordNotifySuccessKey";
static const char *mt_disconnectTypeNotifySuccessKey = "mt_disconnectTypeNotifySuccessKey";
static const char *mt_customNotifySuccessKey = "mt_customNotifySuccessKey";

@implementation CBPeripheral (MKMTAdd)

- (void)mt_updateCharacterWithService:(CBService *)service {
    NSArray *characteristicList = service.characteristics;
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"180A"]]) {
        //设备信息
        for (CBCharacteristic *characteristic in characteristicList) {
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A24"]]) {
                objc_setAssociatedObject(self, &mt_deviceModelKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A26"]]) {
                objc_setAssociatedObject(self, &mt_firmwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A27"]]) {
                objc_setAssociatedObject(self, &mt_hardwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A28"]]) {
                objc_setAssociatedObject(self, &mt_softwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A29"]]) {
                objc_setAssociatedObject(self, &mt_manufacturerKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        }
        return;
    }
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
        //自定义
        for (CBCharacteristic *characteristic in characteristicList) {
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
                objc_setAssociatedObject(self, &mt_passwordKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                [self setNotifyValue:YES forCharacteristic:characteristic];
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA01"]]) {
                objc_setAssociatedObject(self, &mt_disconnectTypeKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                [self setNotifyValue:YES forCharacteristic:characteristic];
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA02"]]) {
                objc_setAssociatedObject(self, &mt_customKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                [self setNotifyValue:YES forCharacteristic:characteristic];
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA03"]]) {
                objc_setAssociatedObject(self, &mt_storageDataKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA05"]]) {
                objc_setAssociatedObject(self, &mt_logKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        }
        return;
    }
}

- (void)mt_updateCurrentNotifySuccess:(CBCharacteristic *)characteristic {
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
        objc_setAssociatedObject(self, &mt_passwordNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA01"]]) {
        objc_setAssociatedObject(self, &mt_disconnectTypeNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA05"]]) {
        objc_setAssociatedObject(self, &mt_customNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
}

- (BOOL)mt_connectSuccess {
    if (![objc_getAssociatedObject(self, &mt_customNotifySuccessKey) boolValue] || ![objc_getAssociatedObject(self, &mt_passwordNotifySuccessKey) boolValue] || ![objc_getAssociatedObject(self, &mt_disconnectTypeNotifySuccessKey) boolValue]) {
        return NO;
    }
    if (!self.mt_manufacturer || !self.mt_deviceModel || !self.mt_hardware || !self.mt_software || !self.mt_firmware) {
        return NO;
    }
    if (!self.mt_password || !self.mt_disconnectType || !self.mt_custom || !self.mt_log || !self.mt_storageData) {
        return NO;
    }
    return YES;
}

- (void)mt_setNil {
    objc_setAssociatedObject(self, &mt_manufacturerKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &mt_deviceModelKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &mt_hardwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &mt_softwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &mt_firmwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, &mt_passwordKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &mt_disconnectTypeKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &mt_customKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &mt_storageDataKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &mt_logKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, &mt_passwordNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &mt_disconnectTypeNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &mt_customNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - getter

- (CBCharacteristic *)mt_manufacturer {
    return objc_getAssociatedObject(self, &mt_manufacturerKey);
}

- (CBCharacteristic *)mt_deviceModel {
    return objc_getAssociatedObject(self, &mt_deviceModelKey);
}

- (CBCharacteristic *)mt_hardware {
    return objc_getAssociatedObject(self, &mt_hardwareKey);
}

- (CBCharacteristic *)mt_software {
    return objc_getAssociatedObject(self, &mt_softwareKey);
}

- (CBCharacteristic *)mt_firmware {
    return objc_getAssociatedObject(self, &mt_firmwareKey);
}

- (CBCharacteristic *)mt_password {
    return objc_getAssociatedObject(self, &mt_passwordKey);
}

- (CBCharacteristic *)mt_disconnectType {
    return objc_getAssociatedObject(self, &mt_disconnectTypeKey);
}

- (CBCharacteristic *)mt_custom {
    return objc_getAssociatedObject(self, &mt_customKey);
}

- (CBCharacteristic *)mt_storageData {
    return objc_getAssociatedObject(self, &mt_storageDataKey);
}

- (CBCharacteristic *)mt_log {
    return objc_getAssociatedObject(self, &mt_logKey);
}

@end
