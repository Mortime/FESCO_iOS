//
//  MM_MainViewController.m
//  MM_FESCO
//
//  Created by Mortimey on 16/7/27.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "MMMainController.h"
#import "MMMianCell.h"
#import "PersonalMessageController.h"
#import "NetworkEntity.h"
#import "LeaveApplicationDetailController.h"
#import "SignDetailController.h"
#import "MMCycleShowImageView.h"
#import "MMMainCollectionCell.h"
#import "NSString+MD5.h"

static NSString *kMallID = @"MallID";

@interface MMMainController () <UICollectionViewDataSource,UICollectionViewDelegate>


@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, strong) NSArray *imgArray;

@property (nonatomic, strong) UICollectionView *collectionView;




@end

@implementation MMMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
     self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.titleArray  = @[@"个人信息",@"签到签退",@"考勤记录",@"休假申请",@"休假记录",@"休假审批",@"加班申请",@"加班记录",@"加班审批",@"通讯录",@"迟到排行",@"加班排行",@"薪酬列表",@"HRS数据录入",@"HRS数据勘查"];
    self.imgArray = @[@"HomeFlag_Message",@"HomeFlag_Sign",@"HomeFlag_kaoqinjilu",@"HomeFlag_Xiujiashenqing",@"HomeFlag_Xiujiajilu",@"HomeFlag_Xiujiashenpi",@"HomeFlag_Jiabanshenqing",@"HomeFlag_Jiabanjilu",@"HomeFlag_Jiabanshenpi",@"HomeFlag_Tongxunlv",@"HomeFlag_Chidaopaihang",@"HomeFlag_Jiabanpaihang",@"HomeFlag_Xinchouliebiao",@"HomeFlag_Shujuluru",@"HomeFlag_Shujukancha"];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"d9f5f9"];
    self.title = @"首页";
    
    UIImage *img = [UIImage imageNamed:@"Home_SycleOne"];
    
    MMCycleShowImageView *cycleImageView = [[MMCycleShowImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 125)];
    cycleImageView.imagesUrlArray = @[@"Home_SycleOne",@"Home_CycleTwo.png",@"Home_CycleThree.png"];
    [cycleImageView setPageControlLocation:0 isCycle:YES];
    cycleImageView.placeImage = img;
    [self.view addSubview:cycleImageView];
    
    [self.view addSubview:self.collectionView];
    

    [self initData];
    
    
}
- (void)initData{
//    jsonParam={"menthodname":"getAppMenu","tokenkey":"42711...154" , "secret", "appsecret";}
    
    NSString *menth = [NSString stringWithFormat:@"%@%@",@"menthodname",@"getAppMenu"];
    NSString *secret = [NSString stringWithFormat:@"%@%@",@"secret",@"appsecret"];
    NSString *resultStr = [NSString stringWithFormat:@"%@%@",menth,secret];
    
    NSLog(@"resultstr = ======= %@",resultStr);
    NSString *md5Str = [[resultStr MD5Digest] uppercaseString];
    NSLog(@"md5Str =============== %@",md5Str);
    
    
    [NetworkEntity postHomeMainListWithParamMD5:md5Str menthodname:@"getAppMenu" tokenkeyID:[UserInfoModel defaultUserInfo].token secret:@"appsecret" success:^(id responseObject) {
        NSLog(@"HomeMain ----responseObject %@",responseObject);
    } failure:^(NSError *failure) {
        NSLog(@"HomeMain ----failure %@",failure);

    }];
    
    
    
    
    
    
    
}

#pragma mark - collectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titleArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // 加载积分商城
    
    MMMainCollectionCell *mallCell = [collectionView dequeueReusableCellWithReuseIdentifier:kMallID forIndexPath:indexPath];
//    mallCell.integralMallModel = self.dataArray[indexPath.row];
    mallCell.flagImageView.image = [UIImage imageNamed:_imgArray[indexPath.row]];
    mallCell.tittleLabel.text = _titleArray[indexPath.row];
    
    return mallCell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        // 个人信息
        PersonalMessageController *personalMegVC = [[PersonalMessageController alloc] init];
        [self.navigationController pushViewController:personalMegVC animated:YES];
        
    }
    if (indexPath.row == 1) {
        // 签到签退
        SignDetailController *signVC = [[SignDetailController alloc] init];
        [self.navigationController pushViewController:signVC animated:YES];
        
    }
    if (indexPath.row == 2) {
        // 考勤记录
        
    }
    if (indexPath.row == 3) {
        // 休假申请
        // 个人信息
        LeaveApplicationDetailController *LeaveVC = [[LeaveApplicationDetailController alloc] init];
        [self.navigationController pushViewController:LeaveVC animated:YES];
        
        
    }
    if (indexPath.row == 4) {
        // 休假记录
        
    }
    if (indexPath.row == 5) {
        // 休假审批
        
    }
    if (indexPath.row == 6) {
        // 加班申请
        
    }
    if (indexPath.row == 7) {
        // 加班记录
        
    }
    if (indexPath.row == 8) {
        // 加班审批
        
    }
    if (indexPath.row == 9) {
        // 通讯录
        
    }
    if (indexPath.row == 10) {
        //  迟到排行
        
    }
    
    if (indexPath.row == 11) {
        // 加班排行
        
    }
    if (indexPath.row == 12) {
        //  薪酬列表
        
    }
    if (indexPath.row == 13) {
        // HRS数据录入
        
    }if (indexPath.row == 14) {
        //  HRS数据勘查
        
    }
    
}

#pragma mark - collectionView flowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return CGSizeMake((self.view.width) / 3, 105);
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
// 行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
// 列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 125, self.view.width, self.view.height - 125 - 64) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor colorWithHexString:@"d9f5f9"];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
                // 注册Cell
        _collectionView.contentSize = CGSizeMake(self.view.width, self.view.height);
        [_collectionView registerClass:[MMMainCollectionCell class] forCellWithReuseIdentifier:kMallID];
        
        
    }
    return _collectionView;
}

@end
