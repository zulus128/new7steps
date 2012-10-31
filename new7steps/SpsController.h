//
//  SpsController.h
//  new7steps
//
//  Created by Zul on 10/30/12.
//
//

#import <UIKit/UIKit.h>

@interface SpsController : UIViewController {
    
//    UIImageView *polosa;
}

@property (nonatomic, retain) IBOutlet UILabel* titleLabel;
@property (nonatomic, retain) IBOutlet UIButton* goRecipes;
@property (nonatomic, retain) IBOutlet UIScrollView* vertScrollView;

- (IBAction) exit;

@end
