//
//  SelectAlert.m
//  SelectAlertDemo
//
//  Created by apple on 2016/11/24.
//  Copyright © 2016年 周兴. All rights reserved.
//

#import "SelectAlert.h"
#define FONTSIZE 12
#define JiangeLeft 15
#define ALERT_WIDTH [UIScreen mainScreen].bounds.size.width-60
@interface SelectAlertCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation SelectAlertCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor colorWithRed:0 green:127/255.0 blue:1 alpha:1];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _titleLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

@end


@interface SelectAlert ()

@property (nonatomic, assign) BOOL showCloseButton;//是否显示关闭按钮
@property (nonatomic, strong) UIView *alertView;//弹框视图
@property (nonatomic, strong) UITableView *selectTableView;//选择列表
@property (nonatomic, strong) UIImage *rightImg;

@end

@implementation SelectAlert
{
    float alertHeight;//弹框整体高度，默认250
    float buttonHeight;//按钮高度，默认40
}

+ (SelectAlert *)showWithTitle:(NSString *)title
                        titles:(NSArray *)titles
                   selectIndex:(SelectIndex)selectIndex
                   selectValue:(SelectValue)selectValue
               showCloseButton:(BOOL)showCloseButton {
    SelectAlert *alert = [[SelectAlert alloc] initWithTitle:title titles:titles selectIndex:selectIndex selectValue:selectValue showCloseButton:showCloseButton];
    return alert;
}

+ (SelectAlert *)showWithTitle:(NSString *)title
                        titles:(NSArray *)titles
                 TitleLabColor:(UIColor *)titleLabColor
                      RightImg:(UIImage *)rightImg
                BottomBtnTitle:(NSString *)bottomTitle
                    CellHeight:(double)cellHeight
                   selectIndex:(SelectIndex)selectIndex
                   selectValue:(SelectValue)selectValue
              CloseActionBlock:(CloseActionBlock)closeActionBlock
               showCloseButton:(BOOL)showCloseButton;
{
    SelectAlert *alert = [[SelectAlert alloc] initWithTitle:title titles:titles CellHeight:cellHeight BottomTtile:bottomTitle TitleLabColor:titleLabColor RightImg:rightImg selectIndex:selectIndex selectValue:selectValue CloseBlock:closeActionBlock showCloseButton:showCloseButton];
    return  alert;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
        _titleLabel.textColor = [UIColor colorWithRed:88/255.0 green:88/255.0 blue:88/255.0 alpha:0.9];
        _titleLabel.font = [UIFont boldSystemFontOfSize:15];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIView *)alertView {
    if (!_alertView) {
        _alertView = [[UIView alloc] init];
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.layer.cornerRadius = 8;
        _alertView.layer.masksToBounds = YES;
    }
    return _alertView;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
       // _closeButton.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
        [_closeButton setTitle:@"关闭" forState:UIControlStateNormal];
        [_closeButton setTitleColor:[UIColor colorWithRed:0 green:127/255.0 blue:1 alpha:1] forState:UIControlStateNormal];
        _closeButton.titleLabel.font = [UIFont systemFontOfSize:FONTSIZE];
        [_closeButton setTitleColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

- (UITableView *)selectTableView {
    if (!_selectTableView) {
        _selectTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _selectTableView.delegate = self;
        _selectTableView.dataSource = self;
    }
    return _selectTableView;
}

- (instancetype)initWithTitle:(NSString *)title titles:(NSArray *)titles CellHeight:(double)cellHeight BottomTtile:(NSString*)bottomTitle TitleLabColor:(UIColor *)titleLabColor RightImg:(UIImage *)rightImg selectIndex:(SelectIndex)selectIndex selectValue:(SelectValue)selectValue  CloseBlock:(CloseActionBlock)closeBlock showCloseButton:(BOOL)showCloseButton
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
        alertHeight = 250;
        if (titles.count<3) {
            alertHeight = alertHeight -(3-titles.count)*cellHeight;
        }
        buttonHeight = cellHeight;
        _rightImg = rightImg;
        self.titleLabel.text = title;
        self.titleLabel.backgroundColor = titleLabColor;
        _titles = titles;
        _selectIndex = [selectIndex copy];
        _selectValue = [selectValue copy];
        _closeBlock = [closeBlock copy];
        _showCloseButton = showCloseButton;
        [self addSubview:self.alertView];
        [self.alertView addSubview:self.titleLabel];
        [self.alertView addSubview:self.selectTableView];
        if (_showCloseButton) {
            [self.alertView addSubview:self.closeButton];
        }
        [self.closeButton setTitle:@"添加新主机" forState:UIControlStateNormal];
        
        _closeButton.contentHorizontalAlignment =  UIControlContentHorizontalAlignmentLeft;
        [self initUI];
        
        [self show];
    }
    return self;
}
- (instancetype)initWithTitle:(NSString *)title titles:(NSArray *)titles selectIndex:(SelectIndex)selectIndex selectValue:(SelectValue)selectValue showCloseButton:(BOOL)showCloseButton {
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
        alertHeight = 250;
        buttonHeight = 40;
        
        self.titleLabel.text = title;
        _titles = titles;
        _selectIndex = [selectIndex copy];
        _selectValue = [selectValue copy];

        _showCloseButton = showCloseButton;
        [self addSubview:self.alertView];
        [self.alertView addSubview:self.titleLabel];
        [self.alertView addSubview:self.selectTableView];
        if (_showCloseButton) {
            [self.alertView addSubview:self.closeButton];
        }
        [self initUI];
        
        [self show];
    }
    return self;
}

