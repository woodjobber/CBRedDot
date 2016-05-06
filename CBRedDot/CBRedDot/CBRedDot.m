//
//  CBRedDot.m
//  CBRedDot
//
//  Created by chengbin on 16/5/5.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import "CBRedDot.h"
#import <QuartzCore/QuartzCore.h>

@implementation CBRedDot

{
    
    CAShapeLayer *borderLayer;
    CAShapeLayer *backgroundLayer;
    CAShapeLayer *glossMaskLayer;
    CAGradientLayer *glossLayer;
    CABasicAnimation *frameAnimation;
}


#pragma mark -
#pragma mark Init Methods
- (void)awakeFromNib {
    [super awakeFromNib];

    [self setup];
}
- (id)init
{
    self = [super init];
    if (self) {
     
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {

        [self setup];
    }
    return self;
}

#pragma mark -
#pragma mark - config initial data
- (void)setup {
    
    self.userInteractionEnabled = NO;
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = NO;
    
    _redDotBackgroundColor = [UIColor redColor];
    _cornerRadius = 4.0f;
    _alignmentShift = CGSizeMake(0.0, 0.0);
    _horizontalAlignment = CBRedDotViewHorizontalAlignmentRight;
    _verticalAlignment = CBRedDotViewVerticalAlignmentTop;
    _borderColor = [UIColor whiteColor];
    _shadowColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
    _shadowOffset = CGSizeMake(1.0f, 1.0f);
    _shadowRadius = 1.0f;
    _borderWidth = 0.0f;
    _hiddenRedDot = NO;
    _animationDuration = 0.2f;
    _showAnimation = NO;
    
    if (CGRectEqualToRect(CGRectZero, self.frame) || CGRectGetHeight(self.frame) == 0) {
        CGRect frame = self.frame;
        frame.size.height = 8.0f;
        frame.size.width = 8.0f;
        self.frame = frame;
        _mininumWidth = 8.0f;
    }else {
        _mininumWidth = CGRectGetWidth(self.frame);
    }
    _maxinumWidth = 8.0f;
    
    borderLayer = [CAShapeLayer layer];
    borderLayer.strokeColor = _borderColor.CGColor;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.lineWidth = _borderWidth;
    borderLayer.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    borderLayer.contentsScale = [UIScreen mainScreen].scale;
    
    backgroundLayer = [CAShapeLayer layer];
    backgroundLayer.fillColor = _redDotBackgroundColor.CGColor;
    backgroundLayer.frame = CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height);
    backgroundLayer.contentsScale = [UIScreen mainScreen].scale;
    
    glossLayer = [CAGradientLayer layer];
    glossLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    glossLayer.contentsScale = [UIScreen mainScreen].scale;
    glossLayer.colors = @[(id)[UIColor colorWithWhite:1 alpha:.8].CGColor,(id)[UIColor colorWithWhite:1 alpha:.25].CGColor, (id)[UIColor colorWithWhite:1 alpha:0].CGColor];
    glossLayer.startPoint = CGPointMake(0.0, 0.0);
    glossLayer.endPoint = CGPointMake(0, 0.6);
    glossLayer.locations = @[@0,@0.6, @0.8, @1];
    glossLayer.type = kCAGradientLayerAxial;
    
    glossMaskLayer = [CAShapeLayer layer];
    glossMaskLayer.fillColor = [UIColor blackColor].CGColor;
    glossMaskLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    glossMaskLayer.contentsScale = [UIScreen mainScreen].scale;
    glossLayer.mask = glossMaskLayer;
    
    
    [self.layer addSublayer:backgroundLayer];
    [self.layer addSublayer:borderLayer];

    
    frameAnimation = [CABasicAnimation animation];
    frameAnimation.duration = _animationDuration;
    frameAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    backgroundLayer.actions = nil;
    borderLayer.actions = nil;
    glossMaskLayer.actions = nil;
    
    [self performSelectorOnMainThread:@selector(autoSetRedDotFrame) withObject:nil waitUntilDone:NO modes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
    
}

#pragma mark -
#pragma mark layoutSubviews

- (void)layoutSubviews {
    [super layoutSubviews];
    
    backgroundLayer.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    glossLayer.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    glossMaskLayer.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    borderLayer.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:_cornerRadius];
    backgroundLayer.path = path.CGPath;
    borderLayer.path = path.CGPath;
    glossMaskLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(self.bounds, _borderWidth/2, _borderWidth/2) cornerRadius:_cornerRadius].CGPath;
}

