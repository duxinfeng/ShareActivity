//
//  ShareActivity.m
//  iDuShare
//
//  Created by duxinfeng on 14-5-7.
//  Copyright (c) 2014年 新风作浪. All rights reserved.
//

#import "ShareActivity.h"

#define WINDOW_COLOR    [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]
#define kThemeGreenColor [UIColor colorWithRed:68/255.0f green:197/255.0f blue:210/255.0f alpha:1]
#define DF_COLOR(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]

#define ANIMATE_DURATION    0.25f
#define NOW_HEIGHT(a) (a.frame.origin.y + a.frame.size.height)
#define BTNTAG 123456

@interface ShareActivity ()

@property (nonatomic,strong) UIView *backGroundView;
@property (nonatomic,assign) CGFloat activityHeight;
@property (nonatomic,strong) NSArray *snsarray;

@end

@implementation ShareActivity

-(instancetype)initShareActivityView
{
    self = [super init];
    if (self) {
        //初始化背景视图，添加手势
        self.alpha = 0.0;
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.backgroundColor = WINDOW_COLOR;
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
        [self addGestureRecognizer:tapGesture];
        [self configShareActivity];
    }
    return self;

}

-(void)configShareActivity
{
    self.backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
    self.backGroundView.backgroundColor = DF_COLOR(233, 233, 233);
    
    [self addSubview:self.backGroundView];

    NSArray *imagearr = [NSArray arrayWithObjects:@"sns_icon_5",@"sns_icon_4",@"sns_icon_1",@"sns_icon_2",@"sns_icon_3",@"sns_icon_7",@"sns_icon_8",nil];
    NSArray *titlearray = [NSArray arrayWithObjects:@"朋友圈",@"微信",@"新浪微博",@"手机QQ",@"QQ空间",@"复制文字",@"保存图片",nil];
        
    CGFloat leftX = 20;
    CGFloat upY = 25;
    CGFloat wideR = 55;
    CGFloat highR = 55;
    CGFloat spaceX = 20;
    CGFloat spaceY = 74.0/2;
    NSInteger row = 4;
    
    NSInteger screen_W = [UIScreen mainScreen].bounds.size.width;
    
    if (screen_W==375) {
        wideR = highR = (screen_W-2*leftX-3*spaceX)/4;
    }else if (screen_W==414){
        row=5;
        wideR = highR = (screen_W-2*leftX-4*spaceX)/5;
    }else{
        wideR = highR = (screen_W-2*leftX-3*spaceX)/4;
    }

    // line
    {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 2)];
        line.backgroundColor = kThemeGreenColor;
        [self.backGroundView addSubview:line];
    }
    
    //title
    {
        UILabel *label = [[UILabel alloc]init];
        [self.backGroundView addSubview:label];
        label.frame = CGRectMake(leftX, 10, [UIScreen mainScreen].bounds.size.width-2*leftX, 30);
        //        label.textColor = DF_Color_WC(255);
        label.text = @"分享到:";
        label.font = [UIFont systemFontOfSize:16];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        upY = NOW_HEIGHT(label)+5;
    }
    
    for (int i = 0; i < imagearr.count; i++) {
        int nowrow = i%row;
        int nowline = i/row;
        
        UIImage *image = [UIImage imageNamed:[imagearr objectAtIndex:i]];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:image forState:UIControlStateNormal];

        button.tag = BTNTAG + i;
        if (i < imagearr.count) {
            [button setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
        }
        button.frame = CGRectMake(leftX+(wideR+spaceX)*nowrow, upY+(highR+spaceY)*nowline, wideR, highR);
        [button addTarget:self action:@selector(more_sub_Click:) forControlEvents:UIControlEventTouchUpInside];
        [self.backGroundView addSubview:button];
        
        //文字
        UILabel *label = [[UILabel alloc]init];
        if (i < titlearray.count) {
            label.text = [titlearray objectAtIndex:i];
        }
        label.font = [UIFont systemFontOfSize:13];
        label.backgroundColor = [UIColor clearColor];
        CGSize size = [label sizeThatFits:label.frame.size];
        label.frame = CGRectMake(0, NOW_HEIGHT(button)+5, size.width, size.height);
        label.center = CGPointMake(button.center.x, label.center.y);
        [self.backGroundView addSubview:label];
        self.activityHeight = NOW_HEIGHT(label);
        
    }
    
    // 取消button
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, self.activityHeight+5, [UIScreen mainScreen].bounds.size.width, 50);
        [button setTitle:@"取消" forState:UIControlStateNormal];
        [button setTitle:@"取消" forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:kThemeGreenColor forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(tappedCancel) forControlEvents:UIControlEventTouchUpInside];
        [self.backGroundView addSubview:button];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
        line.backgroundColor = kThemeGreenColor;
        [button addSubview:line];
        
        self.activityHeight = NOW_HEIGHT(button);
        if (@available(iOS 11.0, *)) {
            self.activityHeight += [[[UIApplication sharedApplication] delegate] window].safeAreaInsets.bottom;
        }
    }
    
}

-(void)more_sub_Click:(UIButton *)sender
{
    NSLog(@"button.tag = %zd",sender.tag);
    
    [self tappedCancel];
}

- (void)show
{
    [[UIApplication sharedApplication].delegate.window addSubview:self];
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        self.alpha = 1.0;
        [self.backGroundView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-self.activityHeight, [UIScreen mainScreen].bounds.size.width, self.activityHeight)];
    } completion:^(BOOL finished) {
    
    }];
}


- (void)tappedCancel
{
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        [self.backGroundView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

@end
