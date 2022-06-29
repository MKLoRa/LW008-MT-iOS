//
//  MKMTSynDataCell.h
//  MKLoRaWAN-MT_Example
//
//  Created by aa on 2021/6/19.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKMTSynDataCell : MKBaseCell

@property (nonatomic, strong)NSDictionary *dataModel;

+ (MKMTSynDataCell *)initCellWithTableView:(UITableView *)tableView;

+ (CGFloat)fetchCellHeight:(NSDictionary *)dataDic;

@end

NS_ASSUME_NONNULL_END
