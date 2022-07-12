//
//  MKMTLRGpsFixController.m
//  MKLoRaWAN-MT_Example
//
//  Created by aa on 2022/6/10.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKMTLRGpsFixController.h"

#import "Masonry.h"

#import "MLInputDodger.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"

#import "MKHudManager.h"
#import "MKTextFieldCell.h"
#import "MKTextSwitchCell.h"
#import "MKTextButtonCell.h"

#import "MKMTAutonomousValueCell.h"

#import "MKMTLRGpsFixModel.h"

@interface MKMTLRGpsFixController ()<UITableViewDelegate,
UITableViewDataSource,
MKTextFieldCellDelegate,
MKTextButtonCellDelegate,
mk_textSwitchCellDelegate,
MKMTAutonomousValueCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)NSMutableArray *section2List;

@property (nonatomic, strong)NSMutableArray *section3List;

@property (nonatomic, strong)NSMutableArray *section4List;

@property (nonatomic, strong)MKMTLRGpsFixModel *dataModel;

@end

@implementation MKMTLRGpsFixController

- (void)dealloc {
    NSLog(@"MKMTLRGpsFixController销毁");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.view.shiftHeightAsDodgeViewForMLInputDodger = 50.0f;
    [self.view registerAsDodgeViewForMLInputDodgerWithOriginalY:self.view.frame.origin.y];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self readDatasFromDevice];
}

