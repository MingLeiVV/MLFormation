//
//  MLDistributeItem.m
//  MLChannelEdit
//
//  Created by Minlay on 17/4/5.
//  Copyright © 2017年 Minlay. All rights reserved.
//

#import "MLDistributeItem.h"

@implementation MLDistributeItem
- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.borderWidth = 1;
        self.layer.cornerRadius = 25;
        self.clipsToBounds = YES;
    }
    return self;
}
@end
