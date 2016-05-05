//
//  CBRedDot.h
//  CBRedDot
//
//  Created by chengbin on 16/5/5.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CBRedDotViewHorizontalAlignment) {
    
    CBRedDotViewHorizontalAlignmentNone,
    CBRedDotViewHorizontalAlignmentLeft,
    CBRedDotViewHorizontalAlignmentCenter,
    CBRedDotViewHorizontalAlignmentRight
};

typedef NS_ENUM(NSUInteger, CBRedDotViewVerticalAlignment) {
  
    CBRedDotViewVerticalAlignmentNone,
    CBRedDotViewVerticalAlignmentTop,
    CBRedDotViewVerticalAlignmentMiddle,
    CBRedDotViewVerticalAlignmentBottom
};

@interface CBRedDot : UIView
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/*常用属性设置*/
@property (nonatomic, retain) UIColor *redDotBackgroundColor; //小红点的背景颜色 默认 红色

@property (nonatomic, assign) CGFloat cornerRadius; //默认4.0f

@property (nonatomic, assign) CGSize alignmentShift; //调整红点与父视图显示的位置 例如:CGSizeMake(-5.0f, 5.0f)

@property (nonatomic, assign) CBRedDotViewHorizontalAlignment horizontalAlignment; //默认 CBRedDotViewHorizontalAlignmentRight

@property (nonatomic, assign) CBRedDotViewVerticalAlignment  verticalAlignment;//默认 CBRedDotViewVerticalAlignmentTop

@property (nonatomic, assign) BOOL hiddenRedDot;//默认 NO

@property (nonatomic, assign) CGFloat animationDuration; //默认 0.2f

@property (nonatomic, assign) BOOL showAnimation; //默认 NO

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/*不常用属性设置*/
@property (nonatomic, assign) CGFloat mininumWidth;

@property (nonatomic, assign) CGFloat maxinumWidth;

@property (nonatomic, retain) UIColor *borderColor;

@property (nonatomic, assign) CGFloat borderWidth;

@property (nonatomic, assign) CGFloat shadowRadius;

@property (nonatomic, assign) CGSize shadowOffset;

@property (nonatomic, assign) UIColor *shadowColor;

@property (nonatomic, assign) BOOL showGloss;

@property (nonatomic, assign) BOOL shadowBorder;

@property (nonatomic, assign) BOOL shadowRedDot;





@end
