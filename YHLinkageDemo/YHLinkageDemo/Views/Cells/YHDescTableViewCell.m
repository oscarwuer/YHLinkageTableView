//
//  YHDescTableViewCell.m
//  YHLinkageDemo
//
//  Created by 张长弓 on 2018/1/8.
//  Copyright © 2018年 张长弓. All rights reserved.
//

#import "YHDescTableViewCell.h"

@interface YHDescTableViewCell ()

@property (nonatomic, strong) UILabel *descLabel;

@end

@implementation YHDescTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor cyanColor];
        [self.contentView addSubview:self.descLabel];
    }
    return self;
}

#pragma mark - Init Views

- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, [UIScreen mainScreen].bounds.size.width, 60)];
        _descLabel.text = @"简单写上一行(这是一个cell)";
    }
    return _descLabel;
}

@end
