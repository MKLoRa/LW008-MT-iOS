//
//  Target_LoRaWANMT_Module.m
//  MKLoRaWAN-MT_Example
//
//  Created by aa on 2022/6/9.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "Target_LoRaWANMT_Module.h"

#import "MKMTScanController.h"

#import "MKMTAboutController.h"

@implementation Target_LoRaWANMT_Module

/// 扫描页面
- (UIViewController *)Action_LoRaWANMT_Module_ScanController:(NSDictionary *)params {
    return [[MKMTScanController alloc] init];
}

/// 关于页面
- (UIViewController *)Action_LoRaWANMT_Module_AboutController:(NSDictionary *)params {
    return [[MKMTAboutController alloc] init];
}

@end
