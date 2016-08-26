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


#define ScrW [UIScreen mainScreen].bounds.size.width
#define ScrH [UIScreen mainScreen].bounds.size.height
#define AppColor [UIColor colorWithRed:0.00392 green:0.576 blue:0.871 alpha:1]

static NSString * const reuseID  = @"PhoneListCell";
static sqlite3 *database;

@interface PhoneListController ()<UICollectionViewDataSource,UICollectionViewDelegate>

// 企业部门
@property (nonatomic, strong) NSArray *gropArray;

// 部门列表展示
@property (nonatomic, strong) UIScrollView *smallScrollView;

// 通讯录视图
@property (nonatomic, strong) UICollectionView *collectionView;

// 给随的线
@property (nonatomic, strong) UIView *underline;


// 全部员工的信息
@property (nonatomic, strong) NSMutableArray *allPersonMessageArray;
@end

@implementation PhoneListController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor clearColor];
    self.title = @"通讯录";
    self.allPersonMessageArray = [NSMutableArray array];
    self.gropArray = @[@"管理咨询",@"会计事业",@"薪酬事业",@"行政部",@"财务部",@"人力资源",@"管理层",@"营销管理",@"业务外包"];
    
    [self initUI];
    [self initData];
    
//    [self initDBData];
    
}
- (void)initUI{
    [self.view addSubview:self.smallScrollView];
    [self.view addSubview:self.collectionView];
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
    cell.urlString = title;
    
    // 如果不加入响应者链，则无法利用NavController进行Push/Pop等操作。
//    [self addChildViewController:(UIViewController *)cell.phoneListVC];
    return cell;
}
#pragma mark - UICollectionViewDelegate
/** 正在滚动 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat value = scrollView.contentOffset.x / scrollView.frame.size.width;
    if (value < 0) {return;} // 防止在最左侧的时候，再滑，下划线位置会偏移，颜色渐变会混乱。
    
    NSUInteger leftIndex = (int)value;
    NSUInteger rightIndex = leftIndex + 1;
    if (rightIndex >= [self getLabelArrayFromSubviews].count) {  // 防止滑到最右，再滑，数组越界，从而崩溃
        rightIndex = [self getLabelArrayFromSubviews].count - 1;
    }
    
    CGFloat scaleRight = value - leftIndex;
    CGFloat scaleLeft  = 1 - scaleRight;
    
    DDChannelLabel *labelLeft  = [self getLabelArrayFromSubviews][leftIndex];
    DDChannelLabel *labelRight = [self getLabelArrayFromSubviews][rightIndex];
    
    labelLeft.scale  = scaleLeft;
    labelRight.scale = scaleRight;
    
    // 点击label会调用此方法1次，会导致【scrollViewDidEndScrollingAnimation】方法中的动画失效，这时直接return。
    if (scaleLeft == 1 && scaleRight == 0) {
        return;
    }
    
    // 下划线动态跟随滚动
    _underline.centerX = labelLeft.centerX   + (labelRight.centerX   - labelLeft.centerX)   * scaleRight;
    _underline.width   = labelLeft.textWidth + (labelRight.textWidth - labelLeft.textWidth) * scaleRight;
}

/** 手指滑动BigCollectionView，滑动结束后调用 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.collectionView]) {
        [self scrollViewDidEndScrollingAnimation:scrollView];
    }
}

/** 手指点击smallScrollView */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 获得索引
    NSUInteger index = scrollView.contentOffset.x / self.collectionView.width;
    // 滚动标题栏到中间位置
    DDChannelLabel *titleLable = [self getLabelArrayFromSubviews][index];
    CGFloat offsetx   =  titleLable.center.x - _smallScrollView.width * 0.5;
    CGFloat offsetMax = _smallScrollView.contentSize.width - _smallScrollView.width;
    // 在最左和最右时，标签没必要滚动到中间位置。
    if (offsetx < 0)		 {offsetx = 0;}
    if (offsetx > offsetMax) {offsetx = offsetMax;}
    [_smallScrollView setContentOffset:CGPointMake(offsetx, 0) animated:YES];
    
    // 先把之前着色的去色：（快速滑动会导致有些文字颜色深浅不一，点击label会导致之前的标题不变回黑色）
    for (DDChannelLabel *label in [self getLabelArrayFromSubviews]) {
        label.textColor = [UIColor whiteColor];
    }
    // 下划线滚动并着色
    [UIView animateWithDuration:0.5 animations:^{
        _underline.width = titleLable.textWidth;
        _underline.centerX = titleLable.centerX;
        titleLable.textColor = AppColor;
    }];
}


/** 获取smallScrollView中所有的DDChannelLabel，合成一个数组，因为smallScrollView.subViews中有其他非Label元素 */
- (NSArray *)getLabelArrayFromSubviews
{
    NSMutableArray *arrayM = [NSMutableArray array];
    for (DDChannelLabel *label in _smallScrollView.subviews) {
        if ([label isKindOfClass:[DDChannelLabel class]]) {
            [arrayM addObject:label];
        }
    }
    return arrayM.copy;
}

#pragma mark -
/** 设置部门标题 */
- (void)setupChannelLabel
{
    CGFloat margin = 20.0;
    CGFloat x = 8;
    CGFloat h = _smallScrollView.bounds.size.height;
    int i = 0;
    for (NSString *channel in _gropArray) {
        DDChannelLabel *label = [DDChannelLabel channelLabelWithTitle:channel];
        label.frame = CGRectMake(x, 0, label.width + margin, h);
        label.textColor = [UIColor whiteColor];
        [_smallScrollView addSubview:label];
        
        x += label.bounds.size.width;
        label.tag = i++;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
    }
    _smallScrollView.contentSize = CGSizeMake(x + margin, 0);
}

