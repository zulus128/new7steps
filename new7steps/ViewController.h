//
//  ViewController.h
//  new7steps
//
//  Created by вадим on 4/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    
    NSMutableDictionary* favs;
    BOOL panelhide;
    CGRect f;
    int buttag;
    BOOL again;
    NSOperationQueue *queue;
}

@property (nonatomic, retain) IBOutlet UIScrollView* vertScrollView;
@property (nonatomic, retain) NSString* filePath;
//@property (nonatomic, retain) IBOutlet UIButton* panelbut;
@property (nonatomic, retain) IBOutlet UILabel* titleLabel;


- (IBAction)panelButtonClick:(id)sender;


@property (nonatomic, retain) IBOutlet UIView* panel1;

@end
