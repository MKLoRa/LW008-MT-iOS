//
//  MKMTPeripheral.m
//  MKLoRaWAN-MT_Example
//
//  Created by aa on 2022/6/9.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKMTPeripheral.h"

#import <CoreBluetooth/CoreBluetooth.h>

#import "CBPeripheral+MKMTAdd.h"

@interface MKMTPeripheral ()

@property (nonatomic, strong)CBPeripheral *peripheral;

@end

@implementation MKMTPeripheral

- (instancetype)initWithPeripheral:(CBPeripheral *)peripheral {
    if (self = [super init]) {
        self.peripheral = peripheral;
    }
    return self;
}

- (void)discoverServices {
    NSArray *services = @[[CBUUID UUIDWithString:@"180F"],  //电池电量
                          [CBUUID UUIDWithString:@"180A"],  //厂商信息
                          [CBUUID UUIDWithString:@"AA00"]]; //自定义
    [self.peripheral discoverServices:services];
}

- (void)discoverCharacteristics {
    for (CBService *service in self.peripheral.services) {
        if ([service.UUID isEqual:[CBUUID UUIDWithString:@"180F"]]) {
            [self.peripheral discoverCharacteristics:@[[CBUUID UUIDWithString:@"2A19"]] forService:service];
        }else if ([service.UUID isEqual:[CBUUID UUIDWithString:@"180A"]]) {
            NSArray *characteristics = @[[CBUUID UUIDWithString:@"2A24"],
                                         [CBUUID UUIDWithString:@"2A26"],[CBUUID UUIDWithString:@"2A27"],
                                         [CBUUID UUIDWithString:@"2A28"],[CBUUID UUIDWithString:@"2A29"]];
            [self.peripheral discoverCharacteristics:characteristics forService:service];
        }else if ([service.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
            NSArray *characteristics = @[[CBUUID UUIDWithString:@"AA00"],[CBUUID UUIDWithString:@"AA01"],
                                         [CBUUID UUIDWithString:@"AA02"],[CBUUID UUIDWithString:@"AA03"],
                                         [CBUUID UUIDWithString:@"AA05"]];
            [self.peripheral discoverCharacteristics:characteristics forService:service];
        }
    }
}

- (void)updateCharacterWithService:(CBService *)service {
    [self.peripheral mt_updateCharacterWithService:service];
}

- (void)updateCurrentNotifySuccess:(CBCharacteristic *)characteristic {
    [self.peripheral mt_updateCurrentNotifySuccess:characteristic];
}

- (BOOL)connectSuccess {
    return [self.peripheral mt_connectSuccess];
}

- (void)setNil {
    [self.peripheral mt_setNil];
}

@end
