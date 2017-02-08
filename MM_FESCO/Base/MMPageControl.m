//
//  MMPageControl.m
//  MM_FESCO
//
//  Created by Mortimey on 16/10/12.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "MMPageControl.h"

@implementation MMPageControl

-(id) initWithFrame:(CGRect)frame

{
    
    self = [super initWithFrame:frame];
    
    
    activeImage = [UIImage imageNamed:@"RedPoint.png"] ;
    
    inactiveImage = [UIImage imageNamed:@"BluePoint.png"] ;
    
    
    return self;
    
}


-(void) updateDots

{
    for (int i=0; i<[self.subviews count]; i++) {
        
        UIImageView* dot = (UIImageView *)[self.subviews objectAtIndex:i];
        
        CGSize size;
        
        size.height = 7;     //自定义圆点的大小
        
        size.width = 7;      //自定义圆点的大小
        [dot setFrame:CGRectMake(dot.frame.origin.x, dot.frame.origin.y, size.width, size.width)];
        
        
        
//        当然也可以通过添加图片视图来设置自定义图片
                UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 7, 15, 15)];
        
        
//        可以像这样加载自定义的图片
                imageView.image = (i == self.currentPage) ? activeImage : inactiveImage;
                [dot addSubview:imageView];
        
        
        
        
        
        
//        if (i==self.currentPage){
//            dot.image=[UIImage imageNamed:@"RedPoint.png"];
//        }else {
//            
////            dot.image = [UIImage imageNamed:@"BluePoint.png"];
//
//        }
    }
    
}

-(void) setCurrentPage:(NSInteger)page

{
    
    [super setCurrentPage:page];
    
    [self updateDots];
    
}

@end