#pragma mark - super method
- (void)rightButtonMethod {
    [self saveDataToDevice];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
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
    if (section == 4) {
        return (self.dataModel.aiding ? self.section4List.count : 0);
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MKTextFieldCell *cell = [MKTextFieldCell initCellWithTableView:tableView];
        cell.dataModel = self.section0List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 1) {
        MKTextButtonCell *cell = [MKTextButtonCell initCellWithTableView:tableView];
        cell.dataModel = self.section1List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 2) {
        MKTextSwitchCell *cell = [MKTextSwitchCell initCellWithTableView:tableView];
        cell.dataModel = self.section2List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 3) {
        MKMTAutonomousValueCell *cell = [MKMTAutonomousValueCell initCellWithTableView:tableView];
        cell.dataModel = self.section3List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    MKTextSwitchCell *cell = [MKTextSwitchCell initCellWithTableView:tableView];
    cell.dataModel = self.section4List[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - MKTextFieldCellDelegate
/// textField内容发送改变时的回调事件
/// @param index 当前cell所在的index
/// @param value 当前textField的值
- (void)mk_deviceTextCellValueChanged:(NSInteger)index textValue:(NSString *)value {
    if (index == 0) {
        //Positioning Timeout
        self.dataModel.timeout = value;
        MKTextFieldCellModel *cellModel = self.section0List[0];
        cellModel.textFieldValue = value;
        return;
    }
    if (index == 1) {
        //Statellite Threshold
        self.dataModel.threshold = value;
        MKTextFieldCellModel *cellModel = self.section0List[1];
        cellModel.textFieldValue = value;
        return;
    }
}

#pragma mark - MKTextButtonCellDelegate
/// 右侧按钮点击触发的回调事件
/// @param index 当前cell所在的index
/// @param dataListIndex 点击按钮选中的dataList里面的index
/// @param value dataList[dataListIndex]
- (void)mk_loraTextButtonCellSelected:(NSInteger)index
                        dataListIndex:(NSInteger)dataListIndex
                                value:(NSString *)value {
    if (index == 0) {
        //GPS Data Type
        self.dataModel.dataType = dataListIndex;
        MKTextButtonCellModel *cellModel = self.section1List[0];
        cellModel.dataListIndex = dataListIndex;
        return;
    }
    if (index == 1) {
        //Positioning  System
        self.dataModel.postionSystem = dataListIndex;
        MKTextButtonCellModel *cellModel = self.section1List[1];
        cellModel.dataListIndex = dataListIndex;
        return;
    }
}

#pragma mark - mk_textSwitchCellDelegate
/// 开关状态发生改变了
/// @param isOn 当前开关状态
/// @param index 当前cell所在的index
- (void)mk_textSwitchCellStatusChanged:(BOOL)isOn index:(NSInteger)index {
    if (index == 0) {
        //Autonomous Aiding
        self.dataModel.aiding = isOn;
        MKTextSwitchCellModel *cellModel = self.section2List[0];
        cellModel.isOn = isOn;
        [self.tableView mk_reloadSection:4 withRowAnimation:UITableViewRowAnimationNone];
        return;
    }
    if (index == 1) {
        //Notify On Ephemeris Start
        self.dataModel.start = isOn;
        MKTextSwitchCellModel *cellModel = self.section4List[0];
        cellModel.isOn = isOn;
        return;
    }
    if (index == 2) {
        //Notify On Ephemeris End
        self.dataModel.end = isOn;
        MKTextSwitchCellModel *cellModel = self.section4List[1];
        cellModel.isOn = isOn;
        return;
    }
}

#pragma mark - MKMTAutonomousValueCellDelegate
- (void)mt_autonomousValueCellValueChanged:(NSString *)value index:(NSInteger)index {
    if (index == 0) {
        //Autonomous Longitude
        self.dataModel.longitude = value;
        MKMTAutonomousValueCellModel *cellModel = self.section3List[0];
        cellModel.value = value;
        return;
    }
    if (index == 1) {
        //Autonomous Latitude
        self.dataModel.latitude = value;
        MKMTAutonomousValueCellModel *cellModel = self.section3List[1];
        cellModel.value = value;
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
        [self loadSectionDatas];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)saveDataToDevice {
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel configDataWithSucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"Success"];
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
    [self loadSection4Datas];
    
    [self.tableView reloadData];
}

- (void)loadSection0Datas {
    MKTextFieldCellModel *cellModel1 = [[MKTextFieldCellModel alloc] init];
    cellModel1.index = 0;
    cellModel1.msg = @"Positioning Timeout";
    cellModel1.textFieldValue = self.dataModel.timeout;
    cellModel1.textPlaceholder = @"1 ~ 5";
    cellModel1.textFieldType = mk_realNumberOnly;
    cellModel1.unit = @"x9s";
    cellModel1.maxLength = 1;
    [self.section0List addObject:cellModel1];
    
    MKTextFieldCellModel *cellModel2 = [[MKTextFieldCellModel alloc] init];
    cellModel2.index = 1;
    cellModel2.msg = @"Statellite Threshold";
    cellModel2.textFieldValue = self.dataModel.threshold;
    cellModel2.textPlaceholder = @"4 ~ 10";
    cellModel2.textFieldType = mk_realNumberOnly;
    cellModel2.unit = @" ";
    cellModel2.maxLength = 2;
    [self.section0List addObject:cellModel2];
}

- (void)loadSection1Datas {
    MKTextButtonCellModel *cellModel1 = [[MKTextButtonCellModel alloc] init];
    cellModel1.index = 0;
    cellModel1.msg = @"GPS Data Type";
    cellModel1.dataList = @[@"DAS",@"Customer"];
    cellModel1.dataListIndex = self.dataModel.dataType;
    [self.section1List addObject:cellModel1];
    
    MKTextButtonCellModel *cellModel2 = [[MKTextButtonCellModel alloc] init];
    cellModel2.index = 1;
    cellModel2.msg = @"Positioning System";
    cellModel2.dataList = @[@"GPS",@"Beidou",@"GPS&Beidou"];
    cellModel2.dataListIndex = self.dataModel.postionSystem;
    [self.section1List addObject:cellModel2];
}

- (void)loadSection2Datas {
    MKTextSwitchCellModel *cellModel = [[MKTextSwitchCellModel alloc] init];
    cellModel.index = 0;
    cellModel.msg = @"Autonomous Aiding";
    cellModel.isOn = self.dataModel.aiding;
    [self.section2List addObject:cellModel];
}

- (void)loadSection3Datas {
    MKMTAutonomousValueCellModel *cellModel1 = [[MKMTAutonomousValueCellModel alloc] init];
    cellModel1.index = 0;
    cellModel1.msg = @"Autonomous Longitude";
    cellModel1.value = self.dataModel.longitude;
    cellModel1.placeholder = @"-9000000~9000000";
    cellModel1.maxLength = 8;
    [self.section3List addObject:cellModel1];
    
    MKMTAutonomousValueCellModel *cellModel2 = [[MKMTAutonomousValueCellModel alloc] init];
    cellModel2.index = 1;
    cellModel2.msg = @"Autonomous Latitude";
    cellModel2.value = self.dataModel.latitude;
    cellModel2.placeholder = @"-18000000~18000000";
    cellModel2.maxLength = 9;
    [self.section3List addObject:cellModel2];
}

- (void)loadSection4Datas {
    MKTextSwitchCellModel *cellModel1 = [[MKTextSwitchCellModel alloc] init];
    cellModel1.index = 1;
    cellModel1.msg = @"Notify On Ephemeris Start";
    cellModel1.isOn = self.dataModel.start;
    [self.section4List addObject:cellModel1];
    
    MKTextSwitchCellModel *cellModel2 = [[MKTextSwitchCellModel alloc] init];
    cellModel2.index = 2;
    cellModel2.msg = @"Notify On Ephemeris End";
    cellModel2.isOn = self.dataModel.end;
    [self.section4List addObject:cellModel2];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"GPS Fix";
    [self.rightButton setImage:LOADICON(@"MKLoRaWAN-MT", @"MKMTLRGpsFixController", @"mt_slotSaveIcon.png") forState:UIControlStateNormal];
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

- (NSMutableArray *)section3List {
    if (!_section3List) {
        _section3List = [NSMutableArray array];
    }
    return _section3List;
}

- (NSMutableArray *)section4List {
    if (!_section4List) {
        _section4List = [NSMutableArray array];
    }
    return _section4List;
}

- (MKMTLRGpsFixModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKMTLRGpsFixModel alloc] init];
    }
    return _dataModel;
}

@end
