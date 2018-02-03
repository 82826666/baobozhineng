//
//  TablePopViewController.h
//  baobozhineng
//
//  Created by 魏俊阳 on 2017/12/31.
//  Copyright © 2017年 魏俊阳. All rights reserved.
//

#import "ParentPopupView.h"
typedef void(^selectAreaBlock)(id dataArray);
@interface TablePopViewController : ParentPopupView

@property (nonatomic,copy) selectAreaBlock Block;
- (void) setTitleLabel:(NSString *)title CellTitleArray:(NSArray *)celltitleArray Block:(selectAreaBlock)block;

@end
