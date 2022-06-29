//
//  MKMTAutonomousValueCell.h
//  MKLoRaWAN-MT_Example
//
//  Created by aa on 2022/6/10.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKMTAutonomousValueCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, copy)NSString *value;

@property (nonatomic, copy)NSString *placeholder;

@property (nonatomic, assign)NSInteger maxLength;

@end

@protocol MKMTAutonomousValueCellDelegate <NSObject>

- (void)mt_autonomousValueCellValueChanged:(NSString *)value index:(NSInteger)index;

@end

@interface MKMTAutonomousValueCell : MKBaseCell

@property (nonatomic, weak)id <MKMTAutonomousValueCellDelegate>delegate;

@property (nonatomic, strong)MKMTAutonomousValueCellModel *dataModel;

+ (MKMTAutonomousValueCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
