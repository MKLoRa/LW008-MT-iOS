//
//  MKMTLoRaController.m
//  MKLoRaWAN-MT_Example
//
//  Created by aa on 2022/3/15.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKMTLoRaController.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"

#import "MKHudManager.h"
#import "MKNormalTextCell.h"

#import "MKMTLoRaPageModel.h"

#import "MKMTLoRaAppSettingController.h"
#import "MKMTLoRaSettingController.h"

@interface MKMTLoRaController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *dataList;

@property (nonatomic, strong)MKMTLoRaPageModel *dataModel;

@end

@implementation MKMTLoRaController

- (void)dealloc {
    NSLog(@"MKMTLoRaController销毁");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    [self readDataFromDevice];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self loadSections];
}

#pragma mark - super method
- (void)leftButtonMethod {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"mk_mt_popToRootViewControllerNotification" object:nil];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        //Connection Settings
        MKMTLoRaSettingController *vc = [[MKMTLoRaSettingController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.row == 2) {
        //Application Settings
        MKMTLoRaAppSettingController *vc = [[MKMTLoRaAppSettingController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
    cell.dataModel = self.dataList[indexPath.row];
    return cell;
}

#pragma mark - interface
- (void)readDataFromDevice {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    @weakify(self);
//    [self.dataModel readDataWithSucBlock:^{
//        @strongify(self);
//        [[MKHudManager share] hide];
//        [self updateCellValues];
//    } failedBlock:^(NSError * _Nonnull error) {
//        @strongify(self);
//        [[MKHudManager share] hide];
//        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
//    }];
}

- (void)updateCellValues {
    MKNormalTextCellModel *cellModel1 = self.dataList[0];
    cellModel1.rightMsg = self.dataModel.networkStatus;
    
    MKNormalTextCellModel *cellModel2 = self.dataList[1];
    cellModel2.rightMsg = [NSString stringWithFormat:@"%@/%@/%@",self.dataModel.modem,self.dataModel.region,self.dataModel.classType];
    
    [self.tableView reloadData];
}

#pragma mark - loadSections
- (void)loadSections {
    MKNormalTextCellModel *cellModel1 = [[MKNormalTextCellModel alloc] init];
    cellModel1.leftMsg = @"LoRaWAN Status";
    [self.dataList addObject:cellModel1];
    
    MKNormalTextCellModel *cellModel2 = [[MKNormalTextCellModel alloc] init];
    cellModel2.showRightIcon = YES;
    cellModel2.leftMsg = @"Connection Settings";
    [self.dataList addObject:cellModel2];
    
    MKNormalTextCellModel *cellModel3 = [[MKNormalTextCellModel alloc] init];
    cellModel3.showRightIcon = YES;
    cellModel3.leftMsg = @"Application Settings";
    [self.dataList addObject:cellModel3];
    
    [self.tableView reloadData];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"LoRa";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(defaultTopInset);
        make.bottom.mas_equalTo(-VirtualHomeHeight - 49.f);
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

- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (MKMTLoRaPageModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKMTLoRaPageModel alloc] init];
    }
    return _dataModel;
}


@end
