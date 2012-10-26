//
//  ViewController.h
//  new7steps
//
//  Created by вадим on 4/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIScrollViewDelegate> {
    
//    NSMutableDictionary* favs;
    BOOL panelhide;
    CGRect f;
    int buttag;
    BOOL again;
    NSOperationQueue *queue;
    UIActivityIndicatorView *sIndicator;
    UIImageView *sView;
}

@property (nonatomic, retain) IBOutlet UIScrollView* vertScrollView;
@property (nonatomic, retain) NSString* filePath;
//@property (nonatomic, retain) IBOutlet UIButton* panelbut;
@property (nonatomic, retain) IBOutlet UILabel* titleLabel;


- (IBAction)panelButtonClick:(id)sender;
- (void)refreshImages: (UIView*) scroll cnt1:(int) cnt1 cat:(int)i;

@property (nonatomic, retain) IBOutlet UIView* panel1;
@property (nonatomic, retain) NSMutableDictionary* imgdict;

@end
