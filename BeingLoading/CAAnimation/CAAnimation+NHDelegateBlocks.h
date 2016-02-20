//
//  CAAnimation+NHDelegateBlocks.h
//  Being
//
//  Created by xiaofeng on 16/1/26.
//  Copyright © 2016年 Being Inc. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CAAnimation (NHDelegateBlocks)
@property (copy, nonatomic) void (^completionBlock)(BOOL finished);
@property (copy, nonatomic) void (^startBlock)(void);

- (void)setCompletionBlock:(void (^)(BOOL))completionBlock;
@end
