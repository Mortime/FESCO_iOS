//
//  NewReimburseController.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/7.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "NewReimburseController.h"
#import "NewReimburseTemplateCell.h"
#import "NewReimbursePopView.h"
#define kBottomH  50

@interface NewReimburseController () <UITableViewDelegate,UITableViewDataSource,NewReimbursePopViewDelegate>


@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, strong) NSArray *placeTitleArray;

@property (nonatomic, strong) NSArray *detailArray;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UIButton *leftButton;

@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, strong) NewReimbursePopView *popView;


@property (nonatomic, strong) NSString *oneStr;


@end

@implementation NewReimburseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"新建报销单";
    self.titleArray = @[@"模板",@"标题",@"报销日期",@"收款人",@"备注",@"敏感字段"];
    self.placeTitleArray = @[@"请选择模板",@"请输入标题",@"请选择报销日期",@"请选择收款人",@"(选填)",@"(选填)改信息不会被打印"];
    self.view.backgroundColor = MM_GRAYWHITE_BACKGROUND_COLOR;
    
    
    [self.bottomView addSubview:self.leftButton];
    [self.bottomView addSubview:self.rightButton];
    [self.view addSubview:self.bottomView];
    
    
    [self.view addSubview:self.tableView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 5 ;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *sectionOne = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 10)];
        sectionOne.backgroundColor = [UIColor clearColor];
        return sectionOne;
    }
    if (section == 1) {
        UIView *sectionTwo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 45)];
        sectionTwo.backgroundColor = [UIColor clearColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0,self.view.width , 45)];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor grayColor];
        label.text = @"基本信息";
        
        [sectionTwo addSubview:label];
        return sectionTwo;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }
    return 45;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 49;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cellID";
    NewReimburseTemplateCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[NewReimburseTemplateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    
    
    
    // 标题隐藏箭头
    if (indexPath.section == 1) {
        // 标题
        if (indexPath.row == 0) {
            cell.arrowImageView.hidden = YES;
             cell.isExist = YES;
        }
        // 报销日期
        if (indexPath.row == 1) {
            cell.isShowDataPickView = YES;
            cell.isExist = YES;
        }
        // 备注
        if (indexPath.row == 3) {
            cell.isExist = YES;
        }
        //
        if (indexPath.row == 4) {
            cell.isExist = YES;
        }
    }
    
    
    
    
    if (indexPath.section == 0) {
        cell.titleStr = _titleArray[indexPath.row];
        cell.placeHold = _placeTitleArray[indexPath.row];
        cell.detailStr = _oneStr;
    }
    if (indexPath.section == 1) {
        cell.titleStr = _titleArray[indexPath.row + 1];
         cell.placeHold = _placeTitleArray[indexPath.row + 1];
    }
    return cell;
    
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MMLog(@"SelectRowAtIndexPath = %lu",indexPath.row);
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self.view addSubview:self.popView];
    }
}
#pragma mark --  NewReimbursePopViewDelegate  方法
// 点击取消
- (void)newReimbursePopViewDelegate{
    [self.popView removeFromSuperview];
}
// 点击确定
- (void)newReimbursePopViewDelegateWithType:(NSString *)type{
    MMLog(@"type = %@",type);
    _oneStr = type;
     [self.popView removeFromSuperview];
    //一个cell刷新
    [self.tableView reloadData];
//    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
//    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
}
- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0 , self.view.width, self.view.height - kBottomH - 64) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        
    }
    return _tableView;
}
- (UIView *)bottomView{
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - kBottomH - 64, kMMWidth, kBottomH)];
        _bottomView.backgroundColor = [UIColor clearColor];
        
    }
    return _bottomView;
}
- (UIButton *)leftButton{
    if (_leftButton == nil) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.frame = CGRectMake(0, 0, kMMWidth/2, kBottomH);
        _leftButton.backgroundColor = [UIColor whiteColor];
        [_leftButton setTitle:@"¥ 0.00" forState:UIControlStateNormal];
        _leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_leftButton setTitleColor:MM_MAIN_FONTCOLOR_BLUE forState:UIControlStateNormal];
        
        
    }
    return _leftButton;
}
- (UIButton *)rightButton{
    if (_rightButton == nil) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.frame = CGRectMake(kMMWidth/2, 0, kMMWidth/2, kBottomH);
        _rightButton.backgroundColor = MM_MAIN_FONTCOLOR_BLUE;
        [_rightButton setTitle:@"提交送审" forState:UIControlStateNormal];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        
    }
    return _rightButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (NewReimbursePopView *)popView{
    if (_popView == nil) {
        _popView = [[NewReimbursePopView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        _popView.backgroundColor = [UIColor clearColor];
        _popView.delegate = self;
    }
    return _popView;
}
@end
