//
//  PhoneListController.m
//  MM_FESCO
//
//  Created by Mortimey on 16/8/24.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "PhoneListController.h"
#import <sqlite3.h>
#import "PhoneListCell.h"
#import "DDChannelLabel.h"
#import "PhoneListModel.h"
#import "EasySerachViewController.h"
#import "MMCyeleShowLableTagView.h"
#import "NSArray+Sort.h"


static NSString * const reuseID  = @"PhoneListCell";

@interface PhoneListController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>

// 企业部门
@property (nonatomic, strong) NSArray *gropArray;

// 部门列表展示
@property (nonatomic, strong) MMCyeleShowLableTagView *tagView;

// 通讯录视图
@property (nonatomic, strong) UICollectionView *collectionView;

// 全部员工的信息
@property (nonatomic, strong) NSMutableArray *allPersonMessageArray;

@property (nonatomic, strong) UIButton *searchButton;

@property (nonatomic, strong) UIView *seachBGView;

@property (nonatomic, strong) NSArray *paramArray;

@property (nonatomic, assign) NSInteger versonNO;
@end

@implementation PhoneListController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 用户头像加
//    [self initIconUrl];
    [self initData];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    UILabel *label = [[UILabel alloc] init];
    label.tag = 0;
    [self barViewItemSelect:label];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor clearColor];
    self.title = @"通讯录";
    _versonNO = 0;
    // 添加右上角的搜查按钮
    _searchButton = [UIButton new];
    [_searchButton setImage:[UIImage imageNamed:@"phoneList_Search"] forState:UIControlStateNormal];
    _searchButton.bounds = CGRectMake(0, 0, 24, 44);
    [_searchButton addTarget:self action:@selector(didSearch:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bbiPhone = [[UIBarButtonItem alloc] initWithCustomView:_searchButton];
    self.navigationItem.rightBarButtonItem = bbiPhone;
    
    [self initUI];
    // 加载数据(如果数据库中有就从数据库中取,如果没有就网络请求数据)
    
   
    
}
- (void)initUI{

    [self.view addSubview:self.tagView];
    [self.view addSubview:self.collectionView];
    // 点击tag方法回调
    [self.tagView MMToolBarViewItemSelected:^(UILabel *label) {
        [self barViewItemSelect:label];
    }];
}
- (void)initIconUrl{
 NSInteger versonNO =  [[[NSUserDefaults standardUserDefaults] objectForKey:KAvtarUrlVersion] integerValue];
    if (versonNO) {
        _versonNO = versonNO;
    }
    
    // 如果版本号为0 说明第一次加载这时要把数据全部存入数据库; 如果版本号不为0 说明为更新的值, 这时根据返回的empID,去数据库中查,如果有删除,存入新的,
    [NetworkEntity postPhoneNumberListIconUrlWithCustId:[UserInfoModel defaultUserInfo].custId VNo:_versonNO success:^(id responseObject) {
        MMLog(@"PhoneNumberListIconUrl =====responseObject ==========%@",responseObject);
        if (responseObject ) {
            [self initData];
            NSDictionary *dic = [responseObject objectForKey:@"empPhotos"];
            NSArray *keyAll = [dic allKeys];
            for (NSString *key in keyAll) {
                
                NSData *data = [[NSData alloc]initWithBase64EncodedString:[dic objectForKey:key] options:0];
                MMLog(@"key ===%@===== date====%@",key,data);
                if (_versonNO == 0) {
                    [MMDataBase initializeDatabaseWithTableName:t_userIconUrl baseBlock:^(BOOL isSuccess) {
                        if (isSuccess) {
                            [MMDataBase addAvtarData:[key integerValue] avtar:data baseBlock:^(BOOL isSuccess) {
                                if (isSuccess) {
                                    MMLog(@"插入数据成功");
                                }else{
                                    MMLog(@"插入数据失败");
                                }
                            }];
                            
                        }
                    }];

                }else{
                    [MMDataBase updateAvtarData:[key integerValue] avtar:data baseBlock:^(BOOL isSuccess) {
                        if (isSuccess) {
                            MMLog(@"更新数据成功");
                            [_collectionView reloadData];
                        }else{
                            MMLog(@"更新数据失败");
                        }

                    }];
                }
            }
            // 得到全部数据
//            [MMDataBase getAvtarData];
            // 保存版本号  ---- 待实现
            NSInteger V = [[responseObject objectForKey:@"version_No"] integerValue];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%lu",V] forKey:KAvtarUrlVersion];
        }
    } failure:^(NSError *failure) {
        MMLog(@"PhoneNumberListIconUrl =====failure ==========%@",failure);
    }];
    

}
- (void)initData{
    
    
    __weak typeof(self) ws = self;
    
   // 根据版本号和日期进行数据库的更新
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    MMLog(@"[defaults objectForKey:kNewPhoneVersion] = %@",[defaults objectForKey:kNewPhoneDate]);
    if (![defaults objectForKey:kNewPhoneVersion]) {
        // 版本号为空,第一次保存数据
        [NetworkEntity postPhoneNumberListWithCustId:[UserInfoModel defaultUserInfo].custId version:0 updateTime:@"" success:^(id responseObject) {
            if (responseObject) {
                MMLog(@"PhoneListController =====responseObject =============%@",responseObject);
                [MMDataBase initializeDatabaseWithTableName:@"t_newPhoneList" baseBlock:^(BOOL isSuccess) {
                    if (isSuccess) {
                        // 表创建成功
                        MMLog(@"表创建成功");
                        NSArray *array = [responseObject objectForKey:@"emps"];
                        for (NSDictionary *dic in array) {
                            [MMDataBase addNewPhoneListEmpID:[[dic objectForKey:@"emp_Id"] integerValue] name:[dic objectForKey:@"emp_Name"] mobile:[dic objectForKey:@"mobile"] phone:[dic objectForKey:@"phone"] groupName:[dic objectForKey:@"group_Name"] baseBlock:^(BOOL isSuccess) {
                                if (isSuccess) {
                                    // 保存成功
                                }
                            }];
                        }
                        
                        
                    }
                    
                }];
                // 保存版本号  更新时间
                [defaults setObject:[responseObject objectForKey:@"newCustVersion"] forKey:kNewPhoneVersion];
                [defaults setObject:[responseObject objectForKey:@"updateTime"] forKey:kNewPhoneDate];
                [ws initDataUI];


            }
        } failure:^(NSError *failure) {
            
        }];
    }else{
        // 更新数据库
        [NetworkEntity postPhoneNumberListWithCustId:[UserInfoModel defaultUserInfo].custId version:[[defaults objectForKey:kNewPhoneVersion] integerValue] updateTime:[defaults objectForKey:kNewPhoneDate] success:^(id responseObject) {
            if (responseObject) {
                MMLog(@"PhoneListController === 更新 ==responseObject =============%@",responseObject);
                
                // 删除
                for ( NSString *str in [responseObject objectForKey:@"deleteIds"]) {
                    [MMDataBase deletePhoneWithEmpID:[str integerValue] baseBlock:^(BOOL isSuccess) {
                        
                    }];
                }
                // 插入
                
                for (NSDictionary *dic in [responseObject objectForKey:@"emps"]) {
                    [MMDataBase addNewPhoneListEmpID:[[dic objectForKey:@"emp_Id"] integerValue] name:[dic objectForKey:@"emp_Name"] mobile:[dic objectForKey:@"mobile"] phone:[dic objectForKey:@"phone"] groupName:[dic objectForKey:@"group_Name"] baseBlock:^(BOOL isSuccess) {
                        if (isSuccess) {
                            // 保存成功
                        }
                    }];

                }
                // 保存版本号  更新时间
                [defaults setObject:[responseObject objectForKey:@"newCustVersion"] forKey:kNewPhoneVersion];
                [defaults setObject:[responseObject objectForKey:@"updateTime"] forKey:kNewPhoneDate];
                [ws initDataUI];

            }
        } failure:^(NSError *failure) {
            
        }];

    }
    
}
- (void)initDataUI{
    // 取出全部数据
    self.paramArray = [MMDataBase allNewPhoneList];
//    MMLog(@"数据库返回数据: %@",dataBaseDic);
    
    NSArray *resultPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                               NSUserDomainMask,
                                                               YES);
    NSString *restltDocumentDirectory = [resultPaths lastObject];
    MMLog(@"path ===== path ======= %@",restltDocumentDirectory);
    
    // 对数组进行排序
    NSArray *resultArray = [NSArray sortGroupWithDataSouce:_paramArray keyStr:@"group_Name"];
    // 获取全部的分组名称
    NSMutableArray *gropNameArray = [NSMutableArray array];
    for (NSArray *array  in resultArray) {
        NSDictionary *dic = array[0];
        NSString *gropName = [dic objectForKey:@"group_Name"];
        [gropNameArray addObject:gropName];
    }
    self.allPersonMessageArray = resultArray.mutableCopy;
    
    self.gropArray = gropNameArray;
    
    
    [_tagView initTag:_gropArray];
    [self.collectionView reloadData];
    
    
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _gropArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhoneListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
    NSString *title = _gropArray[indexPath.row];
    
    cell.personListArray = self.allPersonMessageArray[indexPath.row];
    MMLog(@"self.allPersonMessageArray[indexPath.row] = %@",self.allPersonMessageArray[indexPath.row]);
    cell.pareVC = self;
    cell.urlString = title;
//    cell.pareVC = self;
    
    
    // 如果不加入响应者链，则无法利用NavController进行Push/Pop等操作。
//    [self addChildViewController:(UIViewController *)cell.phoneListVC];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
/** 手指滑动BigCollectionView，滑动结束后调用 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.collectionView]) {
        [self.tagView MMscrollViewDidEndScrollingAnimation:scrollView];
    }
}

#pragma mark ---- Action
// 头部tag点击回调
- (void)barViewItemSelect:(UILabel *)selectLabel{
    
    [_collectionView setContentOffset:CGPointMake(selectLabel.tag * _collectionView.frame.size.width, 0)];
    // 重新调用一下滚定停止方法，让label的着色和下划线到正确的位置。
    [self.tagView MMscrollViewDidEndScrollingAnimation:_collectionView];

}

- (void)didSearch:(UIButton *)btn{
    
    EasySerachViewController *easy = [EasySerachViewController new];
    easy.dataArray = self.paramArray;
    easy.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:easy animated:YES];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark --- Lazy 加载

- (MMCyeleShowLableTagView *)tagView
{
    if (_tagView == nil) {
        _tagView = [[MMCyeleShowLableTagView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 60)];
        _tagView.backgroundColor = MM_MAIN_BACKGROUND_COLOR;
        
    }
    return _tagView;
}

- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        CGFloat h = kMMHeight - 64 - self.tagView.height - 46;
        CGRect frame = CGRectMake(0, CGRectGetMaxY(self.tagView.frame), kMMWidth, h);
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[PhoneListCell class] forCellWithReuseIdentifier:reuseID];
        
        // 设置cell的大小和细节
        flowLayout.itemSize = _collectionView.bounds.size;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
    }
    return _collectionView;
}

@end
