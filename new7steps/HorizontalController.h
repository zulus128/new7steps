//
//  HorizontalController.h
//  new7steps
//
//  Created by Zul on 10/19/12.
//
//

#import <UIKit/UIKit.h>
#import "Item.h"

@interface HorizontalController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate> {
    
    BOOL isShowingLandscapeView;

    CGRect screenBounds;
    Item* it;
    int index;
    BOOL left;
}

@property (nonatomic, retain) IBOutlet UIScrollView* horizScrollView;
@property (nonatomic, strong) UIPageViewController *pageViewController;

@end
