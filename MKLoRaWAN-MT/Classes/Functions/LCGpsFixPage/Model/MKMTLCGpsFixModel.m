//
//  MKMTLCGpsFixModel.m
//  MKLoRaWAN-MT_Example
//
//  Created by aa on 2022/6/10.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKMTLCGpsFixModel.h"

#import "MKMacroDefines.h"

#import "MKMTInterface.h"
#import "MKMTInterface+MKMTConfig.h"

@interface MKMTLCGpsFixModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKMTLCGpsFixModel

#pragma mark - interfae
- (BOOL)readPositioningTimeout {
    __block BOOL success = NO;
    [MKMTInterface mt_readLRPositioningTimeoutWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.timeout = returnData[@"result"][@"timeout"];
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
        NSError *error = [[NSError alloc] initWithDomain:@"LCGpsFixParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

- (BOOL)validParams {
//    if (self.advName.length > 16) {
//        return NO;
//    }
//    if (!ValidStr(self.timeout) || [self.timeout integerValue] < 1 || [self.timeout integerValue] > 60) {
//        return NO;
//    }
    return YES;
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
        _readQueue = dispatch_queue_create("LCGpsFixQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
