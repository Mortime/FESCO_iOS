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

static NSString *kMallID = @"MallID";

@interface MMMainController () <UICollectionViewDataSource,UICollectionViewDelegate>


@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, strong) NSArray *imgArray;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIButton *loginOutButton;




@end

@implementation MMMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = MM_MAIN_BACKGROUND_COLOR;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.titleArray  = @[@"个人信息",@"考勤",@"休假",@"审批",@"加班",@"通讯录",@"迟到排行",@"加班排行",@"薪酬列表",@"HRS数据录入",@"HRS数据勘查"];
    self.imgArray = @[@"HomeFlag_Message",@"HomeFlag_Sign",@"HomeFlag_Xiujiajilu",@"HomeFlag_Xiujiashenpi",@"HomeFlag_Jiabanshenqing",@"HomeFlag_Tongxunlv",@"HomeFlag_Chidaopaihang",@"HomeFlag_Jiabanpaihang",@"HomeFlag_Xinchouliebiao",@"HomeFlag_Shujuluru",@"HomeFlag_Shujukancha"];
    
    UIImage *img = [UIImage imageNamed:@"Home_SycleOne"];
    
    MMCycleShowImageView *cycleImageView = [[MMCycleShowImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 125)];
    cycleImageView.imagesUrlArray = @[@"Home_SycleOne",@"Home_CycleTwo.png",@"Home_CycleThree.png"];
    [cycleImageView setPageControlLocation:0 isCycle:YES];
    cycleImageView.placeImage = img;
    [self.view addSubview:cycleImageView];
    
    
    // 添加右上角的搜查按钮
    _loginOutButton = [UIButton new];
    [_loginOutButton setTitle:@"退出" forState:UIControlStateNormal];
    _loginOutButton.titleLabel.font = [UIFont systemFontOfSize:16];
    _loginOutButton.bounds = CGRectMake(0, 0, 32, 44);
    [_loginOutButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
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
    
    [[UserInfoModel defaultUserInfo] loginOut];
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
        // 休假审批
        ApprovalController *approvalVC = [[ApprovalController alloc] init];
        approvalVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:approvalVC animated:YES];
        
    }
    if (indexPath.row == 4) {
        // 加班申请, 加班记录  OverTimeApplyController
        
        OverTimeApplyController *overTimeApplyVC = [[OverTimeApplyController alloc] init];
        overTimeApplyVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:overTimeApplyVC animated:YES];
        
    }
    if (indexPath.row == 5) {
        // 通讯录
        PhoneListController *phoneListVC = [[PhoneListController alloc] init];
        phoneListVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:phoneListVC animated:YES];
        
        
    }
    if (indexPath.row == 6) {
        //  迟到排行
        
    }
    
    if (indexPath.row == 7) {
        // 加班排行
        
    }
    if (indexPath.row == 8) {
        //  薪酬列表
        
    }
    if (indexPath.row == 9) {
        // HRS数据录入
        
    }if (indexPath.row == 10) {
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
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 125, self.view.width, self.view.height - 125 - 64 - 39) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
                // 注册Cell
        _collectionView.contentSize = CGSizeMake(self.view.width, self.view.height);
        [_collectionView registerClass:[MMMainCollectionCell class] forCellWithReuseIdentifier:kMallID];
        
        
    }
    return _collectionView;
}

@end
