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
}

@property (nonatomic, retain) IBOutlet UIScrollView* vertScrollView;
@property (nonatomic, retain) NSString* filePath;


@end
