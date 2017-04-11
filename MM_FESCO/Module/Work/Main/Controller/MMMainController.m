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
#import "MMCycleShowImageView.h"
#import "MMMainCollectionCell.h"
#import "NSString+MD5.h"
#import "PhoneListController.h"
#import "CheckWorkController.h"
#import "MMLoginController.h"
#import "JZUserLoginManager.h"
#import "ApprovalController.h"
#import "LeaveApplyRecordController.h"
#import "OverTimeApplyController.h"
#import "CollectionFooterView.h"
#import "MMPageControl.h"
#import "CheckStatisticController.h"
#import "LaterTimeStatisticController.h"
#import "OverTimeStatistiscController.h"
#import "ReimburseController.h"
#import "BuffetController.h"


static NSString *kMallID = @"MallID";

@interface MMMainController () <UICollectionViewDataSource,UICollectionViewDelegate>

{
    UIImageView*navBarHairlineImageView;
}


@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, strong) NSArray *imgArray;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) CollectionFooterView *footerView;

@property (nonatomic, strong) UIButton *loginOutButton;

@property (nonatomic, strong)  MMCycleShowImageView *cycleImageView;



@end

@implementation MMMainController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 隐藏导航条底部分割线
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    navBarHairlineImageView.hidden=YES;
}


- (UIImageView*)findHairlineImageViewUnder:(UIView*)view {
    
    if([view isKindOfClass:UIImageView.class] && view.bounds.size.height<=1.0) {
        return(UIImageView*)view;
    }
    for(UIView*subview in view.subviews) {
        UIImageView*imageView = [self findHairlineImageViewUnder:subview];
        if(imageView) {
            return imageView;
        }
    }
    return nil;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = MM_MAIN_FONTCOLOR_BLUE;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    
    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, self.view.bounds.size.width, 20)];
    //设置成绿色
    statusBarView.backgroundColor=[UIColor colorWithHexString:@"00b6d8"];
    // 添加到 navigationBar 上
    [self.navigationController.navigationBar addSubview:statusBarView];
    
//    self.titleArray  = @[@"个人信息",@"考勤",@"休假",@"审批",@"加班",@"通讯录",@"签到统计",@"迟到排行",@"加班排行",@"报销",@"薪酬列表",@"HRS数据录入",@"HRS数据勘查"];
    
    self.titleArray  = @[@"个人信息",@"考勤",@"休假",@"加班",@"签到统计",@"迟到排行",@"加班排行"];

//    self.imgArray = @[@"HomeFlag_Message",@"HomeFlag_Sign",@"HomeFlag_Xiujiajilu",@"HomeFlag_Xiujiashenpi",@"HomeFlag_Jiabanshenqing",@"HomeFlag_Tongxunlv",@"HomeFlag_qiandaotongji",@"HomeFlag_Chidaopaihang",@"HomeFlag_Jiabanpaihang",@"HomeFlag_BaoXiao",@"HomeFlag_Xinchouliebiao",@"HomeFlag_Shujuluru",@"HomeFlag_Shujukancha"];
    
    self.imgArray = @[@"HomeFlag_Message",@"HomeFlag_Sign",@"HomeFlag_Xiujiajilu",@"HomeFlag_Jiabanshenqing",@"HomeFlag_qiandaotongji",@"HomeFlag_Chidaopaihang",@"HomeFlag_Jiabanpaihang"];

    
    UIImage *img = [UIImage imageNamed:@"Home_SycleOne"];
    
   _cycleImageView = [[MMCycleShowImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 101)];
    _cycleImageView.placeImage = img;
    _cycleImageView.backgroundColor = MM_MAIN_FONTCOLOR_BLUE;
    _cycleImageView.imagesUrlArray = @[@"Home_SycleOne",@"Home_CycleTwo.png",@"Home_CycleThree.png"];
    [_cycleImageView setPageControlLocation:0 isCycle:YES];
    

    [self.view addSubview:_cycleImageView];
    
    
    // 添加右上角的搜查按钮
    _loginOutButton = [UIButton new];
    [_loginOutButton setTitle:@"退出" forState:UIControlStateNormal];
    _loginOutButton.titleLabel.font = [UIFont systemFontOfSize:15];
    _loginOutButton.bounds = CGRectMake(0, 0, 32, 44);
    [_loginOutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginOutButton addTarget:self action:@selector(didSearch:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bbiPhone = [[UIBarButtonItem alloc] initWithCustomView:_loginOutButton];
    self.navigationItem.rightBarButtonItem = bbiPhone;

    [self.view addSubview:self.collectionView];
    

    [self initData];
    
    
}
- (void)initData{
//    jsonParam={"menthodname":"getAppMenu","tokenkey":"42711...154" , "secret", "appsecret";}
    
    NSString *menth = [NSString stringWithFormat:@"%@%@",@"methodname",@"getMenu"];
    NSString *secret = [NSString stringWithFormat:@"%@%@",@"secret",@"appsecret"];
    NSString *resultStr = [NSString stringWithFormat:@"%@%@",menth,secret];
    
    MMLog(@"resultstr = ======= %@",resultStr);
    NSString *md5Str = [[resultStr MD5Digest] uppercaseString];
    MMLog(@"md5Str =============== %@",md5Str);
    
    
    
    [NetworkEntity postHomeMainListWithParamMD5:md5Str menthodname:@"getMenu" tokenkeyID:[UserInfoModel defaultUserInfo].token secret:@"appsecret" success:^(id responseObject) {
        
        MMLog(@"HomeMain ----responseObject %@",responseObject);
        
    } failure:^(NSError *failure) {
        
        MMLog(@"HomeMain ----failure %@",failure);

    }];
    

    
}
#pragma mark --- Action 
- (void)didSearch:(UIButton *)btn{
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:kUsreIcon];
    [defaults synchronize];
    [[UserInfoModel defaultUserInfo] loginOut];
    // 环信退出
    EMError *error = [[EMClient sharedClient] logout:YES];
    if (!error) {
        MMLog(@"环信退出成功");
    }
    MMLoginController *logninVC = (MMLoginController *)[JZUserLoginManager loginController];
    ((AppDelegate *)[UIApplication sharedApplication].delegate).window.rootViewController = logninVC;

    
    
}
#pragma mark - collectionView


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titleArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    
    MMMainCollectionCell *mallCell = [collectionView dequeueReusableCellWithReuseIdentifier:kMallID forIndexPath:indexPath];
