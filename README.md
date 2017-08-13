# QSImageProcess
A high-performance and convenient tool for processing local image or web image 


<h2>Installation</h2>

	pod 'QSImageProcess'
	
	or put all files in QSImageProcess directory into your project directly.
	
	Then 
	
	#import "QSImageProcess.h"
	#import "UIImageView+QSImageProcess.h"
	
<h2>Usage-Demo1</h2>
	

    //load web image，default config,you don't need setup
    [self.imageView qs_setImageWithURL:url
                    placeholderImage:placeholderImage];

    //load web image，you should make a custom config
    QSImageProcessConfig *config = [QSImageProcessConfig configWithOutputSize:self.imageView.frame.size cornerRadius:cornerRadius corners:UIRectCornerAllCorners];
    [self.imageView qs_setImageWithURL:url
                      placeholderImage:placeholderImage
                                config:configs];

  

<h2>Usage-Demo2</h2>

    //a config of circle output image  
    QSImageProcessConfig *config = [QSImageProcessConfig configWithOutputSize:self.imageView.frame.size cornerRadius:cornerRadius corners:UIRectCornerAllCorners];
    
    //load local image asynchronously
    [[QSImageProcess sharedInstance]processImage:image config:config completed:^(UIImage *outputImage) {
        self.imageView1.image = outputImage;
    }];

    //load local image synchronously
    self.imageView2.image = [[QSImageProcess sharedInstance]processImage:image config:config];