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
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *phoneCell = @"phoneCellID";
    
    PhoneListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:phoneCell];
    
    if (!cell) {
        cell = [[PhoneListTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:phoneCell];
    }
    return cell;

}



@end
