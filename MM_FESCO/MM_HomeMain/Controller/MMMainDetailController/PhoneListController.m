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


#define ScrW [UIScreen mainScreen].bounds.size.width
#define ScrH [UIScreen mainScreen].bounds.size.height
#define AppColor [UIColor colorWithRed:0.00392 green:0.576 blue:0.871 alpha:1]

static NSString * const reuseID  = @"PhoneListCell";
static sqlite3 *database;

@interface PhoneListController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>

// 企业部门
@property (nonatomic, strong) NSArray *gropArray;

// 部门列表展示
@property (nonatomic, strong) MMCyeleShowLableTagView *tagView;

// 通讯录视图
@property (nonatomic, strong) UICollectionView *collectionView;

// 给随的线
@property (nonatomic, strong) UIView *underline;


// 全部员工的信息
@property (nonatomic, strong) NSArray *allPersonMessageArray;


@property (nonatomic, strong) UIButton *searchButton;

@property (nonatomic, strong) UIView *seachBGView;

@property (nonatomic, strong) NSArray *paramArray;
@end

@implementation PhoneListController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor clearColor];
    self.title = @"通讯录";
    // 添加右上角的搜查按钮
    _searchButton = [UIButton new];
    [_searchButton setImage:[UIImage imageNamed:@"phoneList_Search"] forState:UIControlStateNormal];
    _searchButton.bounds = CGRectMake(0, 0, 24, 44);
    [_searchButton addTarget:self action:@selector(didSearch:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bbiPhone = [[UIBarButtonItem alloc] initWithCustomView:_searchButton];
    self.navigationItem.rightBarButtonItem = bbiPhone;

    
    
//    self.allPersonMessageArray = [NSMutableArray array];
//    self.gropArray = @[@"管理咨询",@"会计事业",@"薪酬事业",@"行政部",@"财务部",@"人力资源",@"管理层",@"营销管理",@"业务外包"];
    
    [self initUI];
    // 加载数据(如果数据库中有就从数据库中取,如果没有就网络请求数据)
    [self initData];
    
    
}
- (void)initUI{

    [self.view addSubview:self.tagView];
    [self.view addSubview:self.collectionView];
    
    // 点击tag方法回调
    [self.tagView MMToolBarViewItemSelected:^(UILabel *label) {
        [self barViewItemSelect:label];
    }];
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
    cell.urlString = title;
    
    
    // 如果不加入响应者链，则无法利用NavController进行Push/Pop等操作。
//    [self addChildViewController:(UIViewController *)cell.phoneListVC];
    return cell;
}

/** 手指滑动BigCollectionView，滑动结束后调用 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.collectionView]) {
        [self.tagView MMscrollViewDidEndScrollingAnimation:scrollView];
    }
}



- (void)initData{
    
    __weak typeof(self) ws = self;
    
    [MMDataBase isExistWithId:@"exist" isExist:^(BOOL isExist) {
        if (isExist) {
            // 数据已经存在
            [ws initDataUI];
            
        }else{
            // 数据不存在,进行网络请求
            
        [NetworkEntity postPhoneNumberListWithCustId:[UserInfoModel defaultUserInfo].custId success:^(id responseObject) {
                    MMLog(@"PhoneListController =====responseObject =============%@",responseObject);
            
                   [MMDataBase  initializeDatabaseWith:^(BOOL isSuccess) {
                       if (isSuccess) {
                           // 表创建成功
                           MMLog(@"表创建成功");
                           // 添加判断数据是否存在的字段
                           NSDictionary *dic = (NSDictionary *)responseObject;
                           NSMutableDictionary *mutableDic = dic.mutableCopy;
                           [mutableDic setValue:@"exist" forKey:@"ID"];
//                           [mutableDic setValue:@"exist" forKeyPath:@"ID"];
                           
                           // 保存数据
                           [MMDataBase saveItemDict:mutableDic];
                           
                           [ws initDataUI];
 
                           
                       }
                   }];
                } failure:^(NSError *failure) {
                    MMLog(@"PhoneListController =====failure ==========%@",failure);
                }];
            
            
        }
    }];
    
//                NSString *groupName = [dic objectForKey:@"group_Name"];
//                NSInteger empid = [[dic objectForKey:@"emp_Id"] integerValue];
//                NSString *empName = [dic objectForKey:@"emp_Name"];
//                NSString *mobile = [dic objectForKey:@"mobile"];
//                NSString *phone = [dic objectForKey:@"phone"];
//                
//                NSString *sql1 = [NSString stringWithFormat:
//                                  @"INSERT INTO '%@' ('%@', '%@', '%@','%@','%@') VALUES ('%@','%lu','%@', '%@', '%@')",
//                                  @"PHONELIST", @"group_Name", @"emp_Id", @"emp_Name",@"mobile",@"phone", groupName, empid,empName,mobile,phone];
}

- (void)barViewItemSelect:(UILabel *)selectLabel{
    
    [_collectionView setContentOffset:CGPointMake(selectLabel.tag * _collectionView.frame.size.width, 0)];
    // 重新调用一下滚定停止方法，让label的着色和下划线到正确的位置。
    [self.tagView MMscrollViewDidEndScrollingAnimation:_collectionView];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (MMCyeleShowLableTagView *)tagView
{
    if (_tagView == nil) {
        _tagView = [[MMCyeleShowLableTagView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 80)];
        _tagView.backgroundColor = MM_MAIN_BACKGROUND_COLOR;
        
        // 设置频道
        
    }
    return _tagView;
}

- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        // 高度 = 屏幕高度 - 导航栏高度64 - 频道视图高度44
        CGFloat h = ScrH - 64 - self.tagView.height ;
        CGRect frame = CGRectMake(0, CGRectGetMaxY(self.tagView.frame), ScrW, h);
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

#pragma mark ----- 对数组进行排序
- (NSArray  *)sortGroupWith:(NSArray *)array{
//    NSMutableArray  *mutableArray  = array.mutableCopy;
    NSArray *sortDesc = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"group_Name" ascending:YES]];
    NSArray *sortedArr = [array sortedArrayUsingDescriptors:sortDesc];
    
    // 2、对数组进行分组，按GroupTag
    // 遍历,创建组数组,组数组中的每一个元素是一个模型数组
    NSMutableArray *_groupArr = [NSMutableArray array];
    NSMutableArray *currentArr = [NSMutableArray array];
    // 因为肯定有一个字典返回,先添加一个
    [currentArr addObject:sortedArr[0]];
    [_groupArr addObject:currentArr];
    
    
    // 如果不止一个,才要动画添加
    if(sortedArr.count > 1){
        for (int i = 1; i < sortedArr.count; i++) {
            // 先取出组数组中  上一个模型数组的第一个字典模型的groupID
            NSMutableArray *preModelArr = [_groupArr objectAtIndex:_groupArr.count-1];
            NSString *preGroupID = [[preModelArr objectAtIndex:0] objectForKey:@"group_Name"];
            // 取出当前字典,根据groupID比较,如果相同则添加到同一个模型数组;如果不相同,说明不是同一个组的
            NSDictionary *currentDict = sortedArr[i];
            NSString *groupID = [currentDict objectForKey:@"group_Name"];
            if ([groupID isEqualToString:preGroupID]) {
                [currentArr addObject:currentDict];
            }else{
                // 如果不相同,说明 有新的一组,那么创建一个模型数组,并添加到组数组_groupArr
                currentArr = [NSMutableArray array];
                [currentArr addObject:currentDict];
                [_groupArr addObject:currentArr];
            }
        }
    }
    
    return _groupArr;
}

- (void)didSearch:(UIButton *)btn{
    
    EasySerachViewController *easy = [EasySerachViewController new];
    easy.dataArray = self.paramArray;
    [self.navigationController pushViewController:easy animated:YES];
    
}
- (void)initDataUI{
    // 取出全部数据
    NSDictionary *dataBaseDic = [MMDataBase allDatalist];
    MMLog(@"数据库返回数据: %@",dataBaseDic);
    
    NSArray *resultPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                               NSUserDomainMask,
                                                               YES);
    NSString *restltDocumentDirectory = [resultPaths lastObject];
    NSLog(@"restltDocumentDirectory  =====  restltDocumentDirectory------%@",restltDocumentDirectory);
    
    self.paramArray =   [dataBaseDic objectForKey:@"emps"];
    NSArray *resultArray =   [self sortGroupWith:_paramArray];
    
    NSMutableArray *gropNameArray = [NSMutableArray array];
    for (NSArray *array  in resultArray) {
        NSDictionary *dic = array[0];
        NSString *gropName = [dic objectForKey:@"group_Name"];
        [gropNameArray addObject:gropName];
    }
    self.allPersonMessageArray = resultArray;
    self.gropArray = gropNameArray;
    
    
    [_tagView initTag:_gropArray];
    [self.collectionView reloadData];

  
}
@end
