//
//  MKMTDevEUICell.h
//  MKLoRaWAN-MT_Example
//
//  Created by aa on 2025/3/5.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKMTDevEUICellModel : NSObject

@property (nonatomic, copy)NSString *devEUI;

@end

@interface MKMTDevEUICell : MKBaseCell

@property (nonatomic, strong)MKMTDevEUICellModel *dataModel;

+ (MKMTDevEUICell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
