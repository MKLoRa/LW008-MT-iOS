//
//  MKMTBleFixDataModel.h
//  MKLoRaWAN-MT_Example
//
//  Created by aa on 2022/3/16.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKMTBleFixDataModel : NSObject

/// 1~10
@property (nonatomic, copy)NSString *timeout;

/// 1~5
@property (nonatomic, copy)NSString *number;

/// @"0":Time Priority, @"1":Rssi Priority.
@property (nonatomic, assign)NSInteger priority;

/// -127~0
@property (nonatomic, assign)NSInteger rssi;

/// 0:1M PHY (BLE 4.x)      1:1M PHY (BLE 5)    2:1M PHY (BLE 4.x + BLE 5)     3:Coded PHY(BLE 5)
@property (nonatomic, assign)NSInteger phy;

/// @[@"Null",@"Only MAC",@"Only ADV Name",@"Only Raw Data",@"ADV Name & Raw Data",@"MAC & ADV Name & Raw Data",@"ADV Name | Raw Data"]
@property (nonatomic, assign)NSInteger relationship;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
