//
//  MKMTSelftestController.m
//  MKLoRaWAN-MT_Example
//
//  Created by aa on 2022/5/26.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKMTSelftestController.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"

#import "MKHudManager.h"
#import "MKAlertController.h"
#import "MKTableSectionLineHeader.h"

#import "MKMTInterface+MKMTConfig.h"

#import "MKMTSelftestModel.h"

#import "MKMTSelftestCell.h"
#import "MKMTPCBAStatusCell.h"
#import "MKMTBatteryInfoCell.h"
#import "MKButtonMsgCell.h"

@interface MKMTSelftestController ()<UITableViewDelegate,
UITableViewDataSource,
MKButtonMsgCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)NSMutableArray *section2List;

@property (nonatomic, strong)NSMutableArray *section3List;

@property (nonatomic, strong)NSMutableArray *headerList;

@property (nonatomic, strong)MKMTSelftestModel *dataModel;

@end

@implementation MKMTSelftestController

- (void)dealloc {
    NSLog(@"MKMTSelftestController销毁");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self readDataFromDevice];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 60.f;
    }
    if (indexPath.section == 2) {
        return 300.f;
    }
    if (indexPath.section == 3) {
        MKButtonMsgCellModel *cellModel = self.section3List[indexPath.row];
        return [cellModel cellHeightWithContentWidth:kViewWidth];
    }
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MKTableSectionLineHeader *headerView = [MKTableSectionLineHeader initHeaderViewWithTableView:tableView];
    headerView.headerModel = self.headerList[section];
    return headerView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.headerList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.section0List.count;
    }
    if (section == 1) {
        return self.section1List.count;
    }
    if (section == 2) {
        return self.section2List.count;
    }
    if (section == 3) {
        return self.section3List.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MKMTSelftestCell *cell = [MKMTSelftestCell initCellWithTableView:tableView];
        cell.dataModel = self.section0List[indexPath.row];
        return cell;
    }
    if (indexPath.section == 1) {
        MKMTPCBAStatusCell *cell = [MKMTPCBAStatusCell initCellWithTableView:tableView];
        cell.dataModel = self.section1List[indexPath.row];
        return cell;
    }
    if (indexPath.section == 2) {
        MKMTBatteryInfoCell *cell = [MKMTBatteryInfoCell initCellWithTableView:tableView];
        cell.dataModel = self.section2List[indexPath.row];
        return cell;
    }
    MKButtonMsgCell *cell = [MKButtonMsgCell initCellWithTableView:tableView];
    cell.dataModel = self.section3List[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - MKButtonMsgCellDelegate
/// 右侧按钮点击事件
/// @param index 当前cell所在index
- (void)mk_buttonMsgCellButtonPressed:(NSInteger)index {
    if (index == 0) {
        //Battery Reset
        [self batteryReset];
        return;
    }
}

#pragma mark - interface
- (void)readDataFromDevice {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel readDataWithSucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        [self loadSectionDatas];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - 清除电池数据
- (void)batteryReset {
    NSString *msg = @"Are you sure to reset battery?";
    MKAlertController *alertView = [MKAlertController alertControllerWithTitle:@"Warning!"
                                                                       message:msg
                                                                preferredStyle:UIAlertControllerStyleAlert];
    alertView.notificationName = @"mk_mt_needDismissAlert";
    @weakify(self);
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertView addAction:cancelAction];
    
    UIAlertAction *moreAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        [self sendBatteryResetCommandToDevice];
    }];
    [alertView addAction:moreAction];
    
    [self presentViewController:alertView animated:YES completion:nil];
}

