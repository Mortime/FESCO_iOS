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
#import "BuffetDataTool.h"

@interface SocialSecurityChooseDataController ()<UIGestureRecognizerDelegate,UISearchBarDelegate,UITextFieldDelegate>

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SocialSecurityChooseDataController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    if (_dataType == nation) {
       self.title = @"请选择民族";
    }else if (_dataType == country){
        self.title = @"请选择国籍";
    }
    

    self.view.backgroundColor = MM_GRAYWHITE_BACKGROUND_COLOR;


    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.frame           = CGRectMake(0,0, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height - 64);
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate        = self;
    _tableView.dataSource      = self;
    _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    _tableView.sectionIndexColor = MM_MAIN_FONTCOLOR_BLUE;
    [self.view addSubview:_tableView];
    
    [self initData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ReUI) name:@"ReUI" object:nil];

}
- (void)ReUI{
    
    if (_dataType == nation) {
        NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"nation"ofType:@"plist"];
        NSMutableDictionary *dataDic = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
        NSLog(@"dataDic=============民族============ = =========%@",dataDic);
        _dataDic = dataDic;
    }else if (_dataType == country){
        NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"country"ofType:@"plist"];
        NSMutableDictionary *dataDic = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
        NSLog(@"dataDic=============国籍============ = =========%@",dataDic);
        _dataDic = dataDic;
    }
   
    

    [self.tableView reloadData];
}
- (void)initData{
    BuffetDataTool *tool = [[BuffetDataTool alloc] init];
    
    if (_dataType == nation) {
        [tool buffetDataNationPlist];
    }else if (_dataType == country){
        [tool buffetDataCountPlist];
    }

    
    
    
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
    
    
    static NSString *CellIdentifier = @"Cell";
    
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *allkey = [self sortDurationWith:_dataDic];
    NSString *keyStr = allkey[indexPath.section];
    NSArray *array = [_dataDic objectForKey:keyStr];
    NSDictionary *dic = array[indexPath.row];
    NSString *key = [dic allKeys][0];
    NSString *content  = [dic objectForKey:key];
    if ([_delegate respondsToSelector:@selector(didClickedWithContent:code:dataType:)]) {
        [_delegate didClickedWithContent:content code:key dataType:_dataType];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [self sortDurationWith:_dataDic];
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
