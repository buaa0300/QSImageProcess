//
//  QSWebImageCell.m
//  QSImageProcessDemo
//
//  Created by shaoqing on 2017/8/12.
//  Copyright © 2017年 Jiang. All rights reserved.
//

#import "QSWebImageCell.h"
#import "UIImageView+QSImageProcess.h"

@interface QSWebImageCell()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation QSWebImageCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.imageView = [[UIImageView alloc] init];
        self.imageView.frame = self.bounds;
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

- (void)layoutWithData:(id)data{
    
    [self.imageView qs_setImageWithURL:[NSURL URLWithString:@"http://img6.faloo.com/Picture/0x0/0/183/183388.jpg"] placeholderImage:[UIImage imageNamed:@"icon.jpeg"] config:(QSImageProcessConfig *)data];
}

@end
