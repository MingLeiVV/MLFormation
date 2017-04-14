//
//  MLFormationUI.m
//  MLChannelEdit
//
//  Created by Minlay on 17/4/11.
//  Copyright © 2017年 Minlay. All rights reserved.
//

#import "MLFormationUI.h"
#import "MLDistributeItem.h"

@implementation MLFormationUI

- (instancetype)init {
    if ([super init]) {
        self.formationMember = [NSMutableArray array];
        self.forwardDistribute = [[NSMutableArray alloc]init];
        self.midfieldDistribute = [NSMutableArray array];
        self.guardDistribute = [NSMutableArray array];
        self.keeperDistribute = [NSMutableArray array];
    }
    return self;
}

- (void)addObjectType:(DistributeType)type object:(NSObject *)object {
    [self.formationMember addObject:object];
    if (type == DistributeTypeForward) {
        [self.forwardDistribute addObject:object];
        return;
    }else if (type == DistributeTypeMid) {
        [self.midfieldDistribute addObject:object];
        return;
    }else if (type == DistributeTypeGuard) {
        [self.guardDistribute addObject:object];
        return;
    }else if (type == DistributeTypeKeeper) {
        [self.keeperDistribute addObject:object];
        return;
    }
}

@end
