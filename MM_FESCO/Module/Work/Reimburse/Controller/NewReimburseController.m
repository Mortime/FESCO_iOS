//
//  NewReimburseController.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/7.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "NewReimburseController.h"
#import "NewReimburseTemplateCell.h"

#define kBottomH  50

@interface NewReimburseController () <UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, strong) NSArray *detailArray;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UIButton *leftButton;

@property (nonatomic, strong) UIButton *rightButton;


@end

@implementation NewReimburseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"新建报销单";
    self.titleArray = @[@"模板",@"标题",@"报销部门",@"报销日期",@"收款人",@"备注",@"敏感字段"];
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
        return 6 ;
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
    if (indexPath.section == 0) {
        cell.titleStr = _titleArray[indexPath.row];
    }
    if (indexPath.section == 1) {
        cell.titleStr = _titleArray[indexPath.row + 1];
    }
    return cell;
    
    
    
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
        [_leftButton setTitle:@"¥ 8894" forState:UIControlStateNormal];
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

@end
