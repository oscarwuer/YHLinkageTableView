//
//  YHContainerTableViewCell.h
//  YHLinkageDemo
//
//  Created by 张长弓 on 2018/1/8.
//  Copyright © 2018年 张长弓. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YHDContainerCellDelegate <NSObject>

@optional
- (void)mmtdOptionalScrollViewDidScroll:(UIScrollView *)scrollView;

- (void)mmtdOptionalScrollViewDidEndDecelerating:(UIScrollView *)scrollView;

@end


@interface YHContainerTableViewCell : UITableViewCell

@property (nonatomic, weak) id <YHDContainerCellDelegate> delegate;

@property (nonatomic, strong, readonly) UIScrollView *scrollView;

@property (nonatomic, assign) BOOL objectCanScroll;
@property (nonatomic, assign) BOOL isSelectIndex;

@end
