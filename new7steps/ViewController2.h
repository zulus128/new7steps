//
//  ViewController2.h
//  new7steps
//
//  Created by вадим on 7/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"

@interface ViewController2 : UIViewController {
    
    Item* it;
    UIImageView *imgView2;
    UIImageView *imgView2_1;
    BOOL b;
    NSOperationQueue *queue;
}

@property (readwrite, assign) int itemtag;
@property (nonatomic, retain) IBOutlet UIScrollView* vertScrollView2;
@property (nonatomic, retain) IBOutlet UIScrollView* vertScrollView3;

- (IBAction) exit;
- (void)buttonEvent:(id)sender;

@end
