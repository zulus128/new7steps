//
//  Common.m
//  iUnRewards
//
//  Created by вадим on 11/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Common.h"
#import "XMLParser.h"

@implementation Common


+ (Common*) instance  {
	
	static Common* instance;
	
	@synchronized(self) {
		
		if(!instance) {
			
			instance = [[Common alloc] init];
		}
	}
	return instance;
}

- (id) init{	
	
	self = [super init];
	if(self !=nil) {
        
        recipes = [[NSMutableArray alloc] init];

	}
	return self;	
}

- (void)clearRecipes {
    
    [recipes removeAllObjects];
}

- (void)addRecipe: (Item*)item {
    
    [recipes addObject:item];
    NSLog(@"Recipe added, title: %@", item.name);
}

- (int) getRecipesCount {
    
    return [recipes count];
}

- (int) getMaxCategory {
    
    int m = 0;
    for (Item* i in recipes)
        if(i.category > m)
            m = i.category;
    
    return m;
}

- (int) getMaxRecipesForCategory:(int) cat {
    
    int m = 0;
    for (Item* i in recipes)
        if(i.category == cat)
            m++;
    
    return m;
}

- (Item*) getRecipe: (int) num forCategory:(int) cat {
    
    int m = 0;
    Item* r = nil;
    for (Item* i in recipes)
        if(i.category == cat) {
            m++;
            if(m == num) {
                r = i;
                break;
            }
        }
    
    return r;
}

- (Item*) getRecipeAt: (int)num {
    
    return [recipes objectAtIndex:num];
}

- (BOOL)addRecipes {
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    [request setURL:[NSURL URLWithString:XML_URL]];
    [request setURL:[NSURL URLWithString:NSLocalizedString(@"URL", nil)]];
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = nil;//[[NSError alloc] init];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    //        [error release];
    if (responseData == nil) {
        // Check for problems
        if (error != nil) {
            
            UIAlertView* dialog = [[UIAlertView alloc] init];
            [dialog setTitle:@"Ошибка Интернет-подключения"];
            [dialog setMessage:[error localizedDescription]];
            [dialog addButtonWithTitle:@"OK"];
            [dialog show];
//            [dialog release];
            return NO;
        }
    }
    
    BOOL success = YES;
    
    for (int i = 0; i < 5; i++) {
        
        //    NSString *myStr = [[NSString alloc] initWithData:responseData encoding:NSWindowsCP1251StringEncoding];
        //    myStr = [myStr stringByReplacingOccurrencesOfString:@"encoding=\"windows-1251\"" withString:@""];
        //    NSData* aData = [myStr dataUsingEncoding:NSUTF8StringEncoding];
        
        NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:responseData/*aData*/];
        XMLParser* parser = [[XMLParser alloc] initXMLParser:TYPE_RECIPE];
        [xmlParser setDelegate:parser];    
        
        success = [xmlParser parse];	
        
        if(success) {
            
            NSLog(@"Recipes - No Errors");
            //            [self.tableView reloadData];
            break;
        }
        else {
            
            //NSLog(@"Error! Possibly xml version is not new");
            NSLog(@"Recipes - Parser error: %@", [[xmlParser parserError] localizedDescription]);
            success = NO;
            //return NO;
        }
    }
    
    return success;
}


@end
