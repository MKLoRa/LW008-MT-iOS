//
//  MKMTTimingModeAddCell.h
//  MKLoRaWAN-MT_Example
//
//  Created by aa on 2021/5/25.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKMTTimingModeAddCellModel : NSObject

@property (nonatomic, copy)NSString *msg;

@end

@protocol MKMTTimingModeAddCellDelegate <NSObject>

- (void)mt_addButtonPressed;

@end

@interface MKMTTimingModeAddCell : MKBaseCell

@property (nonatomic, strong)MKMTTimingModeAddCellModel *dataModel;

@property (nonatomic, weak)id <MKMTTimingModeAddCellDelegate>delegate;

+ (MKMTTimingModeAddCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
