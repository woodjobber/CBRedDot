//
//  ViewController.m
//  CBRedDot
//
//  Created by chengbin on 16/5/5.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import "ViewController.h"
#import "CBRedDot.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIView *instanceView = [[UIView alloc]init];
    instanceView.frame = CGRectMake(30, 100, 100, 100);
    instanceView.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:instanceView];
    
    UIView *instanceView2 = [[UIView alloc]init];
    instanceView2.frame = CGRectMake(250, 100, 100, 100);
    instanceView2.backgroundColor = [UIColor greenColor];
    
    [self.view addSubview:instanceView2];
    
    UIView *instanceView3 = [[UIView alloc]init];
    instanceView3.frame = CGRectMake(30, 300, 100, 100);
    instanceView3.backgroundColor = [UIColor brownColor];
    
    [self.view addSubview:instanceView3];
    
    UIView *instanceView4 = [[UIView alloc]init];
    instanceView4.frame = CGRectMake(250, 300, 100, 100);
    instanceView4.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:instanceView4];
    
    UIView *instanceView5 = [[UIView alloc]init];
    instanceView5.frame = CGRectMake(30, 500, 100, 100);
    instanceView5.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:instanceView5];
    
    
    UIView *instanceView6 = [[UIView alloc]init];
    instanceView6.frame = CGRectMake(250, 500, 100, 100);
    instanceView6.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:instanceView6];
    
    
    //创建小红点 并添加到 视图上
    [instanceView addSubview:[[CBRedDot alloc]init]];
    
    CBRedDot *redDot2 = [[CBRedDot alloc]init];
    redDot2.verticalAlignment = CBRedDotViewVerticalAlignmentMiddle;
    redDot2.horizontalAlignment = CBRedDotViewHorizontalAlignmentRight;
    [instanceView2 addSubview:redDot2];
    
    
    CBRedDot *redDot3 = [[CBRedDot alloc]init];
    redDot3.verticalAlignment = CBRedDotViewVerticalAlignmentBottom;
    redDot3.horizontalAlignment = CBRedDotViewHorizontalAlignmentRight;
    [instanceView3 addSubview:redDot3];
    
    
    CBRedDot *redDot4 = [[CBRedDot alloc]init];
    redDot4.verticalAlignment = CBRedDotViewVerticalAlignmentTop;
    redDot4.horizontalAlignment = CBRedDotViewHorizontalAlignmentLeft;
    [instanceView4 addSubview:redDot4];
    
    
    CBRedDot *redDot5 = [[CBRedDot alloc]init];
    redDot5.verticalAlignment = CBRedDotViewVerticalAlignmentMiddle;
    redDot5.horizontalAlignment = CBRedDotViewHorizontalAlignmentLeft;
    [instanceView5 addSubview:redDot5];
    
    CBRedDot *redDot6 = [[CBRedDot alloc]init];
    redDot6.verticalAlignment = CBRedDotViewVerticalAlignmentBottom;
    redDot6.horizontalAlignment = CBRedDotViewHorizontalAlignmentLeft;
    [instanceView6 addSubview:redDot6];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
