//
//  ViewController.m
//  YHLinkageDemo
//
//  Created by 张长弓 on 2018/1/8.
//  Copyright © 2018年 张长弓. All rights reserved.
//

#import "ViewController.h"

#import "YHTableView.h"
#import "YHSectionView.h"

#import "YHPosterTableViewCell.h"
#import "YHDescTableViewCell.h"
#import "YHContainerTableViewCell.h"

#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)]?CGSizeEqualToSize(CGSizeMake(1125, 2436),[[UIScreen mainScreen]currentMode].size):NO)

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,YHDContainerCellDelegate>

@property (nonatomic, strong) YHTableView *tableView;

@property (nonatomic, strong) YHSectionView *sectionView;

@property (nonatomic, strong) YHContainerTableViewCell *containerCell;

@property (nonatomic, assign) BOOL canScroll;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"联动Demo";

    [self.view addSubview:self.tableView];
    
    self.canScroll = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollStatus) name:@"leaveTop" object:nil];
}

#pragma mark - Notification

- (void)changeScrollStatus {
    self.canScroll = YES;
    self.containerCell.objectCanScroll = NO;
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView) {
        
        CGFloat offset = 64;
        if (iPhoneX) {
            offset = 88;
        }
        CGFloat bottomCellOffset = [self.tableView rectForSection:1].origin.y - offset;
        bottomCellOffset = floorf(bottomCellOffset);
        
        if (scrollView.contentOffset.y >= bottomCellOffset) {
            scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
            if (self.canScroll) {
                self.canScroll = NO;
                self.containerCell.objectCanScroll = YES;
            }
        }else{
            //子视图没到顶部
            if (!self.canScroll) {
                scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
            }
        }
    }
}

#pragma mark - YHDContainerCellDelegate

- (void)mmtdOptionalScrollViewDidScroll:(UIScrollView *)scrollView {
    self.tableView.scrollEnabled = NO;
}

- (void)mmtdOptionalScrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSUInteger page = scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width;
    [self.sectionView.segmentControl setSelectedSegmentIndex:page animated:YES];
    
    self.tableView.scrollEnabled = YES;
}

#pragma mark - UITableViewDelegate && UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    return 1;
}

// 由于Demo中几个cell个数有限且全部不一样，所以这儿不用重用机制
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            // 海报
            YHPosterTableViewCell *cell = [[YHPosterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"posterCell"];
            return cell;
        }
        // 简介
        YHDescTableViewCell *cell = [[YHDescTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"descCell"];
        return cell;
    }
    // 重点！横向滑动cell
    YHContainerTableViewCell *cell = [[YHContainerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"containerCell"];
    self.containerCell = cell;
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 300;
        }
        return 60;
    }
    return self.view.frame.size.height - 64 - 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01f;
    }
    return 60.0f;
}

#pragma mark - Init Views

- (YHTableView *)tableView {
    if (!_tableView) {
        _tableView = [[YHTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (YHSectionView *)sectionView {
    if (!_sectionView) {
        _sectionView = [[YHSectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
        __weak typeof(self) weakSelf = self;
        [_sectionView.segmentControl setIndexChangeBlock:^(NSInteger index) {
            weakSelf.containerCell.isSelectIndex = YES;
            [weakSelf.containerCell.scrollView setContentOffset:CGPointMake(index*[UIScreen mainScreen].bounds.size.width, 0) animated:YES];
        }];
    }
    return _sectionView;
}

@end
