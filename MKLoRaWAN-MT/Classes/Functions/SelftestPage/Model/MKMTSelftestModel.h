//
//  MKMTSelftestModel.h
//  MKLoRaWAN-MT_Example
//
//  Created by aa on 2022/5/26.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKMTSelftestModel : NSObject

@property (nonatomic, copy)NSString *gps;

@property (nonatomic, copy)NSString *acceData;

@property (nonatomic, copy)NSString *flash;

@property (nonatomic, copy)NSString *pcbaStatus;

@property (nonatomic, copy)NSString *workTimes;

@property (nonatomic, copy)NSString *advCount;

@property (nonatomic, copy)NSString *flashOperationCount;

@property (nonatomic, copy)NSString *axisWakeupTimes;

@property (nonatomic, copy)NSString *blePostionTimes;

@property (nonatomic, copy)NSString *wifiPostionTimes;

@property (nonatomic, copy)NSString *gpsPostionTimes;

@property (nonatomic, copy)NSString *loraSendCount;

@property (nonatomic, copy)NSString *loraPowerConsumption;

@property (nonatomic, copy)NSString *batteryPower;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;;

@end

NS_ASSUME_NONNULL_END
