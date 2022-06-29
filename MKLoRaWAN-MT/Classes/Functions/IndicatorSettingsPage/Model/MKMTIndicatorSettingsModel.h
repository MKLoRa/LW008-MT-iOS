//
//  MKMTIndicatorSettingsModel.h
//  MKLoRaWAN-MT_Example
//
//  Created by aa on 2021/5/27.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKMTSDKNormalDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKMTIndicatorSettingsModel : NSObject<mk_mt_indicatorSettingsProtocol>

@property (nonatomic, assign)BOOL LowPower;
@property (nonatomic, assign)BOOL NetworkCheck;
@property (nonatomic, assign)BOOL InFix;
@property (nonatomic, assign)BOOL FixSuccessful;
@property (nonatomic, assign)BOOL FailToFix;

//- (void)readWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;
//
//- (void)configWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
