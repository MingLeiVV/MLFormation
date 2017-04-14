//
//  MLFormationMap+Layout.m
//  MLChannelEdit
//
//  Created by Minlay on 17/4/14.
//  Copyright © 2017年 Minlay. All rights reserved.
//

#import "MLFormationMap+Layout.h"
#import "MLDistributeItem.h"
#import "MLFormationUI.h"

@implementation MLFormationMap (Layout)
- (void)initFormation_433 {
    
    MLDistributeItem *CF = [MLDistributeItem new];
    CF.frame = CGRectMake(50, 50, 50, 50);
    [self.formationView addSubview:CF];
    [self.formationUI addObjectType:DistributeTypeForward object:CF];
    
    MLDistributeItem *ST = [MLDistributeItem new];
    ST.frame = CGRectMake(200, 50, 50, 50);
    [self.formationView addSubview:ST];
    [self.formationUI addObjectType:DistributeTypeForward object:ST];
    
    MLDistributeItem *SS = [MLDistributeItem new];
    SS.frame = CGRectMake(50, 150, 50, 50);
    [self.formationView addSubview:SS];
    [self.formationUI addObjectType:DistributeTypeForward object:SS];
    
    MLDistributeItem *AMF = [MLDistributeItem new];
    AMF.frame = CGRectMake(200, 150, 50, 50);
    [self.formationView addSubview:AMF];
    [self.formationUI addObjectType:DistributeTypeMid object:AMF];
    
    MLDistributeItem *CMF = [MLDistributeItem new];
    CMF.frame = CGRectMake(50, 300, 50, 50);
    [self.formationView addSubview:CMF];
    [self.formationUI addObjectType:DistributeTypeMid object:CMF];
    
    MLDistributeItem *DMF = [MLDistributeItem new];
    DMF.frame = CGRectMake(200, 300, 50, 50);
    [self.formationView addSubview:DMF];
    [self.formationUI addObjectType:DistributeTypeMid object:DMF];
    
}
- (void)initFormation_442 {}
- (void)initFormation_532 {}
- (void)initFormation_352 {}
- (void)initFormation_4321 {}
- (void)initFormation_460 {}
- (void)initFormation_0 {
    // 错误
}
//- (void)initFormation_433 {}
//- (void)initFormation_433 {}
//- (void)initFormation_433 {}
@end
