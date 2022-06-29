//
//  MKMTFilterRelationshipCell.h
//  MKLoRaWAN-MT_Example
//
//  Created by aa on 2022/3/16.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKMTFilterRelationshipCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, assign)NSInteger dataListIndex;

@property (nonatomic, strong)NSArray *dataList;

@end

@protocol MKMTFilterRelationshipCellDelegate <NSObject>

- (void)mt_filterRelationshipChanged:(NSInteger)index dataListIndex:(NSInteger)dataListIndex;

@end

@interface MKMTFilterRelationshipCell : MKBaseCell

@property (nonatomic, strong)MKMTFilterRelationshipCellModel *dataModel;

@property (nonatomic, weak)id <MKMTFilterRelationshipCellDelegate>delegate;

+ (MKMTFilterRelationshipCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
