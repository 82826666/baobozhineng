

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    myVerticalAlignmentNone = 0,
    myVerticalAlignmentCenter,
    myVerticalAlignmentTop,
    myVerticalAlignmentBottom
} myVerticalAlignment;

@interface VerticalCenterTextLabel : UILabel
@property (nonatomic) UIEdgeInsets edgeInsets;

/**
 *  对齐方式
 */
@property (nonatomic) myVerticalAlignment verticalAlignment;

@end
