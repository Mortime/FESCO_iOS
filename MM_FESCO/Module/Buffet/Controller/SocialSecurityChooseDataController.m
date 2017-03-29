//
//  SocialSecurityChooseDataController.m
//  MM_FESCO
//
//  Created by Mortimey on 2017/1/9.
//  Copyright © 2017年 Mortimey. All rights reserved.
//

#import "SocialSecurityChooseDataController.h"
#import "ZYPinYinSearch.h"

#import "PinYinForObjc.h"
#import "DVVSearchView.h"
#import "DVVSubCityView.h"
#import "BuffetDataTool.h"

#define KSectionIndexBackgroundColor  [UIColor clearColor] //索引试图未选中时的背景颜色
#define kSectionIndexTrackingBackgroundColor [UIColor lightGrayColor]//索引试图选中时的背景
#define kSectionIndexColor [UIColor grayColor]//索引试图字体颜色
#define BGCOLOR [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1]

@interface SocialSecurityChooseDataController ()<UIGestureRecognizerDelegate,UISearchBarDelegate,UITextFieldDelegate, DVVSubCityViewDelegate>

// 搜索框
@property (nonatomic, strong) DVVSearchView *searchView;
@property (nonatomic, strong) UIView *searchContentView;

@property (strong, nonatomic) UIView *tableHeaderView;


@property (strong, nonatomic) NSMutableArray *shouzifuArray;//定位城市数据


@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

@implementation SocialSecurityChooseDataController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"请选择民族";
    self.shouzifuArray = [NSMutableArray array];

    self.view.backgroundColor = MM_GRAYWHITE_BACKGROUND_COLOR;

    
    _searchView = [DVVSearchView new];
    _searchView.placeholder = @"请输入民族";
    _searchView.backgroundImageView.backgroundColor = [UIColor whiteColor];
    _searchView.frame = CGRectMake(16, 7, self.view.bounds.size.width - 16 * 2, _searchView.defaultHeight);
    __weak typeof(self) ws = self;
    [_searchView dvv_setTextFieldDidEndEditingBlock:^(UITextField *textField) {
        [ws dvvTextFieldDidEndEditingAction:textField];
    }];
    [_searchView dvv_setTextFieldTextChangeBlock:^(UITextField *textField) {
        [ws dvvTextFieldTextChangeAction:textField];
    }];
    
    _searchContentView = [UIView new];
    _searchContentView.backgroundColor = [UIColor clearColor];
    _searchContentView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 40);
    [_searchContentView addSubview:_searchView];
    
    _searchContentView.layer.shadowColor = [UIColor blackColor].CGColor;
    _searchContentView.layer.shadowOffset = CGSizeMake(0, 2);
    _searchContentView.layer.shadowOpacity = 0.3;
    _searchContentView.layer.shadowRadius = 2;
    
    // Do any additional setup after loading the view.
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.frame           = CGRectMake(0,_searchContentView.frame.origin.y+_searchContentView.frame.size.height, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height - 64 - 40);
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate        = self;
    _tableView.dataSource      = self;
    
    
    [self.view addSubview:_tableView];
    [self.view addSubview:_searchContentView];
    
    // 在加载出来数据之前，先隐藏控件
//    _tableView.alpha = 0;
//    _searchContentView.alpha = 0;
    // 在加载出来数据之前先不能让用户点击搜索，否则就会有个小问题
//    _searchContentView.userInteractionEnabled = NO;
    
    [self initData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ReUI) name:@"ReUI" object:nil];

}
- (void)ReUI{
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"nation"ofType:@"plist"];
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
    NSLog(@"dataDic=============  iiiiii ============ = =========%@",dataDic);
    _dataDic = dataDic;
    

    [self.tableView reloadData];
}
- (void)initData{
    BuffetDataTool *tool = [[BuffetDataTool alloc] init];
    [tool buffetDataNationPlist];
    
    
}
#pragma mark - tableView
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
    bgView.backgroundColor = [UIColor clearColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 0, 250, 30)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:14];
    NSArray *allkey = [self sortDurationWith:_dataDic];
    
    
    titleLabel.text = allkey[section];
    [bgView addSubview:titleLabel];
    
    return bgView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[_dataDic allKeys] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *allkey = [self sortDurationWith:_dataDic];
    
    NSString *keyStr = allkey[section];
    NSArray *array = [_dataDic objectForKey:keyStr];
    
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([_tableView respondsToSelector:@selector(setSectionIndexColor:)]) {
        _tableView.sectionIndexBackgroundColor = KSectionIndexBackgroundColor;  //修改索引试图未选中时的背景颜色
        _tableView.sectionIndexTrackingBackgroundColor = kSectionIndexTrackingBackgroundColor;//修改索引试图选中时的背景颜色
        _tableView.sectionIndexColor = kSectionIndexColor;//修改索引试图字体颜色
    }
    
    
    static NSString *CellIdentifier = @"Cell";
    
//    NSString *key = [_keys objectAtIndex:indexPath.section];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        cell.backgroundColor = [UIColor whiteColor];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.textLabel setTextColor:[UIColor colorWithWhite:0 alpha:0.7]];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    NSArray *allkey = [self sortDurationWith:_dataDic];
    NSString *keyStr = allkey[indexPath.section];
    NSArray *array = [_dataDic objectForKey:keyStr];
    NSDictionary *dic = array[indexPath.row];
    NSString *key = [dic allKeys][0];
    cell.textLabel.text = [dic objectForKey:key];
    return cell;
}

#pragma mark 搜索
- (void)dvvTextFieldTextChangeAction:(UITextField *)textField {
    [self filterContentForSearchText:textField.text];
}

- (void)dvvTextFieldDidEndEditingAction:(UITextField *)textField {
    [self filterContentForSearchText:textField.text];
}

- (void)ininHeaderView
{
    
//    [self getCityData];
    [_tableView reloadData];
    // 显示出来控件
    _searchContentView.userInteractionEnabled = YES;
    [UIView animateWithDuration:0.3 animations:^{
        _tableView.alpha = 1;
        _searchContentView.alpha = 1;
    }];
    //    [UIView animateWithDuration:0.3 animations:^{
    _tableView.tableHeaderView = _tableHeaderView;
    //    }];
}
/**
 *  通过搜索条件过滤得到搜索结果
 *
 *  @param searchText 关键词
 *  @param scope      范围
 */
- (void)filterContentForSearchText:(NSString*)searchText {
    
}
//  升序排序
- (NSArray *)sortDurationWith:(NSMutableDictionary *)dic{
    
    NSArray *allkey = [dic allKeys];
    NSArray *newArray = [allkey sortedArrayUsingSelector:@selector(compare:)];
    return newArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
