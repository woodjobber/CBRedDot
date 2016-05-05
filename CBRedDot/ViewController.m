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
    UIView *view = [[UIView alloc]init];
    
    view.frame = CGRectMake(100, 200, 100, 100);
    view.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:view];
    
    CBRedDot *redDot  = [[CBRedDot alloc]init];
    
    [view addSubview:redDot];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
