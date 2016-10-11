//
//  MMScrollView.h
//  MM_FESCO
//
//  Created by Mortimey on 16/10/10.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMScrollView : UIScrollView<UIGestureRecognizerDelegate>

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;

@end
