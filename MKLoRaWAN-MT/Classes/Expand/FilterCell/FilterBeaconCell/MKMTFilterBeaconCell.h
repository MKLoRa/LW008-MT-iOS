//
//  MKMTFilterBeaconCell.h
//  MKLoRaWAN-MT_Example
//
//  Created by aa on 2021/11/29.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKMTFilterBeaconCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, copy)NSString *minValue;

@property (nonatomic, copy)NSString *maxValue;

@end

@protocol MKMTFilterBeaconCellDelegate <NSObject>

- (void)mk_mt_beaconMinValueChanged:(NSString *)value index:(NSInteger)index;

- (void)mk_mt_beaconMaxValueChanged:(NSString *)value index:(NSInteger)index;

@end

@interface MKMTFilterBeaconCell : MKBaseCell

@property (nonatomic, strong)MKMTFilterBeaconCellModel *dataModel;

@property (nonatomic, weak)id <MKMTFilterBeaconCellDelegate>delegate;

+ (MKMTFilterBeaconCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
