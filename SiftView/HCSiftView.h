//
//  HCSiftView.h
//  SiftView
//
//  Created by hc on 2017/2/7.
//  Copyright © 2017年 hc. All rights reserved.
//

#import <UIKit/UIKit.h>
#define BUTTON_TAG_BEGIN 1000
#define IMAGE_TAG_BEGIN 2000

#define RGB(R,G,B)    [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
#define kWindowH            [UIScreen mainScreen].bounds.size.height
#define kWindowW            [UIScreen mainScreen].bounds.size.width

@protocol HCSiftViewDelegate <NSObject>

@required
- (void)selectedSection:(NSInteger)section row:(NSInteger)row;

@end

@interface HCSiftView : UIView <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign) id <HCSiftViewDelegate>delegate;

/**
 遮盖背景
 */
@property (nonatomic,strong) UIView *backGroundView;

/**
 表视图
 */
@property (nonatomic,strong) UITableView *tableView;

/**
 tint color
 */
@property (nonatomic,strong) UIColor *titleColor;

- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArr delegate:(id)delegate;
@end
