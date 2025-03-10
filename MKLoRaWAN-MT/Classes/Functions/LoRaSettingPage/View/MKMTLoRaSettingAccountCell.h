//
//  MKMTLoRaSettingAccountCell.h
//  MKLoRaWAN-MT_Example
//
//  Created by aa on 2025/3/3.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKMTLoRaSettingAccountCellModel : NSObject

@property (nonatomic, copy)NSString *account;

@end

@protocol MKMTLoRaSettingAccountCellDelegate <NSObject>

- (void)mt_loRaSettingAccountCell_logoutBtnPressed;

@end

@interface MKMTLoRaSettingAccountCell : MKBaseCell

@property (nonatomic, strong)MKMTLoRaSettingAccountCellModel *dataModel;

@property (nonatomic, weak)id <MKMTLoRaSettingAccountCellDelegate>delegate;

+ (MKMTLoRaSettingAccountCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
