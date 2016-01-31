//
//  NHLoadingView.m
//  BeingLoading
//
//  Created by Wilson-Yuan on 16/1/31.
//  Copyright © 2016年 Wilson-Yuan. All rights reserved.
//

#import "NHLoadingView.h"
#import <POP.h>

@interface NHLoadingView ()

@property (strong, nonatomic) CAShapeLayer *shaperLayer;
@property (strong, nonatomic) CAGradientLayer *gradientLayer;
@property (strong, nonatomic) CALayer *iconLayer;
@property (strong, nonatomic) NSArray *images;

@end


@implementation NHLoadingView


- (void)awakeFromNib {
    
    [self.layer addSublayer:self.gradientLayer];
    [self.layer addSublayer:self.iconLayer];
    
    [self startAnimation];
}



- (void)startAnimation {
    POPBasicAnimation *spinAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
    spinAnimation.fromValue = @0;
    spinAnimation.toValue = @(2 * M_PI);
    spinAnimation.duration = 2.0;
    spinAnimation.repeatForever = YES;
    spinAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.gradientLayer pop_addAnimation:spinAnimation forKey:@"spinAnimation"];
}

- (void)startIconAnimation {
    
    CGFloat midX = CGRectGetMidX(self.layer.bounds);
    CGFloat height = CGRectGetHeight(self.layer.bounds);
    CAKeyframeAnimation *keyFrame = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    keyFrame.values = @[
//                        [NSValue valueWithCGPoint:CGPointMake(midX, height)],
//                        [NSValue valueWithCGPoint:cgp]
//                        ]
    
   
}


- (CALayer *)iconLayer {
    if (!_iconLayer) {
        _iconLayer = [CALayer layer];
        _iconLayer.bounds = CGRectMake(0, 0, 50, 50);
        _iconLayer.position = CGPointMake(CGRectGetMidX(self.layer.bounds), CGRectGetHeight(self.layer.bounds));
        _iconLayer.contents = [UIImage imageNamed:@"emitter_fruit_5"];
    }
    return _iconLayer;
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
        _gradientLayer.endPoint = CGPointMake(0, 0.9);
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
                    @"emitter_balloon_1",
                    @"emitter_balloon_2",
                    @"emitter_balloon_3",
                    @"emitter_balloon_4",
                    @"emitter_balloon_5",
                    @"emitter_balloon_6",
                    @"emitter_candy_1",
                    @"emitter_candy_2",
                    @"emitter_candy_3",
                    @"emitter_fruit_1",
                    @"emitter_fruit_2",
                    @"emitter_fruit_3",
                    @"emitter_fruit_4",
                    @"emitter_fruit_5",
                    @"emitter_other_1",
                    @"emitter_other_2",
                    ];
    }
    return _images;
}

@end
