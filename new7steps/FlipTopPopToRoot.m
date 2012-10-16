//
//  FlipTopPopToRoot.m
//  new7steps
//
//  Created by Zul on 10/15/12.
//
//

#import "FlipTopPopToRoot.h"

@implementation FlipTopPopToRoot

- (void) perform {
    
    UIViewController *src = (UIViewController *) self.sourceViewController;
    [UIView transitionWithView:src.navigationController.view duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromTop
                    animations:^{
                        [src.navigationController popToViewController:[src.navigationController.viewControllers objectAtIndex:0] animated:NO];;
                    }
                    completion:NULL];
}

@end