#pragma mark -
#pragma mark Setter Methods

-(void)setHiddenRedDot:(BOOL)hiddenRedDot {
    _hiddenRedDot = hiddenRedDot;
    self.hidden = hiddenRedDot;
    [self setNeedsDisplay];
}

- (void)setRedDotBackgroundColor:(UIColor *)redDotBackgroundColor {
    _redDotBackgroundColor = redDotBackgroundColor;
    backgroundLayer.fillColor = redDotBackgroundColor.CGColor;
}

- (void)setAnimationDuration:(CGFloat)animationDuration {
    _animationDuration = animationDuration;
    frameAnimation.duration = animationDuration;
    backgroundLayer.actions = nil;
    borderLayer.actions = nil;
    glossMaskLayer.actions = nil;
    [self setupAnimations];
}

- (void)setShowAnimation:(BOOL)showAnimation {
    _showAnimation = showAnimation;
    [self setupAnimations];
    
}

- (void)setShowGloss:(BOOL)showGloss {
    _showGloss = showGloss;
    if (_showGloss) {
        [self.layer addSublayer:glossLayer];
    }else {
        [glossLayer removeFromSuperlayer];
    }
    
}
- (void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
 
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:_cornerRadius];
    backgroundLayer.path = path.CGPath;
    glossMaskLayer.path = path.CGPath;
    borderLayer.path = path.CGPath;
    
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    _borderWidth = borderWidth;
    borderLayer.lineWidth = borderWidth;
    [self setNeedsDisplay];
}

- (void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
    borderLayer.strokeColor = _borderColor.CGColor;
    [self setNeedsDisplay];
    
}
- (void)setShadowColor:(UIColor *)shadowColor
{
    _shadowColor = shadowColor;
    self.shadowRedDot = _shadowRedDot;
    
    self.shadowBorder = _shadowBorder;
}

- (void)setShadowOffset:(CGSize)shadowOffset
{
    _shadowOffset = shadowOffset;
    self.shadowRedDot = _shadowRedDot;
    
    self.shadowBorder = _shadowBorder;
}

-(void)setShadowRadius:(CGFloat)shadowRadius {
    _shadowRadius = shadowRadius;
    self.shadowRedDot = _shadowRedDot;
    
    self.shadowBorder = _shadowBorder;
}
- (void)setShadowBorder:(BOOL)shadowBorder
{
    _shadowBorder = shadowBorder;
    
    if (_shadowBorder) {
        borderLayer.shadowColor = _shadowColor.CGColor;
        borderLayer.shadowOffset = _shadowOffset;
        borderLayer.shadowRadius = _shadowRadius;
        borderLayer.shadowOpacity = 1.0f;
    } else {
        borderLayer.shadowColor = nil;
        borderLayer.shadowOpacity = 0.0f;
    }
}

- (void)setShadowRedDot:(BOOL)shadowRedDot
{
    _shadowRedDot = shadowRedDot;
    if (_shadowRedDot) {
        backgroundLayer.shadowColor = _shadowColor.CGColor;
        backgroundLayer.shadowOffset = _shadowOffset;
        backgroundLayer.shadowRadius = _shadowRadius;
        backgroundLayer.shadowOpacity = 1.0f;
    } else {
        backgroundLayer.shadowColor = nil;
        backgroundLayer.shadowOpacity = 0.0f;
    }
}


