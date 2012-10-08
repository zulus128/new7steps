//
//  main.m
//  new7steps
//
//  Created by вадим on 4/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "Common.h"

int main(int argc, char *argv[])
{
 
    int l = [[NSUserDefaults standardUserDefaults] integerForKey:@"language"];

    NSLog(@"lang = %d", l); //

    switch (l) {
        case 0:
            break;
        case 1:
            [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:@"en_US", nil]
                                                      forKey:@"AppleLanguages"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            break;
        case 2:
            [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:@"de_DE", nil]
                                                      forKey:@"AppleLanguages"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            break;
        case 3:
            [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:@"ru_RU", nil]
                                                      forKey:@"AppleLanguages"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            break;
        case 4:
            [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:@"es_ES", nil]
                                                      forKey:@"AppleLanguages"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            break;
            
        default:
            break;
    }

    NSString * langu = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSString* prev = [[NSUserDefaults standardUserDefaults] stringForKey:@"curlang"];
    NSLog(@"Cur lang = %@, Prev lang = %@", langu, prev);
    [Common instance].langChanged = ![langu isEqualToString:prev];
    [[NSUserDefaults standardUserDefaults] setObject:langu forKey:@"curlang"];
    
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
