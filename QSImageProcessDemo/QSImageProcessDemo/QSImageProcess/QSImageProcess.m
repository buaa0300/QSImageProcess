//
//  QSImageProcess.m
//  QSUseImageDemo
//
//  Created by shaoqing on 2017/8/10.
//  Copyright © 2017年 shaoqing. All rights reserved.
//

#import "QSImageProcess.h"
#import "QSDispatchQueue.h"
#import "QSImageProcessUtil.h"

static dispatch_queue_t qs_process_image_create_queue() {
    static dispatch_queue_t qs_process_image_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        qs_process_image_queue =
        dispatch_queue_create("com.jzp.com.process.image.queue", DISPATCH_QUEUE_CONCURRENT);
    });
    return qs_process_image_queue;
}

@interface QSImageProcess()

@property (nonatomic,strong)QSDispatchQueue *dispatchQueue;

@end


@implementation QSImageProcess

#pragma mark - Singleton, init, dealloc
+ (nonnull instancetype)sharedInstance {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

- (instancetype)init{

    self = [super init];
    if (self) {
        _dispatchQueue = [[QSDispatchQueue alloc]initWithQueue:qs_process_image_create_queue() concurrentCount:5];
    }
    return self;
}

- (void)dealloc{

}

#pragma mark - process Image
- (void)processImage:(UIImage *)image
              config:(QSImageProcessConfig *)config
           completed:(QSImageProcessCompletedBlock)completedBlock{
    
    NSAssert(image != nil, @"image can't be nil");
    NSAssert(config != nil, @"config can't be nil");
    
    //图片处理queue
    [_dispatchQueue async:^{
        
        UIImage *newImage = [self processImage:image config:config];
        NSLog(@"currentThread info is: %@",[NSThread currentThread]);
        dispatch_async(dispatch_get_main_queue(),^{
            if (completedBlock) {
                completedBlock(newImage);
            }
        });
    }];
}

- (UIImage *)processImage:(UIImage *)image
                   config:(QSImageProcessConfig *)config{
    
    NSAssert(image != nil, @"image can't be nil");
    NSAssert(config != nil, @"config can't be nil");
    
    if (CGSizeEqualToSize(config.outputSize, image.size)
        && [UIScreen mainScreen].scale == image.scale
        && config.cornerRadius == 0) {
        return image;
    }
    
    CGRect rect = {CGPointZero, config.outputSize};
    UIGraphicsBeginImageContextWithOptions(rect.size,config.opaque, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    
    switch (config.option) {
        case QSImageProcessOptionDefault:{
            QSImageProcessDefault(context, image, config);
        }
            break;
            
        case QSImageProcessOptionClipCorner:{
            QSImageProcessClipCorner(context, image, config);
        }
            break;
            
        case QSImageProcessOptionCircle:{
            QSImageProcessClipCorner(context, image, config);
        }
            break;
            
        case QSImageProcessOptionRound:{
            QSImageProcessRound(context, image, config);
        }
            break;
            
        case QSImageProcessOptionAddGradationMask:{
            QSImageProcessAddGradationMask(context, image, config);
        }
            break;
         
        case QSImageProcessOptionAddWholeMask:{
            QSImageProcessAddWholeMask(context, image, config);
        }
            
        default:
            break;
    }

    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
