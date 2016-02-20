//
//  NHLoadingView.m
//  BeingLoading
//
//  Created by Wilson-Yuan on 16/1/31.
//  Copyright © 2016年 Wilson-Yuan. All rights reserved.
//

#import "NHLoadingView.h"
#import <POP.h>
#import "CAAnimation+NHDelegateBlocks.h"

@interface NHLoadingView ()

@property (strong, nonatomic) CAShapeLayer *shaperLayer;
@property (strong, nonatomic) CAGradientLayer *gradientLayer;

@property (strong, nonatomic) UIImageView *iconView;
@property (strong, nonatomic) CALayer *iconLayer;
@property (strong, nonatomic) NSArray *images;
@end


@implementation NHLoadingView {
    NSInteger _iconIndex;
}


- (void)awakeFromNib {
//    self.backgroundColor = [UIColor redColor];
    _iconIndex = 0;
    [self.layer addSublayer:self.gradientLayer];
    [self addSubview:self.iconView];
    
    [self startAnimation];
    [self startIconViewAnimationWithImage:[self iconImage]];
}
- (UIImage *)iconImage {
    UIImage *image = [UIImage imageNamed:self.images[_iconIndex]];
    _iconIndex += 1;
    if (_iconIndex >= self.images.count) {
        _iconIndex = 0;
    }
    return image;
}


- (void)startAnimation {
    POPBasicAnimation *spinAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
    spinAnimation.fromValue = @0;
    spinAnimation.toValue = @(2 * M_PI);
    spinAnimation.duration = 1.5;
    spinAnimation.repeatForever = YES;
    spinAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.gradientLayer pop_addAnimation:spinAnimation forKey:@"spinAnimation"];
}

- (void)startIconViewAnimationWithImage:(UIImage *)image {
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    
    self.iconView.image = image;
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyAnimation.values = @[
                            [NSValue valueWithCGPoint:CGPointMake(width / 2, height - 30)],
                            [NSValue valueWithCGPoint:CGPointMake(width / 2, height / 2 - 2)],
                            [NSValue valueWithCGPoint:CGPointMake(width / 2, height / 2)],
                            [NSValue valueWithCGPoint:CGPointMake(width / 2, height / 2)],
                            [NSValue valueWithCGPoint:CGPointMake(width / 2, 35)],
                            ];
    keyAnimation.keyTimes = @[
                              @0,
                              @0.4,
                              @0.43,
                              @0.6,
                              @1
                              ];
    keyAnimation.duration = 1.5;
    keyAnimation.repeatCount = CGFLOAT_MAX;
    keyAnimation.removedOnCompletion = YES;
    
    CAKeyframeAnimation *alphaAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.values = @[
                              @0,
                              @1,
                              @1,
                              @0,
                              ];
    alphaAnimation.keyTimes = @[
                                @0,
                                @0.4,
                                @0.6,
                                @1
                                ];
    alphaAnimation.duration = 1.5;
    alphaAnimation.repeatCount = CGFLOAT_MAX;
    alphaAnimation.removedOnCompletion = YES;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 1.5;
    group.removedOnCompletion = YES;
    group.animations = @[
                         keyAnimation,
                         alphaAnimation,
                         ];
    group.completionBlock = ^(BOOL finish) {
        if (finish) {
            [self startIconViewAnimationWithImage:[self iconImage]];
        }
    };
    [self.iconView.layer addAnimation:group forKey:@"key"];
}


- (CALayer *)iconLayer {
    if (!_iconLayer) {
        _iconLayer = [CALayer layer];
        _iconLayer.frame = CGRectMake(0, 0, 20, 20);
        _iconLayer.position = CGPointMake(CGRectGetWidth(self.layer.bounds) / 2, CGRectGetHeight(self.layer.bounds) / 2);
        _iconLayer.contents = (id)[UIImage imageNamed:@"emitter_fruit_2"].CGImage;
    }
    return _iconLayer;
}

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 42, 42)];
        _iconView.alpha = 0;
        CGFloat width = CGRectGetWidth(self.frame);
        CGFloat height = CGRectGetHeight(self.frame);
        _iconView.layer.position = CGPointMake(width / 2, height - 20);
    }
    return _iconView;
}

- (CAShapeLayer *)shaperLayer {
    if (!_shaperLayer) {
        _shaperLayer = [CAShapeLayer layer];
        _shaperLayer.frame = self.layer.bounds;
        CGPoint center = CGPointMake(CGRectGetMidX(self.layer.bounds), CGRectGetMidY(self.layer.bounds));
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        [bezierPath addArcWithCenter:center
                              radius:(CGRectGetWidth(self.layer.bounds) - 5.0) / 2
                          startAngle:0.5 * M_PI
                            endAngle:-0.5 * M_PI
                           clockwise:YES];
        
        _shaperLayer.path = bezierPath.CGPath;
        _shaperLayer.lineCap = kCALineCapRound;
        _shaperLayer.lineWidth = 5;
        _shaperLayer.fillColor = [UIColor clearColor].CGColor;
        _shaperLayer.strokeColor = [UIColor redColor].CGColor;
    }
    return _shaperLayer;
}

- (CAGradientLayer *)gradientLayer {
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.startPoint = CGPointMake(0, 0);
        _gradientLayer.endPoint = CGPointMake(0, 0.98);
        _gradientLayer.colors = @[
                                  (id)[UIColor blueColor].CGColor,
                                  (id)[UIColor clearColor].CGColor,
                                  ];
        _gradientLayer.frame = self.layer.bounds;
        _gradientLayer.mask = self.shaperLayer;
    }
    return _gradientLayer;
}

- (NSArray *)images {
    if (!_images) {
        _images = @[
                    @"ic_face_1",
                    @"ic_face_2",
                    @"ic_face_3",
                    @"ic_face_4",
                    @"ic_face_5",
                    @"ic_face_6",
                    @"ic_face_7",
                    ];
    }
    return _images;
}

@end
