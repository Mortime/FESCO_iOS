//
//  ChatViewController.m
//  MM_FESCO
//
//  Created by Mortimey on 2017/3/6.
//  Copyright © 2017年 Mortimey. All rights reserved.
//

#import "ChatViewController.h"

@interface ChatViewController ()<EaseMessageViewControllerDataSource>

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = self;
    
}
- (id<IMessageModel>)messageViewController:(EaseMessageViewController *)viewController modelForMessage:(EMMessage *)message
{
    
    if (message.direction == EMMessageDirectionSend){ /// 用户发送
        //用户可以根据自己的用户体系，根据message设置用户昵称和头像
        id<IMessageModel> model = nil;
        model = [[EaseMessageModel alloc] initWithMessage:message];
        model.avatarImage = [UIImage imageNamed:@"EaseUIResource.bundle/user"];//默认头像
//        NSString *url = [NSString ddl_webImageRequestWithUrl:[NSURL URLWithString:@"www"]];
//        model.avatarURLPath = url;//头像网络地址
        model.nickname = [UserInfoModel defaultUserInfo].empName;//用户昵称
        UIImage *image = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:kUsreIcon]];
        if (image) {
             model.avatarImage = image;
        }
        return model;
    } else {
        //用户可以根据自己的用户体系，根据message设置用户昵称和头像
        id<IMessageModel> model = nil;
        model = [[EaseMessageModel alloc] initWithMessage:message];
        model.avatarImage = [UIImage imageNamed:@"EaseUIResource.bundle/user"];//默认头像
//        NSString *url = [NSString ddl_webImageRequestWithUrl:self.friend_url];
//        model.avatarURLPath = url;//头像网络地址
        model.nickname = self.title;//用户昵称
        if (_imgeIcon) {
            model.avatarImage = _imgeIcon;
        }
        MMLog(@"messageId=%@===message.conversationId==%@",message.messageId,message.conversationId);
        return model;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
