//
//  PhoneListTableController.m
//  MM_FESCO
//
//  Created by Mortimey on 16/8/25.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "PhoneListTableController.h"
#import "PhoneListTableCell.h"

@interface PhoneListTableController ()

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
    
    cell.nameLabel.text = [dic objectForKey:@"emp_Name"];
    
    cell.mobileLabel.text = [dic objectForKey:@"mobile"];
    
    cell.parantVC = nil;
    cell.parantVC  = self;
    
    NSString *phoneStr = [dic objectForKey:@"phone"];
    if (phoneStr == nil  || [phoneStr isMemberOfClass:[NSNull class]]) {
        phoneStr = @"暂无";
    }
     cell.phoneLabel.text = phoneStr;
    
    [cell.leftImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"People_placehode"]];
    
    return cell;

}



@end
