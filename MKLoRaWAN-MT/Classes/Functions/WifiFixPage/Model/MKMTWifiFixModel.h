//
//  MKMTWifiFixModel.h
//  MKLoRaWAN-MT_Example
//
//  Created by aa on 2022/6/10.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKMTWifiFixModel : NSObject

@property (nonatomic, copy)NSString *timeout;

@property (nonatomic, copy)NSString *number;

/// 0:DAS   1:Customer
@property (nonatomic, assign)NSInteger dataType;

- (void)readWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
