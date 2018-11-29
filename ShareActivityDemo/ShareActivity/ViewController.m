//
//  ViewController.m
//  ShareActivity
//
//  Created by HD on 15/7/12.
//  Copyright (c) 2015年 niux Tech. All rights reserved.
//

#import "ViewController.h"
#import "ShareActivity.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0,0,200, 50);
        button.center = self.view.center;
        [button setTitle:@"分享" forState:UIControlStateNormal];
        [button setTitle:@"分享" forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(showShareActivity:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
    }
}

- (void)showShareActivity:(id)sender
{
    ShareActivity *sa = [[ShareActivity alloc] initShareActivityView];
    [sa show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