- (void)show {
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.alertView.alpha = 0.0;
    [UIView animateWithDuration:0.05 animations:^{
        self.alertView.alpha = 1;
    }];
}

- (void)initUI {
    self.alertView.frame = CGRectMake(30,  [UIScreen mainScreen].bounds.size.height/10.0, ALERT_WIDTH, alertHeight);
    self.titleLabel.frame = CGRectMake(0, 0, _alertView.frame.size.width, buttonHeight+10);
    float reduceHeight = buttonHeight;
    if (_showCloseButton) {
        self.closeButton.frame = CGRectMake(JiangeLeft, _alertView.frame.size.height-buttonHeight, _alertView.frame.size.width-JiangeLeft, buttonHeight);
        reduceHeight = buttonHeight*2;
    }
    self.selectTableView.frame = CGRectMake(0, buttonHeight, _alertView.frame.size.width, _alertView.frame.size.height-reduceHeight);
    UIView *lineView = [[UIView alloc] initWithFrame: CGRectMake(0, CGRectGetMaxY(self.selectTableView.frame), self.alertView.frame.size.width, 0.5)];
    lineView.backgroundColor = [UIColor colorWithRed:155/255.0 green:155/255.0 blue:155/255.0 alpha:0.8];
    [self.alertView addSubview:lineView];
}


#pragma UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    float real = (alertHeight - buttonHeight)/(float)_titles.count;
//    if (_showCloseButton) {
//        real = (alertHeight - buttonHeight*2)/(float)_titles.count;
//    }
//    return real<=40?40:real;
    return  buttonHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.000001;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, CGFLOAT_MIN)];
    return  view;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, CGFLOAT_MIN)];
    return  view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selectcell"];
    
    if (!cell) {
       // cell = [[SelectAlertCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"selectcell"];
        cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"selectcell"];
        
        UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(JiangeLeft, 0, 100, buttonHeight)];
        leftLabel.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1];
        leftLabel.font = [UIFont systemFontOfSize:FONTSIZE];
        leftLabel.textAlignment = NSTextAlignmentLeft;
        leftLabel.tag =1;
        [cell.contentView addSubview:leftLabel];
        
        UILabel *middleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, ALERT_WIDTH, buttonHeight)];
        middleLabel.textColor   = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:0.5];
        middleLabel.font = [UIFont systemFontOfSize:FONTSIZE];
        middleLabel.textAlignment = NSTextAlignmentCenter;
        middleLabel.tag =2;
        [cell.contentView addSubview:middleLabel];
        
        UIImageView *imgView  = [[UIImageView alloc] initWithFrame:CGRectMake(ALERT_WIDTH-40, 15, 30, buttonHeight-30)];
        imgView.tag = 3;
        imgView.alpha=0.7;
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        [cell.contentView addSubview:imgView];
    }
    
    UILabel *leftLabel = [cell.contentView viewWithTag:1];
    leftLabel.text = _titles[indexPath.row];
    
    UILabel *middleLabel  = [cell.contentView viewWithTag:2];
    
    middleLabel.text = @"切换主机";
    
    UIImageView *imgView = [cell.contentView viewWithTag:3];
    imgView.image = _rightImg;

   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectIndex) {
        self.selectIndex(indexPath.row);
    }
    if (self.selectValue) {
        self.selectValue(_titles[indexPath.row]);
    }
    
    [self closeAction];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self];
    if (!CGRectContainsPoint([self.alertView frame], pt)) {
        
        [UIView animateWithDuration:0.1 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}

- (void)closeAction {
    self.closeBlock();
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)dealloc {
//    NSLog(@"SelectAlert被销毁了");
}

@end
