//
//  PhoneListTableController.m
//  MM_FESCO
//
//  Created by Mortimey on 16/8/25.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "PhoneListTableController.h"
#import "PhoneListTableCell.h"
#import "ChatViewController.h"

@interface PhoneListTableController ()<PhoneListTableCellDelegate>

@property (nonatomic, strong) NSMutableArray *dataList;



@end

@implementation PhoneListTableController

- (instancetype)init{
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor clearColor];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.showsVerticalScrollIndicator = NO;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tableView.backgroundColor = [UIColor clearColor];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allPersonListArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *phoneCell = @"phoneCellID";
    
    PhoneListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:phoneCell];
    
    if (!cell) {
        cell = [[PhoneListTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:phoneCell];
    }
    NSDictionary *dic = _allPersonListArray[indexPath.row];
    
    
    if (![[dic objectForKey:@"emp_Name"] isKindOfClass:[NSNull class]]){
       cell.nameLabel.text = [dic objectForKey:@"emp_Name"];
        cell.empName = [dic objectForKey:@"emp_Name"];
    }
    
    if (![[dic objectForKey:@"mobile"] isKindOfClass:[NSNull class]]) {
        cell.mobileLabel.text = [dic objectForKey:@"mobile"];
    }
    
    
    
    cell.parantVC = nil;
    cell.parantVC  = self;
    cell.delegate = self;
    NSString *phoneStr = [dic objectForKey:@"phone"];
    if (phoneStr == nil  || [phoneStr isMemberOfClass:[NSNull class]]) {
        phoneStr = @" ";
    }
     cell.phoneLabel.text = phoneStr;
    
    
    cell.empID = [[dic objectForKey:@"emp_Id"] integerValue];
    
    NSData *avearData = [MMDataBase getAvtarDateWith:[[dic objectForKey:@"emp_Id"] integerValue]];
    MMLog(@"数据库中取出的头像 ==%@empID==%lu",avearData,[[dic objectForKey:@"emp_Id"] integerValue]);
    if (avearData) {
        cell.leftImageView.image = [UIImage imageWithData:avearData];
        cell.imgIcon = [UIImage imageWithData:avearData];
    }else{
        cell.leftImageView.image = [UIImage imageNamed:@"People_placehode"];
    }

    
    return cell;

}

- (void)phoneListTableCellDelegateWithEmpID:(NSInteger)empID empName:(NSString *)empName iconImage:(UIImage *)iconImage{
    MMLog(@"各种回调后的========%lu=====%@",empID,empName);
    NSString *EEMID = [NSString stringWithFormat:@"zrfesco_%lu",empID];
    ChatViewController *chatController = [[ChatViewController alloc] initWithConversationChatter:EEMID conversationType:EMConversationTypeChat];
    chatController.hidesBottomBarWhenPushed= YES;
    chatController.title = empName;
    chatController.imgeIcon = iconImage;
    [_pareVC.navigationController pushViewController:chatController animated:YES];

    
    
}

@end