- (void)setMaxinumWidth:(CGFloat)maxinumWidth {
    if ( maxinumWidth < self.frame.size.height) {
        maxinumWidth = self.frame.size.height;
    }
    _maxinumWidth = maxinumWidth;
    [self performSelector:@selector(autoSetRedDotFrame) withObject:nil afterDelay:0.01f inModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
    [self setNeedsDisplay];
}
- (void)setMininumWidth:(CGFloat)mininumWidth {
    _mininumWidth = mininumWidth;
    
    [self performSelector:@selector(autoSetRedDotFrame) withObject:nil afterDelay:0.01f inModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
    [self setNeedsDisplay];
}

- (void)setAlignmentShift:(CGSize)alignmentShift {
    _alignmentShift = alignmentShift;
    
    [self performSelector:@selector(autoSetRedDotFrame) withObject:nil afterDelay:0.01f inModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
    [self setNeedsDisplay];
    
}

- (void)setVerticalAlignment:(CBRedDotViewVerticalAlignment)verticalAlignment {
    _verticalAlignment = verticalAlignment;
    [self performSelector:@selector(autoSetRedDotFrame) withObject:nil afterDelay:0.01f inModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
    [self setNeedsDisplay];
    
}

- (void)setHorizontalAlignment:(CBRedDotViewHorizontalAlignment)horizontalAlignment {
    _horizontalAlignment = horizontalAlignment;
    [self performSelector:@selector(autoSetRedDotFrame) withObject:nil afterDelay:0.01f inModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
    [self setNeedsDisplay];
}
- (void)setAutoSetCornerRadius:(BOOL)autoSetCornerRadius {
    autoSetCornerRadius = autoSetCornerRadius;
}

#pragma mark -
#pragma mark Private

- (void)autoSetRedDotFrame {
    
    CGRect frame = self.frame;
    if (frame.size.width <_mininumWidth) {
        frame.size.width = _mininumWidth;
    }else if (frame.size.width > _maxinumWidth) {
        frame.size.width = _maxinumWidth;
    }
    
    if (_horizontalAlignment == CBRedDotViewHorizontalAlignmentLeft) {
        frame.origin.x = 0-(frame.size.width /2) + _alignmentShift.width;
    }else if (_horizontalAlignment == CBRedDotViewHorizontalAlignmentCenter) {
        frame.origin.x =  (self.superview.bounds.size.width / 2) - (frame.size.width / 2) + _alignmentShift.width;
        
    }else if (_horizontalAlignment == CBRedDotViewHorizontalAlignmentRight){
        frame.origin.x = self.superview.bounds.size.width - (frame.size.width / 2) + _alignmentShift.width;
    }
    
    
    if (_verticalAlignment == CBRedDotViewVerticalAlignmentTop) {
        frame.origin.y = 0 - (frame.size.height / 2) + _alignmentShift.height;
    } else if (_verticalAlignment == CBRedDotViewVerticalAlignmentMiddle) {
        frame.origin.y = (self.superview.bounds.size.height / 2) - (frame.size.height / 2.0) + _alignmentShift.height;
    } else if (_verticalAlignment == CBRedDotViewVerticalAlignmentBottom) {
        frame.origin.y = self.superview.bounds.size.height - (frame.size.height / 2.0) + _alignmentShift.height;
    }
    

    
    self.frame = frame;
    
    CGRect tempFrame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    backgroundLayer.frame = tempFrame;
    
    glossLayer.frame = tempFrame;
    glossMaskLayer.frame = tempFrame;
    borderLayer.frame = tempFrame;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:tempFrame cornerRadius:_cornerRadius];
    backgroundLayer.path = path.CGPath;
    borderLayer.path = path.CGPath;
    
    glossMaskLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(self.bounds, _borderWidth / 2.0, _borderWidth / 2.0) cornerRadius:_cornerRadius].CGPath;
    
}

- (void)setupAnimations {
    
    if (_showAnimation && frameAnimation) {
        
        NSDictionary *actions = @{@"path": frameAnimation};
        backgroundLayer.actions = actions;
        borderLayer.actions = actions;
        glossMaskLayer.actions = actions;
        
        
    }else {
        
        backgroundLayer.actions = nil;
        borderLayer.actions = nil;
        glossMaskLayer.actions = nil;
        
    }
}
@end
