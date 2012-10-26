//
//  FavViewController.h
//  new7steps
//
//  Created by Zul on 10/23/12.
//
//

#import <UIKit/UIKit.h>

@interface FavViewController : UIViewController

@property (nonatomic, retain) IBOutlet UILabel* titleLabel;
@property (nonatomic, retain) IBOutlet UIButton* goRecipes;
@property (nonatomic, retain) IBOutlet UIScrollView* vertScrollView;
- (IBAction) exit;

@end
