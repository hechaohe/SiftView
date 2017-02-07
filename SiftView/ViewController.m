//
//  ViewController.m
//  SiftView
//
//  Created by hc on 2017/2/7.
//  Copyright © 2017年 hc. All rights reserved.
//

#import "ViewController.h"
#import "HCSiftView.h"
@interface ViewController ()

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

-(void)choosedAtSection:(NSInteger)section index:(NSInteger)index
{
    NSLog(@"点击了%lu的%lu",section,index);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
