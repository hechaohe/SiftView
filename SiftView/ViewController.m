//
//  ViewController.m
//  SiftView
//
//  Created by hc on 2017/2/7.
//  Copyright © 2017年 hc. All rights reserved.
//

#import "ViewController.h"
#import "HCSiftView.h"
@interface ViewController () <HCSiftViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *titlesArr = @[@[@"AAAA",@"BBBB",@"CCCC"],
                           @[@"DDDD",@"EEEE",@"FFFF"],
                           @[@"QQQQ",@"WWWW",@"EEEE",@"RRRR",@"TTTT",@"YYY"]];
    
    HCSiftView *siftView = [[HCSiftView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 40) dataArray:titlesArr delegate:self];
    siftView.titleColor = [UIColor redColor];
    [self.view addSubview:siftView];
    
}

- (void)selectedSection:(NSInteger)section row:(NSInteger)row {
    
    NSLog(@"%lu %lu",section,row);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
