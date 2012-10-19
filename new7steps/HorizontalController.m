//
//  HorizontalController.m
//  new7steps
//
//  Created by Zul on 10/19/12.
//
//

#import "HorizontalController.h"
#import "Common.h"
#import "Step.h"
#import "StepViewController.h"

@interface HorizontalController ()

@end

@implementation HorizontalController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl
        navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    
    screenBounds = [[UIScreen mainScreen] bounds];
//    NSLog(@"screenBounds w = %f, h = %f", screenBounds.size.width, screenBounds.size.height);
    
    int i = [Common instance].itemtag / CAT_MULT;
    int j = [Common instance].itemtag - i * CAT_MULT;

    it = [[Common instance] getRecipe:j forCategory:i];
    index = 0;
//    NSMutableArray *viewControllers = [NSMutableArray array];
//    int k = 1;
//    for (Step* st in it.steps) {
//        
//        UIImageView *imgView8 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 480, 320)];
//        imgView8.image = [UIImage imageNamed:[NSString stringWithFormat:@"step_%d.png", k++]];
//        UIViewController *controller = [[UIViewController alloc] init];
//        controller.view = imgView8;
//        [viewControllers addObject:controller];
//    }
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES animated:NO];
    
    NSMutableArray *viewControllers = [NSMutableArray array];

    Step* s = [it.steps objectAtIndex:index];
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:screenBounds];
    UIImage* iii = [[Common instance] getImage:s.path];
    if(iii != nil) {
        
        NSLog(@"Step image found %@", s.path);
        imgV.image = iii;
    }
    else {
        
        NSData* imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:s.path]];
        imgV.image = [[UIImage alloc] initWithData:imageData];
    }
  
    UIViewController *controller = [[UIViewController alloc] init];
    controller.view = imgV;
    [viewControllers addObject:controller];

    [self.pageViewController setViewControllers:viewControllers
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:nil];
    [self.view addSubview:self.pageViewController.view];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    if(index < 1)
        return nil;
    index--;
    
    NSLog(@"indexBefore = %d", index);

    Step* s = [it.steps objectAtIndex:index];
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:screenBounds];
    UIImage* iii = [[Common instance] getImage:s.path];
    if(iii != nil) {
        
        NSLog(@"Step image found %@", s.path);
        imgV.image = iii;
    }
    else {
        
        NSData* imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:s.path]];
        imgV.image = [[UIImage alloc] initWithData:imageData];
    }
    
    UIViewController *controller = [[UIViewController alloc] init];
    controller.view = imgV;
    return controller;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {

    if(index >= (it.steps.count -1))
        return nil;
    index++;
    
    NSLog(@"indexAfter = %d", index);
    
    Step* s = [it.steps objectAtIndex:index];
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:screenBounds];
    UIImage* iii = [[Common instance] getImage:s.path];
    if(iii != nil) {
        
        NSLog(@"Step image found %@", s.path);
        imgV.image = iii;
    }
    else {
    
        NSData* imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:s.path]];
        imgV.image = [[UIImage alloc] initWithData:imageData];
    }
    
    UIViewController *controller = [[UIViewController alloc] init];
    controller.view = imgV;
    return controller;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
