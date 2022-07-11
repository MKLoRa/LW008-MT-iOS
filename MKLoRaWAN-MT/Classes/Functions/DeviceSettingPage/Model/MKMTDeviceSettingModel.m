//
//  MKMTDeviceSettingModel.m
//  MKLoRaWAN-MT_Example
//
//  Created by aa on 2022/3/15.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKMTDeviceSettingModel.h"

#import "MKMacroDefines.h"

#import "MKMTInterface.h"

@interface MKMTDeviceSettingModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKMTDeviceSettingModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readTimeZone]) {
            [self operationFailedBlockWithMsg:@"Read Time Zone Error" block:failedBlock];
            return;
        }
        if (![self readLowPowerPrompt]) {
            [self operationFailedBlockWithMsg:@"Read Low Power Prompt Error" block:failedBlock];
            return;
        }
        if (![self readLowPowerPayload]) {
            [self operationFailedBlockWithMsg:@"Read Low Power Payload Error" block:failedBlock];
            return;
        }
        if (![self readShutdownPayload]) {
            [self operationFailedBlockWithMsg:@"Read Shutdown Payload Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

#pragma mark - interface
- (BOOL)readTimeZone {
    __block BOOL success = NO;
    [MKMTInterface mt_readTimeZoneWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.timeZone = [returnData[@"result"][@"timeZone"] integerValue] + 24;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readLowPowerPrompt {
    __block BOOL success = NO;
    [MKMTInterface mt_readLowPowerPromptWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.prompt = [returnData[@"result"][@"prompt"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readLowPowerPayload {
    __block BOOL success = NO;
    [MKMTInterface mt_readLowPowerPayloadStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.lowPowerPayload = [returnData[@"result"][@"isOn"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readShutdownPayload {
    __block BOOL success = NO;
    [MKMTInterface mt_readShutdownPayloadStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.shutdownPayload = [returnData[@"result"][@"isOn"] boolValue];
        
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

#pragma mark - private method
- (void)operationFailedBlockWithMsg:(NSString *)msg block:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        NSError *error = [[NSError alloc] initWithDomain:@"DeviceSettingParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

#pragma mark - getter
- (dispatch_semaphore_t)semaphore {
    if (!_semaphore) {
        _semaphore = dispatch_semaphore_create(0);
    }
    return _semaphore;
}

- (dispatch_queue_t)readQueue {
    if (!_readQueue) {
        _readQueue = dispatch_queue_create("DeviceSettingQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
