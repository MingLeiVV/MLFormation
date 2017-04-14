//
//  FormationData.m
//  MLChannelEdit
//
//  Created by Minlay on 17/4/10.
//  Copyright © 2017年 Minlay. All rights reserved.
//

#import "MLFormationData.h"

@implementation MLFormationData

- (instancetype)init {
    if ([super init]) {
        self.forwardData = [NSArray array];
        self.midfieldData = [NSArray array];
        self.guardData = [NSArray array];
    }
    return self;
}

@end