/** 频道Label点击事件 */
- (void)labelClick:(UITapGestureRecognizer *)recognizer
{
    DDChannelLabel *label = (DDChannelLabel *)recognizer.view;
    // 点击label后，让bigCollectionView滚到对应位置。
    [_collectionView setContentOffset:CGPointMake(label.tag * _collectionView.frame.size.width, 0)];
    // 重新调用一下滚定停止方法，让label的着色和下划线到正确的位置。
    [self scrollViewDidEndScrollingAnimation:self.collectionView];
}


- (void)initData{
    
    // 创建通讯录数据库表
    
    __weak typeof(self) ws = self;
    
    [NetworkEntity postPhoneNumberListWithCustId:[UserInfoModel defaultUserInfo].custId success:^(id responseObject) {
        MMLog(@"PhoneListController =====responseObject =============%@",responseObject);
        
        NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString* dbpath = [docsdir stringByAppendingPathComponent:FESCODATABASE];
        FMDatabase* db = [FMDatabase databaseWithPath:dbpath];
        [db open];
        
        BOOL result=[db executeUpdate:@"CREATE TABLE IF NOT EXISTS PHONELIST (ID INTEGER PRIMARY KEY, group_name TEXT, emp_id INTEGER, emp_name TEXT, mobile TEXT,phone TEXT)"];
        if (result) {
            NSLog(@"创建表成功");
            // 保存数据
            NSArray  *param =   [responseObject objectForKey:@"emps"];
         NSArray *resultArray =   [self sortGroupWith:param];
          
            NSMutableArray *gropNameArray = [NSMutableArray array];
            for (NSArray *array  in resultArray) {
                NSDictionary *dic = array[0];
                NSString *gropName = [dic objectForKey:@"group_Name"];
                [gropNameArray addObject:gropName];
            }
            self.gropArray = gropNameArray;
            
            
            
            
            
            NSLog(@"param.count = %lu",param.count);
            for (NSDictionary *dic in param) {
                
            
                NSString *groupName = [dic objectForKey:@"group_Name"];
                NSInteger empid = [[dic objectForKey:@"emp_Id"] integerValue];
                NSString *empName = [dic objectForKey:@"emp_Name"];
                NSString *mobile = [dic objectForKey:@"mobile"];
                NSString *phone = [dic objectForKey:@"phone"];
                
                NSString *sql1 = [NSString stringWithFormat:
                                  @"INSERT INTO '%@' ('%@', '%@', '%@','%@','%@') VALUES ('%@','%lu','%@', '%@', '%@')",
                                  @"PHONELIST", @"group_Name", @"emp_Id", @"emp_Name",@"mobile",@"phone", groupName, empid,empName,mobile,phone];
                [db executeUpdate:sql1];
                
                PhoneListModel *listModel = [PhoneListModel yy_modelWithDictionary:dic];
                [self.allPersonMessageArray addObject:listModel];
            

            }
             [self.collectionView reloadData];

            
        }else
        { NSLog(@"创建表失败");
        }
        
        
        

        NSArray *resultPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                   NSUserDomainMask,
                                                                   YES);
        NSString *restltDocumentDirectory = [resultPaths lastObject];
        NSLog(@"restltDocumentDirectory  =====  restltDocumentDirectory------%@",restltDocumentDirectory);
        
    } failure:^(NSError *failure) {
        MMLog(@"PhoneListController =====failure ==========%@",failure);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)execSql:(NSString *)sql
{
    char *err;
    if (sqlite3_exec(database, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(database);
//        NSLog(@"数据库操作数据失败!");
    }
}

- (UIScrollView *)smallScrollView
{
    if (_smallScrollView == nil) {
        _smallScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 80)];
        _smallScrollView.backgroundColor = MM_MAIN_BACKGROUND_COLOR;
        _smallScrollView.showsHorizontalScrollIndicator = NO;
        
        // 设置频道
        
        [self setupChannelLabel];
        // 设置下划线
        [_smallScrollView addSubview:({
            DDChannelLabel *firstLabel = [self getLabelArrayFromSubviews][0];
            firstLabel.textColor = MM_MAIN_FONTCOLOR_BLUE;
            // smallScrollView高度44，取下面4个点的高度为下划线的高度。
            _underline = [[UIView alloc] initWithFrame:CGRectMake(0, 77, firstLabel.textWidth, 3)];
            _underline.centerX = firstLabel.centerX;
            _underline.backgroundColor = MM_MAIN_FONTCOLOR_BLUE;
            _underline;
        })];
    }
    return _smallScrollView;
}

- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        // 高度 = 屏幕高度 - 导航栏高度64 - 频道视图高度44
        CGFloat h = ScrH - 64 - self.smallScrollView.height ;
        CGRect frame = CGRectMake(0, CGRectGetMaxY(self.smallScrollView.frame), ScrW, h);
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

- (NSArray  *)sortGroupWith:(NSArray *)array{
//    NSMutableArray  *mutableArray  = array.mutableCopy;
    NSArray *sortDesc = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"group_Name" ascending:YES]];
    NSArray *sortedArr = [array sortedArrayUsingDescriptors:sortDesc];
    NSLog(@"sortedArr = %@",sortedArr);
    
    // 2、对数组进行分组，按GroupTag
    // 遍历,创建组数组,组数组中的每一个元素是一个模型数组
    NSMutableArray *_groupArr = [NSMutableArray array];
    NSMutableArray *currentArr = [NSMutableArray array];
    NSLog(@"class--%@",[currentArr class]);
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
    
    MMLog(@"_groupArr ==   %@",_groupArr);
    
    return _groupArr;
}



@end
