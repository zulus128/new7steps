//
//  AboutController.h
//  new7steps
//
//  Created by Zul on 9/25/12.
//
//

#import <UIKit/UIKit.h>

@interface AboutController : UIViewController

@property (nonatomic, retain) IBOutlet UILabel* xmlver;
@property (nonatomic, retain) IBOutlet UILabel* sleepLab;
@property (nonatomic, retain) IBOutlet UISwitch* sleepSw;
@property (nonatomic, retain) IBOutlet UIScrollView* vertScrollView;
@property (nonatomic, retain) IBOutlet UITextView* link1;
@property (nonatomic, retain) IBOutlet UITextView* link2;
@property (nonatomic, retain) IBOutlet UITextView* link3;
@property (nonatomic, retain) IBOutlet UITextView* link4;
@property (nonatomic, retain) IBOutlet UITextView* link5;
@property (nonatomic, retain) IBOutlet UITextView* link6;
@property (nonatomic, retain) IBOutlet UIButton* goRecipes;

- (IBAction) swich;

- (IBAction) back;


@end
