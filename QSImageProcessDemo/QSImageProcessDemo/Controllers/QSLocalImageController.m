//
//  QSLocalImageController.m
//  QSImageProcessDemo
//
//  Created by shaoqing on 2017/8/12.
//  Copyright © 2017年 Jiang. All rights reserved.
//

#import "QSLocalImageController.h"
#import "QSImageProcessConfig.h"
#import "QSImageCell.h"

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface QSLocalImageController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) CGSize cellSize;

@end

@implementation QSLocalImageController

- (instancetype)init{

    self = [super init];
    if (self) {
        NSInteger imageCount = 3;
        CGFloat margin = 30;
        CGFloat width = ceilf((SCREEN_WIDTH - margin * (imageCount + 1))/imageCount);
         _cellSize = CGSizeMake(width, width);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"本地图片处理";
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
    
    [self setupDataSource];
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[QSImageCell class] forCellWithReuseIdentifier:@"QSImageCell"];
}

- (void)setupDataSource{
    
    CGFloat cornerRadius = 30.0f;
   
    QSImageProcessConfig *config1 = [QSImageProcessConfig configWithOutputSize:_cellSize cornerRadius:cornerRadius corners:UIRectCornerTopLeft];
    QSImageProcessConfig *config2 = [QSImageProcessConfig configWithOutputSize:_cellSize cornerRadius:cornerRadius corners:UIRectCornerBottomLeft];
    QSImageProcessConfig *config3 = [QSImageProcessConfig configWithOutputSize:_cellSize cornerRadius:cornerRadius corners:UIRectCornerTopRight];
    QSImageProcessConfig *config4 = [QSImageProcessConfig configWithOutputSize:_cellSize cornerRadius:cornerRadius corners:UIRectCornerBottomRight];
    QSImageProcessConfig *config5 = [QSImageProcessConfig configWithOutputSize:_cellSize cornerRadius:cornerRadius corners:UIRectCornerTopLeft | UIRectCornerBottomLeft];
    QSImageProcessConfig *config6 = [QSImageProcessConfig configWithOutputSize:_cellSize cornerRadius:cornerRadius corners:UIRectCornerTopRight | UIRectCornerBottomRight];
    QSImageProcessConfig *config7 = [QSImageProcessConfig configWithOutputSize:_cellSize cornerRadius:cornerRadius corners:UIRectCornerAllCorners];
    QSImageProcessConfig *config8 = [QSImageProcessConfig circleConfigWithOutputSize:_cellSize clipBgColor:[UIColor whiteColor]];  //不透明圆形图片
    QSImageProcessConfig *config9 = [QSImageProcessConfig circleConfigWithOutputSize:_cellSize];  //透明圆形图片
    
    QSImageProcessConfig *config10 = [QSImageProcessConfig defaultConfigWithOutputSize:_cellSize clipBgColor:[UIColor whiteColor]];
    config10.option = QSImageProcessOptionRound;
    
    QSImageProcessConfig *config11 = [QSImageProcessConfig defaultConfigWithOutputSize:_cellSize clipBgColor:[UIColor whiteColor]];
    config11.option = QSImageProcessOptionAddGradationMask;
    
    QSImageProcessConfig *config12 = [QSImageProcessConfig defaultConfigWithOutputSize:_cellSize clipBgColor:[UIColor whiteColor]];
    config12.option = QSImageProcessOptionAddWholeMask;
    
    
    NSArray *configs = [NSArray arrayWithObjects:config1,config2,config3,config4,config5,config6,config7,config8,config9,config10,config11,config12, nil];
 
    [self.dataSource addObjectsFromArray:configs];
}


#pragma mark - getter
- (UICollectionView *)collectionView{

    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = _cellSize;
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 30;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 64, 0);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(30, 0, SCREEN_WIDTH - 60, SCREEN_HEIGHT - 64)
                                                 collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
    }
    return _collectionView;
    
}

- (NSMutableArray *)dataSource{

    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}



#pragma mark - UICollectionViewDataSource & UICollectionViewDelegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    QSImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"QSImageCell"
                                                                  forIndexPath:indexPath];
    QSImageProcessConfig *config = self.dataSource[indexPath.item];
    [cell layoutWithData:config];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
