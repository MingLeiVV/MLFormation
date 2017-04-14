//
//  FormationData.h
//  MLChannelEdit
//
//  Created by Minlay on 17/4/10.
//  Copyright © 2017年 Minlay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLFormationData : NSObject

@property(nonatomic, strong)NSArray *allMemberData; //球队全部成员
@property(nonatomic, strong)NSArray *forwardData;// 前锋成员
@property(nonatomic, strong)NSArray *midfieldData;// 中场成员
@property(nonatomic, strong)NSArray *guardData;// 后卫成员
@property(nonatomic, strong)NSArray *keeperData; // 门将
@end
