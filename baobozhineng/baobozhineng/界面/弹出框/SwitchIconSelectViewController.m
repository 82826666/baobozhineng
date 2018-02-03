//
//  SwitchIconSelectViewController.m
//  baobozhineng
//
//  Created by 魏俊阳 on 2017/12/30.
//  Copyright © 2017年 魏俊阳. All rights reserved.
//

#import "SwitchIconSelectViewController.h"
#define BTN_WIDTH 50
@interface SwitchIconSelectViewController ()
//标题label
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//图标按钮内容
@property (weak, nonatomic) IBOutlet UIView *contentView;
//弹出框
@property (weak, nonatomic) IBOutlet UIView *popView;
//按钮图片
@property (nonatomic,strong) NSArray *imgArray;
//按钮标题
@property (nonatomic,strong) NSArray *titleArray;
//弹出框高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *popupHeight;
//弹出框的左右边距离
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *popviewLeftConstraint;
//标题名称
@property (nonatomic,copy) NSString *titleLabText;
@end

@implementation SwitchIconSelectViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.popupView = self.popView;
    // Do any additional setup after loading the view.
    [self.popupView updateConstraints];
    //设置圆角
    [self.popupView.layer setMasksToBounds:YES];
    [self.popupView.layer setCornerRadius:8];
    self.titleLabel.text = _titleLabText;
    //设置内容添加按钮
     [self setContentViewByImgs:self.imgArray Titles:self.titleArray];
    
}

//外部设置数据
- (void)setImgArray:(NSArray *)imgArray titleArray:(NSArray*)titleArray LabelTitle:(NSString *)labelTitleText ClickBlock:(btnClickBlock)block
{
    self.imgArray = imgArray;
    self.titleArray = titleArray;
    self.clickBlock = block;
    _titleLabText = labelTitleText;
}

//添加按钮
- (void)setContentViewByImgs:(NSArray*)imgArray Titles:(NSArray *)titleArray
{
    //设置按钮下方标题的高度
    double labelHeight = 15;
    //设置每行多少按钮
    int cellcount = 4;
    //设置每个按钮的行间距
    double left_jiange = (self.view.frame.size.width-_popviewLeftConstraint.constant*2-BTN_WIDTH*cellcount)/5;

    //double top_jiange = (self.contentView.frame.size.height-BTN_WIDTH*(imgArray.count/4+1))/(imgArray.count/4+2)+labelHeight;
    //设置每个按钮的列艰巨
    double top_jiange =labelHeight;
   
    for ( int i = 0; i<imgArray.count; i++) {
        UIButton *btn ;
        //创建按钮
        btn = [self createButton:CGRectMake((left_jiange+BTN_WIDTH)*(i%cellcount)+left_jiange, i/cellcount*(top_jiange+BTN_WIDTH+4)+top_jiange/2, BTN_WIDTH, BTN_WIDTH) Img:[UIImage imageNamed:imgArray[i]]];
         btn.tag = i+1;
        //按钮的响应事件，通过tag来判断是那个按钮
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
       
        
        UILabel *label = [self createLabel:CGRectMake(btn.frame.origin.x, CGRectGetMaxY(btn.frame), btn.frame.size.width, labelHeight) title:titleArray[i]];
        label.textColor = RGBA(88, 88, 88, 1.0);
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:10];
        [_contentView addSubview:btn];
        [_contentView addSubview:label];
        
        //弹出框高度随着最后一个按钮所在的位置而改变，使得界面看起来紧凑
        if (i==imgArray.count-1) {
            _popupHeight.constant = self.titleLabel.frame.size.height+top_jiange/2+CGRectGetMaxY(label.frame);
        }
      
    }
}

//创建按钮
- (UIButton *)createButton:(CGRect)frame Img:(UIImage *)img
{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    [btn setBackgroundImage:img forState:UIControlStateNormal];
    return  btn;
}
//创建label
- (UILabel*)createLabel:(CGRect)frame title:(NSString*)title
{
    UILabel *lab = [[UILabel alloc] initWithFrame:frame];
    lab.text = title;
    lab.adjustsFontSizeToFitWidth= YES;
    return  lab;
}
//按钮的响应事件
- (void)btnAction:(UIButton *)btn
{
    int tag =(int)btn.tag;
    
    self.clickBlock(tag-1,_imgArray[tag-1],_titleArray[tag-1]);
    [self hiddenPopupView];
}
@end
