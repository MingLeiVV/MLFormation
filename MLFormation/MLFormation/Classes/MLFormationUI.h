//
//  MLFormationUI.h
//  MLChannelEdit
//
//  Created by Minlay on 17/4/11.
//  Copyright © 2017年 Minlay. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, DistributeType) {
    DistributeTypeForward,
    DistributeTypeMid,
    DistributeTypeGuard,
    DistributeTypeKeeper,
};
@interface MLFormationUI : NSObject
@property(nonatomic, strong)NSMutableArray *formationMember;// 布阵位置
@property(nonatomic, strong)NSMutableArray *forwardDistribute;// 前锋
@property(nonatomic, strong)NSMutableArray *midfieldDistribute;// 中场
@property(nonatomic, strong)NSMutableArray *guardDistribute;// 后卫
@property(nonatomic, strong)NSMutableArray *keeperDistribute;// 门将

- (void)addObjectType:(DistributeType)type object:(NSObject *)object;
@end
