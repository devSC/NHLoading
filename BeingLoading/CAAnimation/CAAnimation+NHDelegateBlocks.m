//
//  CAAnimation+NHDelegateBlocks.m
//  Being
//
//  Created by xiaofeng on 16/1/26.
//  Copyright © 2016年 Being Inc. All rights reserved.
//

#import "CAAnimation+NHDelegateBlocks.h"

@interface CAAnimationDelegate : NSObject

@property (copy, nonatomic) void (^completionBlock)(BOOL finished);
@property (copy, nonatomic) void (^startBlock)(void);

- (void)animationDidStart:(CAAnimation *)anim;
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag;

@end

@implementation CAAnimationDelegate

- (void)dealloc {
    NSLog(@"CAAnimationDelegate dealloc!!!");
}

- (void)animationDidStart:(CAAnimation *)anim {
    if (self.startBlock != nil) {
        self.startBlock();
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (self.completionBlock != nil) {
        self.completionBlock(flag);
    }
}

@end


@implementation CAAnimation (NHDelegateBlocks)

- (void)setCompletionBlock:(void (^)(BOOL))completionBlock {
    if ([self.delegate isKindOfClass:[CAAnimationDelegate class]]) {
        ((CAAnimationDelegate *)self.delegate).completionBlock = completionBlock;
    }
    else {
        CAAnimationDelegate *delegate = [[CAAnimationDelegate alloc] init];
        delegate.completionBlock = completionBlock;
        self.delegate = delegate;
    }
}

- (void (^)(BOOL))completionBlock {
    return [self.delegate isKindOfClass:[CAAnimationDelegate class]]? ((CAAnimationDelegate *)self.delegate).completionBlock: nil;
}

- (void)setStartBlock:(void (^)(void))startBlock{
    if ([self.delegate isKindOfClass:[CAAnimationDelegate class]]) {
        ((CAAnimationDelegate *)self.delegate).startBlock = startBlock;
    }
    else {
        CAAnimationDelegate *delegate = [[CAAnimationDelegate alloc] init];
        delegate.startBlock = startBlock;
        self.delegate = delegate;
    }
}

- (void (^)(void))startBlock {
    return [self.delegate isKindOfClass:[CAAnimationDelegate class]]? ((CAAnimationDelegate *)self.delegate).startBlock: nil;
}
@end
