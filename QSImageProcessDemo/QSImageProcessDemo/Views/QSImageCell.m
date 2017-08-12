//
//  QSImageCell.m
//  QSImageProcessDemo
//
//  Created by shaoqing on 2017/8/12.
//  Copyright © 2017年 Jiang. All rights reserved.
//

#import "QSImageCell.h"
#import "QSImageProcess.h"

@interface QSImageCell()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation QSImageCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
 
        self.imageView = [[UIImageView alloc] init];
        self.imageView.frame = self.bounds;
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

- (void)layoutWithData:(id)data{

    [[QSImageProcess sharedInstance]processImage:[UIImage imageNamed:@"icon_lena.png"] config:(QSImageProcessConfig *)data completed:^(UIImage *outputImage) {
       
        self.imageView.image = outputImage;
    }];
}

@end
