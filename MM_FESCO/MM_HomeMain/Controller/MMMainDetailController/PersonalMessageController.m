//
//  PersonalMessageController.m
//  MM_FESCO
//
//  Created by Mortimey on 16/8/2.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "PersonalMessageController.h"
#import "PersonalMessageDetailCell.h"

#define kBottomButtonW       (((kMMWidth) - 15 - 15 - 10)/2)

@interface PersonalMessageController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView  *tableView;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) UIButton *preservationButton;

@property (nonatomic, strong) UIButton *cancelButton;






@end

@implementation PersonalMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.title = @"个人信息";
    self.dataArray  = @[@"姓名",@"性别",@"联系电话",@"微信号",@"邮箱",@"地址",@"邮编"];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *headerView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 105)];
    headerView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:self.preservationButton];
    [headerView addSubview:self.cancelButton];
    self.tableView.tableFooterView = headerView;
    
    
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 105;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *mainCellID = @"messageCellID";
    
    PersonalMessageDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:mainCellID];
    
    if (!cell) {
        cell = [[PersonalMessageDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mainCellID];
    }
    
    cell.titleStr = self.dataArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

#pragma mark --- Action Targaet
// 保存修改
- (void)didPreservationButton:(UIButton *)btn{
    
}
// 取消修改
- (void)didCancelButton:(UIButton *)btn{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma  mark ----- Lazy 加载
- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        
    }
    return _tableView;
}


- (UIButton *)preservationButton{
    if (_preservationButton == nil) {
        _preservationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _preservationButton.frame = CGRectMake(15, 20, kBottomButtonW, 40);
        [_preservationButton setTitle:@"保存修改" forState:UIControlStateNormal];
        [_preservationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_preservationButton addTarget:self action:@selector(didPreservationButton:) forControlEvents:UIControlEventTouchUpInside];
        [_preservationButton setBackgroundColor:RGB_Color(65, 126, 159)];
        
        _preservationButton.layer.masksToBounds = YES;
        _preservationButton.layer.cornerRadius = 10;
    }
    return _preservationButton;
}
- (UIButton *)cancelButton{
    if (_cancelButton == nil) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.frame = CGRectMake(CGRectGetMaxX(self.preservationButton.frame) + 5, 20, kBottomButtonW, 40);
        [_cancelButton setTitle:@"取消修改" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(didCancelButton:) forControlEvents:UIControlEventTouchUpInside];
        [_cancelButton setBackgroundColor:RGB_Color(65, 126, 159)];
        
        _cancelButton.layer.masksToBounds = YES;
        _cancelButton.layer.cornerRadius = 10;
    }
    return _cancelButton;
}
@end
