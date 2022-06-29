//
//  MKMTScanPageCell.h
//  MKLoRaWAN-MT_Example
//
//  Created by aa on 2022/6/9.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKMTScanPageCellDelegate <NSObject>

/// 连接按钮点击事件
/// @param index 当前cell的row
- (void)mt_scanCellConnectButtonPressed:(NSInteger)index;

@end

@class MKMTScanPageModel;
@interface MKMTScanPageCell : MKBaseCell

@property (nonatomic, strong)MKMTScanPageModel *dataModel;

@property (nonatomic, weak)id <MKMTScanPageCellDelegate>delegate;

+ (MKMTScanPageCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
