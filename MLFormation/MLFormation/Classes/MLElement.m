//
//  MLElement.m
//  MLChannelEdit
//
//  Created by Minlay on 17/4/6.
//  Copyright © 2017年 Minlay. All rights reserved.
//

#import "MLElement.h"

@implementation MLElement
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.layer.cornerRadius = 25;
    self.clipsToBounds = YES;
    [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(drag:)]];
    [self addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
}
- (void)drag:(UIGestureRecognizer *)ges {
    if ([_delegate respondsToSelector:@selector(dragingEnd:gestureRecognizer:)]) {
        [_delegate dragingEnd:self gestureRecognizer:ges];
    }
}

- (void)click {
    if ([_delegate respondsToSelector:@selector(clickItem:)]) {
        [_delegate clickItem:self];
    }
}

@end
