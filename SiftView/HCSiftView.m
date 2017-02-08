//
//  HCSiftView.m
//  SiftView
//
//  Created by hc on 2017/2/7.
//  Copyright © 2017年 hc. All rights reserved.
//

#import "HCSiftView.h"

@interface HCSiftView ()

@property (nonatomic,strong) NSArray *dataArr;

/**
 当前展开的tableview
 */
@property (nonatomic,assign) NSInteger currentExtendSection;

@property (nonatomic,strong) NSMutableArray *btnTitleArray;

@end

@implementation HCSiftView

- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArr delegate:(id)delegate {
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = delegate;
        _dataArr = dataArr;
        [self createUI];
    }
    return self;
}
- (void)createUI {
    
    _btnTitleArray = [NSMutableArray arrayWithCapacity:5];
    self.backgroundColor = [UIColor whiteColor];
    _currentExtendSection = -1;
    
    CGFloat sectionWidth = (self.bounds.size.width / _dataArr.count);
    for (int i = 0; i < _dataArr.count; i ++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(sectionWidth * i, 1, sectionWidth, self.bounds.size.height - 2)];
        btn.tag = BUTTON_TAG_BEGIN + i;
        [btn addTarget:self action:@selector(titleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        NSString *btnTitle = _dataArr[i][0];
        [_btnTitleArray addObject:btnTitle];
        
        
        [btn setTitle:btnTitle forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.backgroundColor = [UIColor whiteColor];
        [self addSubview:btn];
        
        UIImageView *btnImage = [[UIImageView alloc] initWithFrame:CGRectMake(sectionWidth * i + (sectionWidth - 16), (self.bounds.size.height - 12) / 2, 12, 12)];
        [btnImage setImage:[[UIImage imageNamed:@"arrow_down"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        btnImage.tintColor = [UIColor grayColor];
        btnImage.contentMode = UIViewContentModeScaleAspectFit;
        btnImage.tag = IMAGE_TAG_BEGIN + i;
        [self addSubview:btnImage];
        
        if (i < _dataArr.count && i > 0) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(sectionWidth * i, self.bounds.size.height / 4, 1, self.bounds.size.height /2)];
            line.backgroundColor = [UIColor lightGrayColor];
            [self addSubview:line];
        }
    }
    
    self.backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.frame), kWindowW, kWindowH - self.bounds.origin.y - self.bounds.size.height)];
    self.backGroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    
    UITapGestureRecognizer *bgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgtapAction:)];
    [self.backGroundView addGestureRecognizer:bgTap];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.frame.origin.x, CGRectGetMaxY(self.frame), kWindowW, 0) style:UITableViewStylePlain];
    self.tableView.scrollEnabled = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

}

- (void)bgtapAction:(UITapGestureRecognizer *)tap {
    [self hideExtendedView];
}

- (void)recoverAllSectionBtnStatus {
    for (UIView *tmpView in [self subviews]) {
        if (tmpView.tag >= BUTTON_TAG_BEGIN && [tmpView isKindOfClass:[UIButton class]]) {
            [(UIButton *)tmpView setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
        
        if (tmpView.tag >= IMAGE_TAG_BEGIN && [tmpView isKindOfClass:[UIImageView class]]) {
            [(UIImageView *)tmpView setImage:[[UIImage imageNamed:@"arrow_down"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
            ((UIImageView *)tmpView).tintColor = [UIColor grayColor];
        }
    }
}

- (void)titleButtonAction:(UIButton *)btn {
    NSInteger section = btn.tag - BUTTON_TAG_BEGIN;
    
    if (_currentExtendSection == section) {
        [self hideExtendedView];
    } else {
        if (!_titleColor) {
            _titleColor = [UIColor blueColor];
        }
        _currentExtendSection = section;
        [self recoverAllSectionBtnStatus];
        [btn setTitleColor:_titleColor forState:UIControlStateNormal];
        
        UIImageView *currentImage = (UIImageView *)[self viewWithTag:(IMAGE_TAG_BEGIN + section)];
        [currentImage setImage:[[UIImage imageNamed:@"arrow_up"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        currentImage.tintColor = _titleColor;
        
        [self showExtentedView];
    }
}


- (void)hideExtendedView {
    [self recoverAllSectionBtnStatus];
    
    if (_currentExtendSection != -1) {
        _currentExtendSection = -1;
        [UIView animateWithDuration:0.2
                         animations:^{
                             CGRect frame = self.tableView.frame;
                             frame.size.height = 0;
                             self.tableView.frame = frame;
                             self.backGroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
                         } completion:^(BOOL finished) {
                             [self.tableView removeFromSuperview];
                             [self.backGroundView removeFromSuperview];
                         }];
    }
}


- (void)showExtentedView {
    [self.superview addSubview:self.backGroundView];
    [self.superview addSubview:self.tableView];
    
    CGFloat tableViewHeight = ([_dataArr[_currentExtendSection] count] * 40);
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         CGRect frame = self.tableView.frame;
                         frame.size.height = tableViewHeight;
                         self.tableView.frame = frame;
                         self.backGroundView.backgroundColor = [UIColor colorWithWhite:0.5f alpha:0.2];
                     }];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArr[_currentExtendSection] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = _dataArr[_currentExtendSection][indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.textColor = [UIColor grayColor];
    if ([cell.textLabel.text isEqualToString:[_btnTitleArray objectAtIndex:_currentExtendSection]]) {
        cell.tintColor = _titleColor;
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.textLabel.textColor = _titleColor;
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *selectedCellTitle = _dataArr[_currentExtendSection][indexPath.row];
    [_btnTitleArray setObject:selectedCellTitle atIndexedSubscript:_currentExtendSection];
    
    UIButton *currentBtn = (UIButton *)[self viewWithTag:1000 + _currentExtendSection];
    
    [currentBtn setTitle:selectedCellTitle forState:UIControlStateNormal];
    
    if ([self.delegate respondsToSelector:@selector(selectedSection:row:)]) {
        [self.delegate selectedSection:_currentExtendSection row:indexPath.row];
    }

    [self hideExtendedView];
}

@end
