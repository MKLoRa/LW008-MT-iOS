//
//  MKMTDebuggerCell.h
//  MKLoRaWAN-MT_Example
//
//  Created by aa on 2021/12/29.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKMTDebuggerCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *timeMsg;

@property (nonatomic, assign)BOOL selected;

@property (nonatomic, copy)NSString *logInfo;

@end

@protocol MKMTDebuggerCellDelegate <NSObject>

- (void)mt_debuggerCellSelectedChanged:(NSInteger)index selected:(BOOL)selected;

@end

@interface MKMTDebuggerCell : MKBaseCell

@property (nonatomic, strong)MKMTDebuggerCellModel *dataModel;

@property (nonatomic, weak)id <MKMTDebuggerCellDelegate>delegate;

+ (MKMTDebuggerCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
