//
//  YHPosterTableViewCell.m
//  YHLinkageDemo
//
//  Created by 张长弓 on 2018/1/8.
//  Copyright © 2018年 张长弓. All rights reserved.
//

#import "YHPosterTableViewCell.h"

@interface YHPosterTableViewCell ()

@property (nonatomic, strong) UIImageView *posterImgView;

@end

@implementation YHPosterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.posterImgView];
    }
    return self;
}

#pragma mark - Init Views

- (UIImageView *)posterImgView {
    if (!_posterImgView) {
        _posterImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300)];
        _posterImgView.image = [UIImage imageNamed:@"luoli"];
    }
    return _posterImgView;
}

@end