//    mallCell.integralMallModel = self.dataArray[indexPath.row];
    mallCell.flagImageView.image = [UIImage imageNamed:_imgArray[indexPath.row]];
    mallCell.tittleLabel.text = _titleArray[indexPath.row];
    
    return mallCell;
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionFooter) {    //尾视图
        _footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footer" forIndexPath:indexPath];
//        _footerView.delegate = self;
        reusableView = _footerView;
    }
    return reusableView;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    return CGSizeMake(self.view.width,40);
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        // 个人信息
        PersonalMessageController *personalMegVC = [[PersonalMessageController alloc] init];
         personalMegVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:personalMegVC animated:YES];
        
    }
    if (indexPath.row == 1) {
        // 考勤
        CheckWorkController *checkWorkVC = [[CheckWorkController alloc] init];
        checkWorkVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:checkWorkVC animated:YES];
        
        
    }
    if (indexPath.row == 2) {
        // 休假记录 休假申请
        LeaveApplyRecordController *leaveApplyVC = [[LeaveApplyRecordController alloc] init];
        leaveApplyVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:leaveApplyVC animated:YES];
        
        
    }
    if (indexPath.row == 3) {
        // 加班申请, 加班记录  OverTimeApplyController
        
        OverTimeApplyController *overTimeApplyVC = [[OverTimeApplyController alloc] init];
        overTimeApplyVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:overTimeApplyVC animated:YES];
        
    }
    if (indexPath.row == 4) {
        //  签到排行
        
        CheckStatisticController *checkStatVC = [[CheckStatisticController alloc] init];
        checkStatVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:checkStatVC animated:YES];

        
    }
    if (indexPath.row == 5) {
        //  迟到排行
        
        LaterTimeStatisticController *laterTimeStatVC = [[LaterTimeStatisticController alloc] init];
        laterTimeStatVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:laterTimeStatVC animated:YES];

        
    }
    if (indexPath.row == 6) {
        
        // 加班排行
        OverTimeStatistiscController *overTimeStatVC = [[OverTimeStatistiscController alloc] init];
        overTimeStatVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:overTimeStatVC animated:YES];
        
    }
    
    if (indexPath.row == 7) {
       // 社保
        BuffetController *buffVC = [[BuffetController alloc] init];
        buffVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:buffVC animated:YES];
        
        
    }
    if (indexPath.row == 8) {
        

        
    }
    if (indexPath.row == 9) {
        

        
    }
    if (indexPath.row == 10) {
        
    }
    if (indexPath.row == 11) {
        
        
        
    }
    if (indexPath.row == 12) {
        
    }
    
}

#pragma mark - collectionView flowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return CGSizeMake((self.view.width - 20) / 2, 105);
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 10, 0, 10);
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
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.cycleImageView.height, self.view.width, self.view.height - self.cycleImageView.height - 64 - 39) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.alwaysBounceVertical = YES;
                // 注册Cell
        _collectionView.contentSize = CGSizeMake(self.view.width, self.view.height);
        [_collectionView registerClass:[MMMainCollectionCell class] forCellWithReuseIdentifier:kMallID];
        
        [_collectionView registerClass:[CollectionFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footer"];              //注册尾视图
        
        
    }
    return _collectionView;
}

@end