- (void)sendBatteryResetCommandToDevice {
    [[MKHudManager share] showHUDWithTitle:@"Setting..."
                                     inView:self.view
                              isPenetration:NO];
    [MKMTInterface mt_batteryResetWithSucBlock:^{
        [[MKHudManager share] hide];
        [self reloadBatteryDatas];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)reloadBatteryDatas {
    [[MKHudManager share] showHUDWithTitle:@"Reading..."
                                     inView:self.view
                              isPenetration:NO];
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel readDataWithSucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        MKMTBatteryInfoCellModel *cellModel = self.section2List[0];
        cellModel.workTimes = self.dataModel.workTimes;
        cellModel.advCount = self.dataModel.advCount;
        cellModel.flashOperationCount = self.dataModel.flashOperationCount;
        cellModel.axisWakeupTimes = self.dataModel.axisWakeupTimes;
        cellModel.blePostionTimes = self.dataModel.blePostionTimes;
        cellModel.wifiPostionTimes = self.dataModel.wifiPostionTimes;
        cellModel.gpsPostionTimes = self.dataModel.gpsPostionTimes;
        cellModel.loraSendCount = self.dataModel.loraSendCount;
        cellModel.loraPowerConsumption = self.dataModel.loraPowerConsumption;
        cellModel.batteryPower = self.dataModel.batteryPower;
        
        [self.tableView mk_reloadSection:2 withRowAnimation:UITableViewRowAnimationNone];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - loadSections
- (void)loadSectionDatas {
    [self loadSection0Datas];
    [self loadSection1Datas];
    [self loadSection2Datas];
    [self loadSection3Datas];
    
    for (NSInteger i = 0; i < 4; i ++) {
        MKTableSectionLineHeaderModel *headerModel = [[MKTableSectionLineHeaderModel alloc] init];
        [self.headerList addObject:headerModel];
    }
    
    [self.tableView reloadData];
}

- (void)loadSection0Datas {
    MKMTSelftestCellModel *cellModel = [[MKMTSelftestCellModel alloc] init];
    if ([self.dataModel.gps integerValue] == 0 && [self.dataModel.acceData integerValue] == 0 && [self.dataModel.flash integerValue] == 0) {
        cellModel.value0 = @"0";
    }
    cellModel.value1 = ([self.dataModel.flash integerValue] == 1 ? @"1" : @"");
    cellModel.value2 = ([self.dataModel.acceData integerValue] == 1 ? @"2" : @"");
    cellModel.value3 = ([self.dataModel.gps integerValue] == 1 ? @"3" : @"");
    
    [self.section0List addObject:cellModel];
}

- (void)loadSection1Datas {
    MKMTPCBAStatusCellModel *cellModel = [[MKMTPCBAStatusCellModel alloc] init];
    cellModel.value0 = (([self.dataModel.pcbaStatus integerValue] == 0) ? @"0" : @"");
    cellModel.value1 = (([self.dataModel.pcbaStatus integerValue] == 1) ? @"1" : @"");
    cellModel.value2 = (([self.dataModel.pcbaStatus integerValue] == 2) ? @"2" : @"");
    [self.section1List addObject:cellModel];
}

- (void)loadSection2Datas {
    MKMTBatteryInfoCellModel *cellModel = [[MKMTBatteryInfoCellModel alloc] init];
    cellModel.workTimes = self.dataModel.workTimes;
    cellModel.advCount = self.dataModel.advCount;
    cellModel.flashOperationCount = self.dataModel.flashOperationCount;
    cellModel.axisWakeupTimes = self.dataModel.axisWakeupTimes;
    cellModel.blePostionTimes = self.dataModel.blePostionTimes;
    cellModel.wifiPostionTimes = self.dataModel.wifiPostionTimes;
    cellModel.gpsPostionTimes = self.dataModel.gpsPostionTimes;
    cellModel.loraSendCount = self.dataModel.loraSendCount;
    cellModel.loraPowerConsumption = self.dataModel.loraPowerConsumption;
    cellModel.batteryPower = self.dataModel.batteryPower;
    [self.section2List addObject:cellModel];
}

- (void)loadSection3Datas {
    MKButtonMsgCellModel *cellModel = [[MKButtonMsgCellModel alloc] init];
    cellModel.index = 0;
    cellModel.msg = @"Battery Reset";
    cellModel.buttonTitle = @"Reset";
    cellModel.noteMsg = @"*After replace with the new battery, need to click \"Reset\", otherwise the low power prompt will be unnormal.";
    cellModel.noteMsgColor = RGBCOLOR(102, 102, 102);
    [self.section3List addObject:cellModel];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Selftest Interface";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
}

#pragma mark - getter
- (MKBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[MKBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray *)section0List {
    if (!_section0List) {
        _section0List = [NSMutableArray array];
    }
    return _section0List;
}

- (NSMutableArray *)section1List {
    if (!_section1List) {
        _section1List = [NSMutableArray array];
    }
    return _section1List;
}

- (NSMutableArray *)section2List {
    if (!_section2List) {
        _section2List = [NSMutableArray array];
    }
    return _section2List;
}

- (NSMutableArray *)section3List {
    if (!_section3List) {
        _section3List = [NSMutableArray array];
    }
    return _section3List;
}

- (NSMutableArray *)headerList {
    if (!_headerList) {
        _headerList = [NSMutableArray array];
    }
    return _headerList;
}

- (MKMTSelftestModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKMTSelftestModel alloc] init];
    }
    return _dataModel;
}

@end
