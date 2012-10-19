//
//  HorizontalController.h
//  new7steps
//
//  Created by Zul on 10/19/12.
//
//

#import <UIKit/UIKit.h>

@interface HorizontalController : UIViewController {
    
    BOOL isShowingLandscapeView;
}

@property (nonatomic, retain) IBOutlet UIScrollView* horizScrollView;

@end
