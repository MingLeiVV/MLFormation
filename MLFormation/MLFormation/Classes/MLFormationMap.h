//
//  MLFormationMap.h
//  MLChannelEdit
//
//  Created by Minlay on 17/4/6.
//  Copyright © 2017年 Minlay. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MLFormationData;
@class MLFormationUI;

typedef NS_ENUM(NSUInteger, MLFormationMapType) {
    MLFormationMapType_433 = 433,
    MLFormationMapType_442 = 442,
    MLFormationMapType_532 = 532,
    MLFormationMapType_352 = 352,
    MLFormationMapType_4321 = 4321,
    MLFormationMapType_460 = 460,
    MLFormationMapType_0 = 0,
};
@interface MLFormationMap : UIView
+ (instancetype)formationMapWithFrame:(CGRect)frame
                              mapType:(MLFormationMapType)mapType
                           teamMember:(NSArray *)member
                          arrangeList:(NSDictionary *)arrangeList;

@property(nonatomic, strong,readonly)UIView *formationView;
@property(nonatomic, strong,readonly)MLFormationUI *formationUI;
@property(nonatomic, assign)MLFormationMapType mapType;

@end
