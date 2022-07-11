//
//  MKMTFilterByRawDataController.m
//  MKLoRaWAN-MT_Example
//
//  Created by aa on 2022/3/18.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKMTFilterByRawDataController.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"

#import "MKHudManager.h"
#import "MKTextSwitchCell.h"
#import "MKNormalTextCell.h"

#import "MKMTInterface+MKMTConfig.h"

#import "MKMTFilterByRawDataModel.h"

#import "MKMTFilterByBeaconController.h"
#import "MKMTFilterByUIDController.h"
#import "MKMTFilterByURLController.h"
#import "MKMTFilterByTLMController.h"
#import "MKMTFilterByOtherController.h"

@interface MKMTFilterByRawDataController ()<UITableViewDelegate,
UITableViewDataSource,
mk_textSwitchCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)NSMutableArray *section2List;

@property (nonatomic, strong)MKMTFilterByRawDataModel *dataModel;

@end

@implementation MKMTFilterByRawDataController

- (void)dealloc {
    NSLog(@"MKMTFilterByRawDataController销毁");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self readDatasFromDevice];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self loadSectionDatas];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        //iBeacon
        MKMTFilterByBeaconController *vc = [[MKMTFilterByBeaconController alloc] init];
        vc.pageType = mk_mt_filterByBeaconPageType_beacon;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        //Eddystone-UID
        MKMTFilterByUIDController *vc = [[MKMTFilterByUIDController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 2) {
        //Eddystone-URL
        MKMTFilterByURLController *vc = [[MKMTFilterByURLController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 3) {
        //Eddystone-TLM
        MKMTFilterByTLMController *vc = [[MKMTFilterByTLMController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 4) {
        //MKiBeacon
        MKMTFilterByBeaconController *vc = [[MKMTFilterByBeaconController alloc] init];
        vc.pageType = mk_mt_filterByBeaconPageType_MKBeacon;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 5) {
        //MKiBeacon&ACC
        MKMTFilterByBeaconController *vc = [[MKMTFilterByBeaconController alloc] init];
        vc.pageType = mk_mt_filterByBeaconPageType_MKBeaconAcc;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 2 && indexPath.row == 0) {
        //Other
        MKMTFilterByOtherController *vc = [[MKMTFilterByOtherController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
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
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
        cell.dataModel = self.section0List[indexPath.row];
        return cell;
    }
    if (indexPath.section == 1) {
        MKTextSwitchCell *cell = [MKTextSwitchCell initCellWithTableView:tableView];
        cell.dataModel = self.section1List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
    cell.dataModel = self.section2List[indexPath.row];
    return cell;
}

#pragma mark - mk_textSwitchCellDelegate
/// 开关状态发生改变了
/// @param isOn 当前开关状态
/// @param index 当前cell所在的index
- (void)mk_textSwitchCellStatusChanged:(BOOL)isOn index:(NSInteger)index {
    if (index == 0) {
        //BeaconX Pro - ACC
        [self configBXPAcc:isOn];
        return;
    }
    if (index == 1) {
        //BeaconX Pro - T&H
        [self configBXPTH:isOn];
        return;
    }
}

#pragma mark - interface
- (void)readDatasFromDevice {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel readDataWithSucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        [self updateCellStatus];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)configBXPAcc:(BOOL)isOn {
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    [MKMTInterface mt_configBXPAccFilterStatus:isOn sucBlock:^{
        [[MKHudManager share] hide];
        self.dataModel.bxpAcc = isOn;
        MKTextSwitchCellModel *cellModel = self.section1List[0];
        cellModel.isOn = isOn;
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
        [self.tableView mk_reloadRow:0 inSection:1 withRowAnimation:UITableViewRowAnimationNone];
    }];
}

- (void)configBXPTH:(BOOL)isOn {
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    [MKMTInterface mt_configBXPTHFilterStatus:isOn sucBlock:^{
        [[MKHudManager share] hide];
        self.dataModel.bxpTH = isOn;
        MKTextSwitchCellModel *cellModel = self.section1List[1];
        cellModel.isOn = isOn;
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
        [self.tableView mk_reloadRow:1 inSection:1 withRowAnimation:UITableViewRowAnimationNone];
    }];
}

#pragma mark - loadSectionDatas
- (void)updateCellStatus {
    MKNormalTextCellModel *cellModel1 = self.section0List[0];
    cellModel1.rightMsg = (self.dataModel.iBeacon ? @"ON" : @"OFF");
    
    MKNormalTextCellModel *cellModel2 = self.section0List[1];
    cellModel2.rightMsg = (self.dataModel.uid ? @"ON" : @"OFF");
    
    MKNormalTextCellModel *cellModel3 = self.section0List[2];
    cellModel3.rightMsg = (self.dataModel.url ? @"ON" : @"OFF");
    
    MKNormalTextCellModel *cellModel4 = self.section0List[3];
    cellModel4.rightMsg = (self.dataModel.tlm ? @"ON" : @"OFF");
    
    MKNormalTextCellModel *cellModel5 = self.section0List[4];
    cellModel5.rightMsg = (self.dataModel.mk_iBeacon ? @"ON" : @"OFF");
    
    MKNormalTextCellModel *cellModel6 = self.section0List[5];
    cellModel6.rightMsg = (self.dataModel.mk_iBeaconAcc ? @"ON" : @"OFF");
    
    MKTextSwitchCellModel *cellModel7 = self.section1List[0];
    cellModel7.isOn = self.dataModel.bxpAcc;
    
    MKTextSwitchCellModel *cellModel8 = self.section1List[1];
    cellModel8.isOn = self.dataModel.bxpTH;
    
    MKNormalTextCellModel *cellModel9 = self.section2List[0];
    cellModel9.rightMsg = (self.dataModel.other ? @"ON" : @"OFF");
    
    [self.tableView reloadData];
}

- (void)loadSectionDatas {
    [self loadSection0Datas];
    [self loadSection1Datas];
    [self loadSection2Datas];
    
    [self.tableView reloadData];
}

- (void)loadSection0Datas {
    MKNormalTextCellModel *cellModel1 = [[MKNormalTextCellModel alloc] init];
    cellModel1.showRightIcon = YES;
    cellModel1.leftMsg = @"iBeacon";
    [self.section0List addObject:cellModel1];
    
    MKNormalTextCellModel *cellModel2 = [[MKNormalTextCellModel alloc] init];
    cellModel2.showRightIcon = YES;
    cellModel2.leftMsg = @"Eddystone-UID";
    [self.section0List addObject:cellModel2];
    
    MKNormalTextCellModel *cellModel3 = [[MKNormalTextCellModel alloc] init];
    cellModel3.showRightIcon = YES;
    cellModel3.leftMsg = @"Eddystone-URL";
    [self.section0List addObject:cellModel3];
    
    MKNormalTextCellModel *cellModel4 = [[MKNormalTextCellModel alloc] init];
    cellModel4.showRightIcon = YES;
    cellModel4.leftMsg = @"Eddystone-TLM";
    [self.section0List addObject:cellModel4];
    
    MKNormalTextCellModel *cellModel5 = [[MKNormalTextCellModel alloc] init];
    cellModel5.showRightIcon = YES;
    cellModel5.leftMsg = @"MKiBeacon";
    [self.section0List addObject:cellModel5];
    
    MKNormalTextCellModel *cellModel6 = [[MKNormalTextCellModel alloc] init];
    cellModel6.showRightIcon = YES;
    cellModel6.leftMsg = @"MKiBeacon&ACC";
    [self.section0List addObject:cellModel6];
}

- (void)loadSection1Datas {
    MKTextSwitchCellModel *cellModel1 = [[MKTextSwitchCellModel alloc] init];
    cellModel1.index = 0;
    cellModel1.msg = @"BeaconX Pro - ACC";
    [self.section1List addObject:cellModel1];
    
    MKTextSwitchCellModel *cellModel2 = [[MKTextSwitchCellModel alloc] init];
    cellModel2.index = 1;
    cellModel2.msg = @"BeaconX Pro - T&H";
    [self.section1List addObject:cellModel2];
}

- (void)loadSection2Datas {
    MKNormalTextCellModel *cellModel = [[MKNormalTextCellModel alloc] init];
    cellModel.showRightIcon = YES;
    cellModel.leftMsg = @"Other";
    [self.section2List addObject:cellModel];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Filter by Raw Data";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(defaultTopInset);
        make.bottom.mas_equalTo(-VirtualHomeHeight);
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

- (MKMTFilterByRawDataModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKMTFilterByRawDataModel alloc] init];
    }
    return _dataModel;
}

@end