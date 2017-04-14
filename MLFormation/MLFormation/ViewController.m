//
//  ViewController.m
//  MLFormation
//
//  Created by Minlay on 17/4/14.
//  Copyright © 2017年 Minlay. All rights reserved.
//

#import "ViewController.h"
#import "MLFormationMap.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 [self.view addSubview: [MLFormationMap formationMapWithFrame:self.view.bounds mapType:MLFormationMapType_433 teamMember:nil arrangeList:nil]];
}




@end
