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
 
    BOOL sl = [[NSUserDefaults standardUserDefaults] boolForKey:@"sleep"];
    [UIApplication sharedApplication].idleTimerDisabled = sl;

    BOOL ab = [[NSUserDefaults standardUserDefaults] boolForKey:@"clearcache"];
    
    if(ab) {
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"clearcache"];
        
        NSArray* sp = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString* documentsDirectory = [sp objectAtIndex: 0];

        NSFileManager *fileMgr = [[NSFileManager alloc] init];
        NSError *error = nil;
        NSArray *directoryContents = [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:&error];
        if (error == nil) {
            for (NSString *path in directoryContents) {
                NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:path];
                BOOL removeSuccess = [fileMgr removeItemAtPath:fullPath error:&error];
                if (!removeSuccess) {
                    // Error handling
                    NSLog(@"Cache Delete error");
                }
            }
        } else {
            // Error handling
            NSLog(@"Cache Delete error 1");
        }
    }
    
    int l = [[NSUserDefaults standardUserDefaults] integerForKey:@"language"];

    NSLog(@"lang = %d", l); //

    switch (l) {
        case 0: {
            NSString* def = [[NSUserDefaults standardUserDefaults] stringForKey:@"deflang"];
            NSLog(@"deflang = %@", def); //
            NSString* dLanguage = [[NSLocale preferredLanguages] objectAtIndex:0];
            NSLog(@"dLanguage = %@", dLanguage); //
//            if((def != nil) && (![def isEqualToString:dLanguage])) {
//
//                def = nil;
//            }
            if(def == nil) {
            
                def = dLanguage;
                [[NSUserDefaults standardUserDefaults] setObject:dLanguage forKey:@"deflang"];
                NSLog(@"store deflang = %@", dLanguage); //
            }
//            else {

//                def = dLanguage;
                [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:def, nil]
                                                          forKey:@"AppleLanguages"];
                [[NSUserDefaults standardUserDefaults] synchronize];
//            }

            break;
        }
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
