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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *phoneCell = @"messageCellID";
    
    PhoneListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:phoneCell];
    
    if (!cell) {
        cell = [[PhoneListTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:phoneCell];
    }
    return cell;

}



@end
