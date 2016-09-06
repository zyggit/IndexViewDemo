//
//  HCSideSlipTransmition.m
//  HelperCar
//
//  Created by Jentle on 15/9/1.
//  Copyright © 2015年 Jentle. All rights reserved.
//

#import "HCSideSlipTransmition.h"
#import "HCView.h"

@interface HCSideSlipTransmition ()<UIGestureRecognizerDelegate>
{
    HCView *bottomView;
}
@property (assign, nonatomic) CGRect frame;
@property (strong, nonatomic) UIView *view;
@property (strong, nonatomic) UIView *parentView;
@property (assign, nonatomic) BOOL showBlackBottom;
@property (strong, nonatomic) UIView *blackBottom;
@end

@implementation HCSideSlipTransmition
- (instancetype)initWithframe:(CGRect)frame withView:(UIView *)view withParentView:(UIView *)parentView showBlackBottom:(BOOL)show
{
    self = [super init];
    if (self) {
        _frame = frame;
        _view = view;
        _parentView = parentView;
        _showBlackBottom = show;
        [self.view removeFromSuperview];
        self.view.frame = CGRectMake(0, 0, _view.frame.size.width, _view.frame.size.height);
        self.view.transform = CGAffineTransformMakeTranslation(_frame.size.width, 0);
        if (_showBlackBottom == NO) {
            UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveWithPan:)];
            pan.delegate = self;
            _blackBottom = [[UIView alloc] initWithFrame:CGRectMake(_frame.origin.x, _frame.origin.y, _frame.size.width, _frame.size.height)];
            [_blackBottom addGestureRecognizer:pan];
            [_blackBottom addSubview:self.view];
            [_parentView addSubview:_blackBottom];
        }else{
            __DEFINE_WEAK_SELF;
            UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveWithPan:)];
            pan.delegate = self;
            _blackBottom = [[UIView alloc] initWithFrame:CGRectMake(_frame.origin.x, 0, _parentView.bounds.size.width, _parentView.bounds.size.height)];
            [_blackBottom addGestureRecognizer:pan];
            
            [_blackBottom addSubview:_view];
            
            bottomView = [[HCView alloc] initWithFrame:CGRectMake(0, _frame.origin.y, _parentView.bounds.size.width, _parentView.bounds.size.height)];
            bottomView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
            bottomView.touchBeginBlock = ^(void){
                [weakSelf dismiss:YES];
            };
            [self.parentView addSubview:bottomView];
            [bottomView addSubview:_blackBottom];
        }
    }
    return self;
}

- (void)dismiss:(BOOL)animated{
    if (animated) {
        [UIView animateWithDuration:0.4 animations:^{
            self.view.transform = CGAffineTransformMakeTranslation(_frame.size.width, 0);
        } completion:^(BOOL finished) {
            [_blackBottom removeFromSuperview];
            [bottomView removeFromSuperview];
        }];
    }else{
        self.view.transform = CGAffineTransformMakeTranslation(_frame.size.width, 0);
        [_blackBottom removeFromSuperview];
        [bottomView removeFromSuperview];

    }
}

- (void)show{
    [self.parentView addSubview:bottomView];
    if (_showBlackBottom) {
        [bottomView addSubview:_blackBottom];
    }else{
        [_parentView addSubview:_blackBottom];
    }
    [UIView animateWithDuration:0.4 animations:^{
         self.view.transform = CGAffineTransformMakeTranslation(0, 0);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)moveWithPan:(UIPanGestureRecognizer *)pan
{
    static CGFloat offsetX = 0;
    static CGAffineTransform transform;
    if (pan.state == UIGestureRecognizerStateBegan) {
        transform = self.view.transform;
        offsetX = 0;
    }else if (pan.state == UIGestureRecognizerStateChanged)
    {
        CGPoint  point = [pan translationInView:pan.view];
        offsetX = point.x;
        if (point.x >= 0) {
             self.view.transform = CGAffineTransformTranslate(transform, point.x, 0);
        }
    }else if(pan.state == UIGestureRecognizerStateEnded||pan.state == UIGestureRecognizerStateFailed)
    {
        
        if(offsetX >= self.view.bounds.size.width*0.4)
        {
            [UIView animateWithDuration:0.4 animations:^{
                self.view.transform = CGAffineTransformMakeTranslation(_frame.size.width, 0);
            } completion:^(BOOL finished) {
                [_blackBottom removeFromSuperview];
                [bottomView removeFromSuperview];
            }];
        }else{
            [UIView animateWithDuration:0.4 animations:^{
                self.view.transform = CGAffineTransformMakeTranslation(0, 0);
            } completion:^(BOOL finished) {
                if (_showBlackBottom) {
                    [bottomView addSubview:_blackBottom];
                }else{
                    [_parentView addSubview:_blackBottom];
                }
            }];
        }
    }
}

@end
