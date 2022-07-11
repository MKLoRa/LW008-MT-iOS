//
//  MKMTSDKDataAdopter.h
//  MKLoRaWAN-MT_Example
//
//  Created by aa on 2022/6/9.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKMTSDKNormalDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKMTSDKDataAdopter : NSObject

+ (NSString *)lorawanRegionString:(mk_mt_loraWanRegion)region;

+ (NSString *)fetchTxPower:(mk_mt_txPower)txPower;

/// 实际值转换为0dBm、4dBm等
/// @param content content
+ (NSString *)fetchTxPowerValueString:(NSString *)content;

+ (NSString *)fetchDataFormatString:(mk_mt_dataFormat)dataType;

+ (NSString *)fetchPHYTypeString:(mk_mt_PHYMode)mode;

/// 过滤的mac列表
/// @param content content
+ (NSArray <NSString *>*)parseFilterMacList:(NSString *)content;

/// 过滤的Adv Name列表
/// @param contentList contentList
+ (NSArray <NSString *>*)parseFilterAdvNameList:(NSArray <NSData *>*)contentList;

/// 过滤的url
/// @param contentList contentList
+ (NSString *)parseFilterUrlContent:(NSArray <NSData *>*)contentList;

/// 将协议中的数值对应到原型中去
/// @param other 协议中的数值
+ (NSString *)parseOtherRelationship:(NSString *)other;

/// 解析Other当前过滤条件列表
/// @param content content
+ (NSArray *)parseOtherFilterConditionList:(NSString *)content;

+ (NSString *)parseOtherRelationshipToCmd:(mk_mt_filterByOther)relationship;

+ (BOOL)isConfirmRawFilterProtocol:(id <mk_mt_BLEFilterRawDataProtocol>)protocol;

+ (NSString *)fetchDeviceModeValue:(mk_mt_deviceMode)deviceMode;

+ (NSArray <NSDictionary *>*)parseTimingModeReportingTimePoint:(NSString *)content;

+ (NSString *)fetchPositioningStrategyCommand:(mk_mt_positioningStrategy)strategy;

+ (NSString *)fetchTimingModeReportingTimePoint:(NSArray <mk_mt_timingModeReportingTimePointProtocol>*)dataList;

+ (NSDictionary *)fetchIndicatorSettings:(NSString *)content;

+ (NSString *)parseIndicatorSettingsCommand:(id <mk_mt_indicatorSettingsProtocol>)protocol;

@end

NS_ASSUME_NONNULL_END
