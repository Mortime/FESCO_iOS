//
//  OverTimeStatistiscController.m
//  MM_FESCO
//
//  Created by Mortimey on 16/10/21.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "OverTimeStatistiscController.h"
#import "OverTimeStatisticCell.h"
#import "OverTimeStatisticModel.h"
#import "OverTimeStatisticHeaderView.h"
#import "MMNoDataShowBGView.h"

#define kLeftW  88

#define kLeftH  (88 + 48)

#define kMightW 112

#define kMightH  (112 + 48)

#define kMarginW (((kMMWidth) - ((kLeftW * 2)) - (kMightW)) / 4)



@interface OverTimeStatistiscController () <UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong)  NSMutableArray *dataArray;

@property (nonatomic,strong) OverTimeStatisticHeaderView *leftView;

@property (nonatomic,strong) OverTimeStatisticHeaderView *mightView;

@property (nonatomic,strong) OverTimeStatisticHeaderView *rightView;

@property (nonatomic, strong) MMNoDataShowBGView *noDataShowBGView;


@end

@implementation OverTimeStatistiscController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"加班排行";
    self.view.backgroundColor = MM_GRAYWHITE_BACKGROUND_COLOR;
    self.dataArray = [NSMutableArray array];

    [self.view addSubview:self.tableView];
    [self.view addSubview:self.noDataShowBGView];
    [self initData];
    
}
- (void)initData{
    
    [NetworkEntity postOverTimeStatisticSuccess:^(id responseObject) {
        
        MMLog(@"OverTimeStatistic  =======responseObject=====%@",responseObject);
        if ([[responseObject objectForKey:@"rankList"] count]) {
            _noDataShowBGView.hidden = YES;
            NSArray *array = [self sortDurationWith:[responseObject objectForKey:@"rankList"]];
            for (NSDictionary *dic in array) {
                OverTimeStatisticModel *model = [OverTimeStatisticModel yy_modelWithDictionary:dic];
                [_dataArray addObject:model];
                
            }

        }else{
            _noDataShowBGView.hidden = NO;
        }
        
        [_tableView reloadData];
    } failure:^(NSError *failure) {
        MMLog(@"OverTimeStatistic  =======failure=====%@",failure);
    }];
    

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cellID";
    OverTimeStatisticCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[OverTimeStatisticCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
//    // 从数组最后倒序取值
    NSInteger arrayCount = _dataArray.count - indexPath.row - 1;
    cell.model = _dataArray[arrayCount];
    cell.index = indexPath.row  + 1;
    
    if (_dataArray.count) {
        
        if (indexPath.row == 0) {
            cell.flageImageView.hidden = NO;
            cell.flageImageView.image = [UIImage imageNamed:@"OverTimeStatistic_Trophy"];
        }
        if (indexPath.row == 1) {
            cell.flageImageView.hidden = NO;
            cell.flageImageView.image = [UIImage imageNamed:@"OverTimeStatistic_Yin"];
        }
        if (indexPath.row == 2) {
            cell.flageImageView.hidden = NO;
            cell.flageImageView.image = [UIImage imageNamed:@"OverTimeStatistic_Tong"];
            
        }
        
    }

    
    return cell;
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height- 64) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        
    }
    return _tableView;
}
//  冒泡排序按照加班时长升序排序
- (NSArray *)sortDurationWith:(NSArray *)array{
    for (int i = 0; i < array.count - 1; i ++) {
        for (int j = 0 ; j < array.count - 1 - i; j ++) {
            if ([[array[j] objectForKey:@"duration"] floatValue] > [[array[j + 1] objectForKey:@"duration"] floatValue]) {
                NSDictionary *dic = array[j];
                array[j][@"duration"]  =  array[j + 1][@"duration"];
                array[j][@"emp_Name"]  =  array[j + 1][@"emp_Name"];
                array[j][@"counts"]  =  array[j + 1][@"counts"];
                
                array[j + 1][@"duration"] = dic[@"duration"];
                array[j + 1][@"emp_Name"] = dic[@"emp_Name"];
                array[j + 1][@"counts"] = dic[@"counts"];
                
            }
            
        }
    }
    
    MMLog(@"array排序后  ==  %@",array);
    return array;
}
- (OverTimeStatisticHeaderView *)leftView{
    if (_leftView == nil) {
        _leftView = [[OverTimeStatisticHeaderView alloc] initWithFrame:CGRectMake(kMarginW, 19, kLeftW, kLeftH)];
//        _leftView.backgroundColor = [UIColor orangeColor];
        
    }
    return _leftView;
}
- (OverTimeStatisticHeaderView *)mightView{
    if (_mightView == nil) {
        _mightView = [[OverTimeStatisticHeaderView alloc] initWithFrame:CGRectMake((kMarginW * 2) + kLeftW , 9, kMightW, kMightH)];
//        _mightView.backgroundColor = [UIColor redColor];
        
    }
    return _mightView;
}
- (OverTimeStatisticHeaderView *)rightView{
    if (_rightView == nil) {
        _rightView = [[OverTimeStatisticHeaderView alloc] initWithFrame:CGRectMake((kMarginW * 3) + kLeftW + kMightW, 19, kLeftW, kLeftH)];
//        _rightView.backgroundColor = [UIColor cyanColor];
        
    }
    return _rightView;
}
- (MMNoDataShowBGView *)noDataShowBGView{
    if (_noDataShowBGView == nil) {
        _noDataShowBGView = [[MMNoDataShowBGView alloc] initWithFrame:CGRectMake(0, 0,self.view.width,self.view.height)];
        _noDataShowBGView.imgStr = @"MM_NO_Recorder";
        _noDataShowBGView.hidden = YES;
    }
    return _noDataShowBGView;
}

@end
