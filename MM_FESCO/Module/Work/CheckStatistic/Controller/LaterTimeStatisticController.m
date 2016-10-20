//
//  LaterTimeStatisticController.m
//  MM_FESCO
//
//  Created by Mortimey on 16/10/20.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "LaterTimeStatisticController.h"
#import "LaterTimeStatisticCell.h"
#import "LaterTimeStatisticModel.h"
@interface LaterTimeStatisticController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong)  NSMutableArray *dataArray;

@end

@implementation LaterTimeStatisticController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"迟到排行";
    self.view.backgroundColor = MM_GRAYWHITE_BACKGROUND_COLOR;
    self.dataArray = [NSMutableArray array];
    self.tableView.tableHeaderView = [self tableHearderView];
    [self.view addSubview:self.tableView];
    [self initData];
    
}
- (void)initData{
    [NetworkEntity postLaterTimeStatisticSuccess:^(id responseObject) {
        MMLog(@"laterTimeStatistic  =======responseObject=====%@",responseObject);
        if ([[responseObject objectForKey:@"rankList"] count]) {
            NSArray *array =  [responseObject objectForKey:@"rankList"];
            for (NSDictionary *dic in array) {
                LaterTimeStatisticModel *model = [LaterTimeStatisticModel yy_modelWithDictionary:dic];
                [self.dataArray addObject:model];
                
            }
            [_tableView reloadData];
        }
    } failure:^(NSError *failure) {
        MMLog(@"laterTimeStatistic  =======failure=====%@",failure);
    }];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        static NSString *cellID = @"cellID";
        LaterTimeStatisticCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[LaterTimeStatisticCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
    // 从数组最后倒序取值
    NSInteger arrayCount = _dataArray.count - indexPath.row - 1;
    cell.model = _dataArray[arrayCount];
    
        return cell;
        
    
    
}

- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        
    }
    return _tableView;
}
- (UIView *)tableHearderView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 50)];
    view.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 50)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = MM_MAIN_FONTCOLOR_BLUE;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy"];
    NSString *dateStr = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
    [dateFormat1 setDateFormat:@"MM"];
    NSString *dateStr1 = [dateFormat1 stringFromDate:[NSDate date]];
   
    NSString *enlishMouth = [self headerLaberText:[dateStr1 integerValue]];
    
    NSString *result  = [NSString stringWithFormat:@"%@ %@",enlishMouth,dateStr];
    
    label.text = result;
    
    
    [view addSubview:label];
    return view;
    
}

- (NSString *)headerLaberText:(NSInteger)mouthNubmer{
    /*
     一月 January Jan.
     二月 February Feb.
     三月 March Mar.
     四月 April Apr.
     五月 May May
     六月 June Jun.
     七月 July Jul.
     八月 August Aug.
     九月September Sep.
     十月 October Oct.
     十一月November Nov. 
     十二月December Dec.
     
     */
    
    
    
   NSString *mouthElish = @"";
    if (mouthNubmer == 1) {
        mouthElish = @"In January,";
    }
    if (mouthNubmer == 2) {
        mouthElish = @"In February,";
    }
    if (mouthNubmer == 3) {
        mouthElish = @"In March,";
    }if (mouthNubmer == 4) {
        mouthElish = @"In April,";
    }
    if (mouthNubmer == 5) {
        mouthElish = @"In May,";
    }if (mouthNubmer == 6) {
        mouthElish = @"In June,";
    }if (mouthNubmer == 7) {
        mouthElish = @"In July,";
    }if (mouthNubmer == 8) {
        mouthElish = @"In August,";
    }if (mouthNubmer == 9) {
        mouthElish = @"In September,";
    }if (mouthNubmer == 10) {
        mouthElish = @"In October,";
    }if (mouthNubmer == 11) {
        mouthElish = @"In November,";
    }if (mouthNubmer == 12) {
        mouthElish = @"In December,";
    }
    return mouthElish;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
