//
//  MKMTDebuggerCell.m
//  MKLoRaWAN-MT_Example
//
//  Created by aa on 2021/12/29.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKMTDebuggerCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"

@implementation MKMTDebuggerCellModel
@end

@interface MKMTDebuggerCell ()

@property (nonatomic, strong)UIButton *backButton;

@property (nonatomic, strong)UIImageView *selectedIcon;

@property (nonatomic, strong)UILabel *msgLabel;

@end

@implementation MKMTDebuggerCell

+ (MKMTDebuggerCell *)initCellWithTableView:(UITableView *)tableView {
    MKMTDebuggerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKMTDebuggerCellIdenty"];
    if (!cell) {
        cell = [[MKMTDebuggerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKMTDebuggerCellIdenty"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.backButton];
        [self.backButton addSubview:self.selectedIcon];
        [self.backButton addSubview:self.msgLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    [self.selectedIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.width.mas_equalTo(25.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(25.f);
    }];
    [self.msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.selectedIcon.mas_right).mas_offset(5.f);
        make.right.mas_equalTo(-15.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
}

#pragma mark - event method
- (void)backButtonPressed {
    self.backButton.selected = !self.backButton.selected;
    [self updateIcon];
    if ([self.delegate respondsToSelector:@selector(mt_debuggerCellSelectedChanged:selected:)]) {
        [self.delegate mt_debuggerCellSelectedChanged:self.dataModel.index selected:self.backButton.selected];
    }
}

#pragma mark - setter
- (void)setDataModel:(MKMTDebuggerCellModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKMTDebuggerCellModel.class]) {
        return;
    }
    self.msgLabel.text = SafeStr(_dataModel.timeMsg);
    self.backButton.selected = _dataModel.selected;
    [self updateIcon];
}

#pragma mark - private method
- (void)updateIcon {
    UIImage *icon = (self.backButton.selected ? LOADICON(@"MKLoRaWAN-MT", @"MKMTDebuggerCell", @"mt_debuggerSelected.png") : LOADICON(@"MKLoRaWAN-MT", @"MKMTDebuggerCell", @"mt_debuggerUnselected"));
    self.selectedIcon.image = icon;
}

#pragma mark - getter
- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton addTarget:self
                        action:@selector(backButtonPressed)
              forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

- (UIImageView *)selectedIcon {
    if (!_selectedIcon) {
        _selectedIcon = [[UIImageView alloc] init];
    }
    return _selectedIcon;
}

- (UILabel *)msgLabel {
    if (!_msgLabel) {
        _msgLabel = [[UILabel alloc] init];
        _msgLabel.textColor = DEFAULT_TEXT_COLOR;
        _msgLabel.textAlignment = NSTextAlignmentLeft;
        _msgLabel.font = MKFont(15.f);
    }
    return _msgLabel;
}

@end
