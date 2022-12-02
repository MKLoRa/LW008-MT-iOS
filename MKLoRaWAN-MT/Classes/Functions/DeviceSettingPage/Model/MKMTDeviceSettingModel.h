//
//  MKMTDeviceSettingModel.h
//  MKLoRaWAN-MT_Example
//
//  Created by aa on 2022/3/15.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKMTDeviceSettingModel : NSObject

@property (nonatomic, assign)NSInteger timeZone;

@property (nonatomic, assign)BOOL shutdownPayload;

@property (nonatomic, assign)BOOL lowPowerPayload;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;


@end

NS_ASSUME_NONNULL_END
