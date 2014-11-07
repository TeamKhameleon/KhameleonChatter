//
//  ViewTransitor.m
//  iOS Chatter app
//
//  Created by Alexander Dinkov on 11/7/14.
//  Copyright (c) 2014 Siko. All rights reserved.
//

#import "ViewTransitor.h"

@implementation ViewTransitor

-(instancetype)init {
    self = [super init];
    return self;
}


#pragma mark - UIViewControllerAnimatedTransitioning -

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    if(self.isPresenting){
        [self executePresentationAnimation:transitionContext];
    }
    else{
        [self executeDismissalAnimation:transitionContext];
    }
}

-(void)executePresentationAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIView* inView = [transitionContext containerView];
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [inView addSubview:toViewController.view];
    CGPoint centerOffScreen = inView.center;
    centerOffScreen.y = (-1)*inView.frame.size.height;
    toViewController.view.center = centerOffScreen;
    [UIView animateWithDuration: 1 delay:0.0f usingSpringWithDamping:0.4f initialSpringVelocity:6.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        toViewController.view.center = inView.center;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}


-(void)executeDismissalAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIView* inView = [transitionContext containerView];
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [inView insertSubview:toViewController.view belowSubview:fromViewController.view];
    CGPoint centerOffScreen = inView.center;
    centerOffScreen.y = (-1)*inView.frame.size.height;
    [UIView animateKeyframesWithDuration: 1 delay:0.0f options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.5 animations:^{
            CGPoint center = fromViewController.view.center;
            center.y += 50;
            fromViewController.view.center = center;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations:^{
            fromViewController.view.center = centerOffScreen;
        }];
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end
