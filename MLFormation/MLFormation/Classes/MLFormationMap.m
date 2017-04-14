//
//  MLFormationMap.m
//  MLChannelEdit
//
//  Created by Minlay on 17/4/6.
//  Copyright © 2017年 Minlay. All rights reserved.
//

#import "MLFormationMap.h"
#import "UIView+Position.h"
#import "MLElement.h"
#import "MLDistributeItem.h"
#import "MLFormationData.h"
#import "MLFormationUI.h"

#define ElementY FormationHeight + 20
#define FormationHeight (self.height - 100)
@interface MLFormationMap ()<MLElementDelegate>
// data
@property(nonatomic, strong)MLFormationData *teamMemberData; // 成员排布元素
// ui
@property(nonatomic, strong)UIView *formationView;
@property(nonatomic, strong)UIScrollView *teamView;
@property(nonatomic, strong)UIView *teamBgView;
// recordFormationUI
@property(nonatomic, strong)MLFormationUI *formationUI;
// recordElementUI
@property(nonatomic, strong)NSMutableArray *memberList;
@property(nonatomic, strong)NSMutableArray *distributeList;

// 当前操作的元素
@property(nonatomic, strong)MLElement *currentHandelView;
@end


@implementation MLFormationMap



+ (instancetype)formationMapWithFrame:(CGRect)frame
                              mapType:(MLFormationMapType)mapType
                           teamMember:(NSArray *)member
                          arrangeList:(NSDictionary *)arrangeList {
    MLFormationMap *map = [[MLFormationMap alloc]initWithFrame:frame];
    map.mapType = mapType;
    map.teamMemberData.allMemberData = member;
    [map setup];
    return map;
}

- (void)parseData {
    self.teamMemberData.allMemberData = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13"];
    self.teamMemberData.forwardData = @[@"1",@"5",@"6"].mutableCopy;
    self.teamMemberData.midfieldData = @[@"7",@"9",@"2"].mutableCopy;
}
- (void)setup {
    [self parseData];
    
    // 创建ui
    [self addSubview:self.formationView];
    [self addSubview:self.teamBgView];
    [self.teamBgView addSubview:self.teamView];
    NSString *methodStr = [NSString stringWithFormat:@"initFormation_%lu",(unsigned long)self.mapType];
    SEL method = NSSelectorFromString(methodStr);
    [self performSelector:method];
    
    [self initTeamMember];
}
#pragma mark - UI

- (void)initTeamMember {
    // 此遍历第一创建元素，第二是给每个元素赋予初始index
    for (NSInteger i = 0 ; i < self.teamMemberData.allMemberData.count; i++) {
        MLElement *element = [MLElement new];
        NSString *obj = self.teamMemberData.allMemberData[i];
        element.font = [UIFont systemFontOfSize:13];
        [element setBackgroundColor:[UIColor redColor]];
        [element setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [element setTitle:obj forState:UIControlStateNormal];
        element.delegate = self;
        element.tag = i;
        element.index = i;
        element.userId = obj;
        element.backgroundColor = [UIColor redColor];
        [self.teamView addSubview:element];
        
        // 是否已经参与布阵
        if ([self handelDistributeElement:DistributeTypeForward element:element] ||
            [self handelDistributeElement:DistributeTypeMid element:element] ||
            [self handelDistributeElement:DistributeTypeGuard element:element] ||
            [self handelDistributeElement:DistributeTypeKeeper element:element]) {
            
            [self.distributeList addObject:element];
            [self changeSuperView:element isWindow:YES];
            
        }else {
            [self.memberList addObject:element];
        }
    
    }
    
    
    [self layoutElement:0 animationTime:0];
}

- (void)layoutElement:(NSInteger)index animationTime:(NSTimeInterval)duration {
    
    // 队员布局
    static CGFloat elementMargin = 5;
    for (NSInteger i = index; i < self.memberList.count; i++) {
        MLElement *element = self.memberList[i];
        // tag根据成员变动每次更新，用于布局
        element.tag = i;
        CGFloat w = 50;
        CGFloat x = i * (w + elementMargin);
        
        [UIView animateWithDuration:duration animations:^{
           element.frame = CGRectMake(x, ElementY, w, w);
        }];
    }
    MLElement *lastElement = self.memberList.lastObject;
   CGFloat maxWidth = CGRectGetMaxX(lastElement.frame);
    self.teamView.contentSize = CGSizeMake(maxWidth, self.height);
}

- (BOOL)handelDistributeElement:(DistributeType)type element:(MLElement *)elememt {
    
    NSArray *dataSource = nil;
    NSArray *formationUISource = nil;
    NSInteger index = 0;
    if (type == DistributeTypeForward) {
        dataSource = self.teamMemberData.forwardData;
        formationUISource = self.formationUI.forwardDistribute;
    }else if (type == DistributeTypeMid) {
        dataSource = self.teamMemberData.midfieldData;
        formationUISource = self.formationUI.midfieldDistribute;
    }else if (type == DistributeTypeGuard) {
        dataSource = self.teamMemberData.guardData;
        formationUISource = self.formationUI.guardDistribute;
    }else if (type == DistributeTypeKeeper) {
        dataSource = self.teamMemberData.keeperData;
        formationUISource = self.formationUI.keeperDistribute;
    }
    
    if ([dataSource containsObject:elememt.userId]) {
        for (NSInteger i = 0; i < dataSource.count; i++) {
            NSString *userId = dataSource[i];
            if ([elememt.userId isEqualToString:userId]) {
                index = i;
                break;
            }
            
        }
        
        MLDistributeItem *item = formationUISource[index];
        item.containElement = elememt;
        elememt.isArrange = YES;
        elememt.belongSpace = item;
        elememt.frame = item.frame;
        [self changeSuperView:elememt isWindow:YES];
        
        return YES;
    }
    return NO;
}


#pragma mark - MLElementDelegate
- (void)clickItem:(MLElement *)element {
    self.currentHandelView = element;
    if (self.currentHandelView.isArrange) {
        [self backStartPosition];
    }else {
        
    }
}


- (void)dragingEnd:(MLElement *)element gestureRecognizer:(UIGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.currentHandelView = element;
        element.belongSpace.containElement = nil;
        [self.memberList removeObject:self.currentHandelView];
        [self layoutElement:self.currentHandelView.tag animationTime:0.3];
    }
    
    if (gesture.state == UIGestureRecognizerStateChanged) {
        
        CGPoint point =  [gesture locationInView:element.isArrange ? self : self.teamView];
        
        [UIView animateWithDuration:0.1 animations:^{
            element.center = point;
        }];
    }
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        [self dragEnd];
    }
}
- (void)changeSuperView:(MLElement *)element isWindow:(BOOL)isWindow {
    if (isWindow) {
        [element removeFromSuperview];
        [self addSubview:element];
        [self bringSubviewToFront:element];
    }else {
        [element removeFromSuperview];
        [self.teamView addSubview:element];
        if (element.isArrange) {
             element.x = element.x + self.teamView.contentOffset.x;
        }
        
    }
}

