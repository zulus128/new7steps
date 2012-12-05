//
//  KonkursViewController.h
//  new7steps
//
//  Created by вадим on 11/23/12.
//
//

#import <UIKit/UIKit.h>

@interface KonkursViewController : UIViewController

- (IBAction) back;
@property (nonatomic, retain) IBOutlet UILabel* titleLabel;
@property (nonatomic, retain) IBOutlet UIScrollView* vertScrollView;
@property (nonatomic, retain) IBOutlet UIButton* goRecipes;
@property (nonatomic, retain) IBOutlet UITextView* link1;


@end
