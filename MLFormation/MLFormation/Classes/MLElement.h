//
//  MLElement.h
//  MLChannelEdit
//
//  Created by Minlay on 17/4/6.
//  Copyright © 2017年 Minlay. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MLElement;
@class MLDistributeItem;
@protocol MLElementDelegate <NSObject>
- (void)dragingEnd:(MLElement *)element gestureRecognizer:(UIGestureRecognizer *)gesture;
- (void)clickItem:(MLElement *)element;

@end
@interface MLElement : UIButton
@property(nonatomic, assign)NSString *userId;
@property(nonatomic, assign)NSInteger index;
@property(nonatomic, assign)BOOL isArrange;
@property(nonatomic, strong)MLDistributeItem *belongSpace;
@property(nonatomic, assign)id<MLElementDelegate> delegate;
@end
