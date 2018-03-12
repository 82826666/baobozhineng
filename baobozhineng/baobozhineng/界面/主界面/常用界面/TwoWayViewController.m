//
//  TwoWayViewController.m
//  baobozhineng
//
//  Created by wjy on 2018/3/7.
//  Copyright © 2018年 吴建阳. All rights reserved.
//

#import "TwoWayViewController.h"
#import "CommontViewController.h"
#define BTN_WIDTH 50
@interface TwoWayViewController (){
    NSMutableArray      *dataSource;
}
@property(nonatomic, strong) UIView *content;
@end

@implementation TwoWayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
    [self initDataSource];
    [self uiSet];
    // Do any additional setup after loading the view.
}
- (void) initNav{
    
    //    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithTitle:@"消息" style:UIBarButtonItemStyleDone target: self action:@selector(message)];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"in_arrow_white"] style:UIBarButtonItemStyleDone target:self action:@selector(goBack)];
    //    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStyleDone target:self action:@selector(add)];
    self.navigationItem.title = @"一键开关";
    self.navigationController.navigationBar.barTintColor = BARTINTCOLOR;
    self.navigationController.navigationBar.tintColor = TINTCOLOR;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];//设置标题颜色及字体大小
    self.navigationItem.leftBarButtonItem = leftBtn;
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveData)];
    self.navigationItem.rightBarButtonItem = rightBtn;
}

- (void)initDataSource
{
    dataSource = [NSMutableArray arrayWithObjects:@{
                                                @"img":@"in_equipment_switch_one",
                                                    @"title":@"一键开关"
                                                    },
                  @{
                    @"img":@"in_equipment_switch_two",
                    @"title":@"二键开关"
                    },
                  @{
                    @"img":@"in_equipment_switch_three",
                    @"title":@"三键开关"
                    },
                  @{
                    @"img":@"in_equipment_switch_four",
                    @"title":@"四键开关"
                    },
                  @{
                    @"img":@"in_equipment_switch_three",
                    @"title":@"热水器"
                    }, nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)uiSet{
    self.view.backgroundColor = [UIColor whiteColor];
    _content = [[UIView alloc]initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:_content];
    //设置按钮下方标题的高度
    double labelHeight = 15;
    //设置每行多少按钮
    int cellcount = 4;
    //设置每个按钮的行间距
    double left_jiange = (self.view.frame.size.width-BTN_WIDTH*cellcount)/5;
    //设置每个按钮的列艰巨
    double top_jiange =labelHeight;
    for ( int i = 0; i<dataSource.count; i++) {
        NSDictionary *dic = [dataSource objectAtIndex:i];
        UIButton *btn ;
        //创建按钮
        btn = [self createButton:CGRectMake((left_jiange+BTN_WIDTH)*(i%cellcount)+left_jiange, i/cellcount*(top_jiange+BTN_WIDTH+4)+top_jiange/2, BTN_WIDTH, BTN_WIDTH) Img:[UIImage imageNamed:[dic objectForKey:@"img"]]];
        btn.tag = i+1;
        //按钮的响应事件，通过tag来判断是那个按钮
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UILabel *label = [self createLabel:CGRectMake(btn.frame.origin.x, CGRectGetMaxY(btn.frame), btn.frame.size.width, labelHeight) title:[dic objectForKey:@"title"]];
        label.textColor = RGBA(88, 88, 88, 1.0);
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:10];
        [_content addSubview:btn];
        [_content addSubview:label];
    }
}

-(void)btnAction:(UIButton*)sender{
    if (sender.tag == 1) {
        CommontViewController *controller = [[CommontViewController alloc]init];
        controller.setNum = setNumOne;
        [self.navigationController pushViewController:controller animated:YES];
    }else if(sender.tag == 2){
        
    }
//    NSLog(@"tag:%ld",sender.tag);
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
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.toolbarHidden = NO;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
