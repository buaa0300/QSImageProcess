# QSImageProcess
A tool for process local image or web image 


<h2>Installation</h2>

	pod 'QSImageProcess'
	
	OR put all files in QSImageProcess directory into your project directly.
	
	Then 
	
	#import "QSImageProcess.h"
	#import "UIImageView+QSImageProcess.h"

<h2>Usage-Demo1</h2>

	//load web image url,but show circle image in imageview 
	
  	QSImageProcessConfig *config = [QSImageProcessConfig configWithOutputSize:self.imageView.frame.size 
  	cornerRadius:cornerRadius corners:UIRectCornerAllCorners];
	[self.imageView qs_setImageWithURL:url placeholderImage:placeholderImage config:config];

<h2>Usage-Demo2</h2>


	//load local image url,but show circle image in imageview
	
	QSImageProcessConfig *config = [QSImageProcessConfig configWithOutputSize:self.imageView.frame.size 
  	cornerRadius:cornerRadius corners:UIRectCornerAllCorners];
  	[[QSImageProcess sharedInstance]processImage:[UIImage imageNamed:@"icon_lena.png"] config:(QSImageProcessConfig *)data completed:^(UIImage *outputImage) {
       
        self.imageView.image = outputImage;
    }];