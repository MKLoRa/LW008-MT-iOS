//
//  MKMTLCGpsFixModel.h
//  MKLoRaWAN-MT_Example
//
//  Created by aa on 2022/6/10.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKMTLCGpsFixModel : NSObject

@property (nonatomic, copy)NSString *timeout;

@property (nonatomic, copy)NSString *pdop;

@property (nonatomic, assign)BOOL extrmeMode;

@end

NS_ASSUME_NONNULL_END