- (void)dragEnd {
    BOOL moveEnd = 0;
    CGPoint relativeCenter = [self.currentHandelView.superview convertPoint:self.currentHandelView.center toView:nil];
    for (MLDistributeItem *item in self.formationUI.formationMember) {
        if (CGRectContainsPoint(item.frame, relativeCenter) && !item.containElement) {
            item.containElement = self.currentHandelView;
            self.currentHandelView.isArrange = YES;
            self.currentHandelView.belongSpace = item;
            [self.distributeList addObject:self.currentHandelView];
            self.currentHandelView.center = relativeCenter;
            [UIView animateWithDuration:0.2 animations:^{
                self.currentHandelView.frame = item.frame;
            }];
            [self changeSuperView:self.currentHandelView isWindow:YES];
            moveEnd = 1;
            break;
        }
    }
    
    if (!moveEnd) {
        [self backStartPosition];
    }
}
// 回到初始位置
- (void)backStartPosition {
    
    [self changeSuperView:self.currentHandelView isWindow:NO];
    NSInteger start = self.currentHandelView.index;
    self.currentHandelView.isArrange = NO;
    self.currentHandelView.belongSpace.containElement = nil;
    self.currentHandelView.belongSpace = nil;
    [self.distributeList removeObject:self.currentHandelView];
    
    MLElement *small = nil;
    for (NSInteger i = self.memberList.count - 1; i >= 0; i--) {
        MLElement *element = self.memberList[i];
        if (start > element.index) {
            small = element;
            break;
        }
    }
    // 没有找到说明当前操作的元素就是首元素
    NSInteger index = 0;
    // 找到元素
    if (small) {
        index = small.tag + 1;
    }
    [self.memberList insertObject:self.currentHandelView atIndex:index];
    [self layoutElement:index animationTime:0.3];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       [self scrollAnimation];
    });
    
}

// 操作元素，scroll做滚动展示
- (void)scrollAnimation {
    
    CGFloat scrollViewOffsetX = self.teamView.contentOffset.x;
    CGRect screenItemFrame = [self.currentHandelView convertRect:self.bounds toView:nil];
    CGFloat distance = screenItemFrame.origin.x  - self.centerX;
    
    if (scrollViewOffsetX + self.currentHandelView.centerX > self.teamView.centerX) {
        
        CGFloat showX = scrollViewOffsetX + distance + self.currentHandelView.width;
        
        if (showX < 0) {
            showX = 0;
        }
        if (showX + self.teamView.width >= self.teamView.contentSize.width) {
            showX = self.teamView.contentSize.width - self.teamView.width;
        }
        [self.teamView setContentOffset:CGPointMake(showX, 0) animated:YES];
    }else {
        [self.teamView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}



#pragma mark - lazy

- (UIView *)formationView {
    if (!_formationView) {
        _formationView = [[UIView alloc]initWithFrame:self.bounds];
        _formationView.height = FormationHeight;
        _formationView.backgroundColor = [UIColor lightGrayColor];
    }
    return _formationView;
}
- (UIScrollView *)teamView {
    if (!_teamView) {
        self.backgroundColor = [UIColor clearColor];
        _teamView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -FormationHeight, self.width, self.height)];
        _teamView.showsHorizontalScrollIndicator = NO;
    }
    return _teamView;
}
- (UIView *)teamBgView {
    if (!_teamBgView) {
        _teamBgView = [[UIView alloc]initWithFrame:self.bounds];
        _teamBgView.backgroundColor = [UIColor clearColor];
        _teamBgView.y = FormationHeight;
        _teamBgView.height = 100;
    }
    return _teamBgView;
}



- (MLFormationData *)teamMemberData {
    if (!_teamMemberData) {
        _teamMemberData = [[MLFormationData alloc]init];
    }
    return _teamMemberData;
}

- (MLFormationUI *)formationUI {
    if (!_formationUI) {
        _formationUI = [[MLFormationUI alloc]init];
    }
    return _formationUI;
}

- (NSMutableArray *)memberList {
    if (!_memberList) {
        _memberList = [NSMutableArray arrayWithCapacity:self.teamMemberData.allMemberData.count];
    }
    return _memberList;
}
- (NSMutableArray *)distributeList {
    if (!_distributeList) {
        _distributeList = [NSMutableArray arrayWithCapacity:11];
    }
    return _distributeList;
}
@end
