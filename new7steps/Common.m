//
//  Common.m
//  iUnRewards
//
//  Created by вадим on 11/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Common.h"
#import "XMLParser.h"
#import "Step.h"
#import "Ingridient.h"

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
//        favrecipes = [[NSMutableArray alloc] init];

        self.cats = [[NSMutableDictionary alloc] init];
        
        
        NSArray* sp = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString* docpath = [sp objectAtIndex: 0];
        NSString* favPath = [docpath stringByAppendingPathComponent:@"favourites.plist"];
        NSString* spsPath = [docpath stringByAppendingPathComponent:@"spisok.plist"];

        favs = [[NSMutableArray alloc] initWithContentsOfFile:favPath];
        if(favs == nil)
            favs = [[NSMutableArray alloc] init];

        sps = [[NSMutableArray alloc] initWithContentsOfFile:spsPath];
        if(sps == nil)
            sps = [[NSMutableArray alloc] init];

//        self.spsingrids = [[NSMutableDictionary alloc] initWithContentsOfFile:spsPath];
//        if(self.spsingrids == nil)
//            self.spsingrids = [[NSMutableDictionary alloc] init];
        

	}
	return self;	
}

//- (void) saveSpisokIngrids {
//
//    NSArray* sp = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString* docpath = [sp objectAtIndex: 0];
//    NSString* spsPath = [docpath stringByAppendingPathComponent:@"spisok.plist"];
//
//    BOOL b = [self.spsingrids writeToFile:spsPath atomically:YES];
//    NSLog(@"Spisok ingrids saved PATH = %@, result = %d", spsPath, b);
//
//}

- (void)clearRecipes {
    
    [recipes removeAllObjects];
}

- (void)addRecipe: (Item*)item {
    
    [recipes addObject:item];
    NSLog(@"Recipe added, title: %@", item.name);
}

- (int) getFavRecipeCnt {
    
    return favs.count;
}

- (void) delFavRecipe: (int) i {

    NSArray* sp = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* docpath = [sp objectAtIndex: 0];
    NSString* favPath = [docpath stringByAppendingPathComponent:@"favourites.plist"];

    NSMutableIndexSet *itemsToRemove = [NSMutableIndexSet new];
    [itemsToRemove addIndex:i];
    [favs removeObjectsAtIndexes:itemsToRemove];
    
    BOOL b = [favs writeToFile:favPath atomically:YES];

    NSLog(@"Recipe deleted from favourites, result = %d", b);

}

- (Item*) getFavRecipe: (int) i {
    
    NSDictionary* obj = [favs objectAtIndex:i];
    Item* it = [[Item alloc] init];
    it.name = [obj objectForKey:@"Name"];
    it.image = [obj objectForKey:@"Image"];
    it.ingrid_image = [obj objectForKey:@"IngridImage"];
    it.category = [[obj objectForKey:@"Category"] intValue];
    it.type = [obj objectForKey:@"Type"];
    it.time = [obj objectForKey:@"Time"];
    it.calories = [obj objectForKey:@"Calories"];
    it.proteins = [obj objectForKey:@"Proteins"];
    it.fats = [obj objectForKey:@"Fats"];
    it.carbos = [obj objectForKey:@"Carbos"];
//    it.ingrids = [obj objectForKey:@"Ingrids"];
    it.ingrids_checked = [obj objectForKey:@"Ingrids_checked"];

    NSMutableArray* name = [obj objectForKey:@"Ingridients_name"];
    NSMutableArray* text1 = [obj objectForKey:@"Ingridients_text"];
    for (int i = 0; i < name.count; i++) {
        
        Ingridient* s = [[Ingridient alloc] init];
        s.name = [name objectAtIndex:i];
        s.text = [text1 objectAtIndex:i];
        
        [it.ingrids addObject:s];
    }

    NSMutableArray* path = [obj objectForKey:@"Steps_path"];
    NSMutableArray* text = [obj objectForKey:@"Steps_text"];
    for (int i = 0; i < path.count; i++) {
        
        Step* s = [[Step alloc] init];
        s.path = [path objectAtIndex:i];
        s.text = [text objectAtIndex:i];
        
        [it.steps addObject:s];
    }

    return it;
}

- (void) addFavRecipe: (Item*)item {

    NSArray* sp = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* docpath = [sp objectAtIndex: 0];
    NSString* favPath = [docpath stringByAppendingPathComponent:@"favourites.plist"];

//    [self.favrecipes addObject:item];

    NSMutableArray* name = [[NSMutableArray alloc] init];
    NSMutableArray* text1 = [[NSMutableArray alloc] init];
    for (Ingridient* st in item.ingrids) {
        
        [name addObject:st.name];
        [text1 addObject:st.text];
    }

    NSMutableArray* path = [[NSMutableArray alloc] init];
    NSMutableArray* text = [[NSMutableArray alloc] init];
    for (Step* st in item.steps) {
        
        [path addObject:st.path];
        [text addObject:st.text];
    }

    NSDictionary *f = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects:

                                                            item.name == nil?@"":item.name,
                                                            item.image == nil?@"":item.image,
                                                            item.ingrid_image == nil?@"":item.ingrid_image,
                                                            [NSNumber numberWithInt:item.category],
                                                            item.type == nil?@"":item.type,
                                                            item.time == nil?@"":item.time,
                                                            item.calories == nil?@"":item.calories,
                                                            item.proteins == nil?@"":item.proteins,
                                                            item.fats == nil?@"":item.fats,
                                                            item.carbos == nil?@"":item.carbos,
//                                                            item.ingrids,
                                                            item.ingrids_checked,
                                                            name,
                                                            text1,
                                                            path,
                                                            text,
                                                            nil]
                                                  forKeys:[NSArray arrayWithObjects:
                                                           @"Name",
                                                           @"Image",
                                                           @"IngridImage",
                                                           @"Category",
                                                           @"Type",
                                                           @"Time",
                                                           @"Calories",
                                                           @"Proteins",
                                                           @"Fats",
                                                           @"Carbos",
//                                                           @"Ingrids",
                                                           @"Ingrids_checked",
                                                           @"Ingridients_name",
                                                           @"Ingridients_text",
                                                           @"Steps_path",
                                                           @"Steps_text",
                                                           nil]];

    
    [favs addObject:f];

    BOOL b = [favs writeToFile:favPath atomically:YES];
    NSLog(@"Recipe added to favourites, title: %@, PATH = %@, result = %d", item.name, favPath, b);
}

- (int) getSpsRecipeCnt {
    
    return sps.count;
}

- (void) delSpsRecipe: (int) i {
    
    NSArray* sp = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* docpath = [sp objectAtIndex: 0];
    NSString* spsPath = [docpath stringByAppendingPathComponent:@"spisok.plist"];
    
//    NSDictionary* obj = [sps objectAtIndex:i];
//    [obj setValue:nil forKey:@"Ingrids_checked"];
//    [self saveSpsRecipes];
    
    NSMutableIndexSet *itemsToRemove = [NSMutableIndexSet new];
    [itemsToRemove addIndex:i];
    [sps removeObjectsAtIndexes:itemsToRemove];
    
    BOOL b = [sps writeToFile:spsPath atomically:YES];
    
    NSLog(@"Recipe deleted from Spisok, result = %d", b);
    
}

- (Item*) getSpsRecipe: (int) i {
    
    NSDictionary* obj = [sps objectAtIndex:i];
    Item* it = [[Item alloc] init];
    it.name = [obj objectForKey:@"Name"];
    it.image = [obj objectForKey:@"Image"];
    it.ingrid_image = [obj objectForKey:@"IngridImage"];
    it.category = [[obj objectForKey:@"Category"] intValue];
    it.type = [obj objectForKey:@"Type"];
    it.time = [obj objectForKey:@"Time"];
    it.calories = [obj objectForKey:@"Calories"];
    it.proteins = [obj objectForKey:@"Proteins"];
    it.fats = [obj objectForKey:@"Fats"];
    it.carbos = [obj objectForKey:@"Carbos"];
//    it.ingrids = [obj objectForKey:@"Ingrids"];
    it.ingrids_checked = [obj objectForKey:@"Ingrids_checked"];
    
    NSMutableArray* name = [obj objectForKey:@"Ingridients_name"];
    NSMutableArray* text1 = [obj objectForKey:@"Ingridients_text"];
    for (int i = 0; i < name.count; i++) {
        
        Ingridient* s = [[Ingridient alloc] init];
        s.name = [name objectAtIndex:i];
        s.text = [text1 objectAtIndex:i];
        
        [it.ingrids addObject:s];
    }
    
    NSMutableArray* path = [obj objectForKey:@"Steps_path"];
    NSMutableArray* text = [obj objectForKey:@"Steps_text"];
    for (int i = 0; i < path.count; i++) {
        
        Step* s = [[Step alloc] init];
        s.path = [path objectAtIndex:i];
        s.text = [text objectAtIndex:i];
        
        [it.steps addObject:s];
    }
    
    return it;
}

- (void) saveSpsRecipes {

    NSArray* sp = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* docpath = [sp objectAtIndex: 0];
    NSString* spsPath = [docpath stringByAppendingPathComponent:@"spisok.plist"];

    BOOL b = [sps writeToFile:spsPath atomically:YES];
    NSLog(@"Spisok saved PATH = %@, result = %d", spsPath, b);


}

- (void) addSpsRecipe: (Item*)item {
    
    NSArray* sp = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* docpath = [sp objectAtIndex: 0];
    NSString* spsPath = [docpath stringByAppendingPathComponent:@"spisok.plist"];
    
    NSMutableArray* name = [[NSMutableArray alloc] init];
    NSMutableArray* text1 = [[NSMutableArray alloc] init];
    for (Ingridient* st in item.ingrids) {
        
        [name addObject:st.name];
        [text1 addObject:st.text];
    }
    
    NSMutableArray* path = [[NSMutableArray alloc] init];
    NSMutableArray* text = [[NSMutableArray alloc] init];
    for (Step* st in item.steps) {
        
        [path addObject:st.path];
        [text addObject:st.text];
    }
    
    NSDictionary *f = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects:
                                                            
                                                            item.name == nil?@"":item.name,
                                                            item.image == nil?@"":item.image,
                                                            item.ingrid_image == nil?@"":item.ingrid_image,
                                                            [NSNumber numberWithInt:item.category],
                                                            item.type == nil?@"":item.type,
                                                            item.time == nil?@"":item.time,
                                                            item.calories == nil?@"":item.calories,
                                                            item.proteins == nil?@"":item.proteins,
                                                            item.fats == nil?@"":item.fats,
                                                            item.carbos == nil?@"":item.carbos,
                                                            //                                                            item.ingrids,
                                                            item.ingrids_checked,
                                                            name,
                                                            text1,
                                                            path,
                                                            text,
                                                            nil]
                                                  forKeys:[NSArray arrayWithObjects:
                                                           @"Name",
                                                           @"Image",
                                                           @"IngridImage",
                                                           @"Category",
                                                           @"Type",
                                                           @"Time",
                                                           @"Calories",
                                                           @"Proteins",
                                                           @"Fats",
                                                           @"Carbos",
                                                           //                                                           @"Ingrids",
                                                           @"Ingrids_checked",
                                                           @"Ingridients_name",
                                                           @"Ingridients_text",
                                                           @"Steps_path",
                                                           @"Steps_text",
                                                           nil]];
    
    
    [sps addObject:f];
    
    BOOL b = [sps writeToFile:spsPath atomically:YES];
    NSLog(@"Recipe added to Spisok, title: %@, PATH = %@, result = %d", item.name, spsPath, b);
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
    
    
    NSArray* sp = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* docpath = [sp objectAtIndex: 0];
    NSString* filePath = [docpath stringByAppendingPathComponent:@"xml.txt"];

    NSData* responseData = [NSData dataWithContentsOfFile:filePath];
    
    if((responseData == nil) || [Common instance].langChanged) {

        NSLog(@"No XML data stored");
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:NSLocalizedString(@"URL", nil)]];
        NSHTTPURLResponse* urlResponse = nil;
        NSError *error = nil;//[[NSError alloc] init];
        responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
        //        [error release];
        if (responseData == nil) {
            // Check for problems
            if (error != nil) {
                
                UIAlertView* dialog = [[UIAlertView alloc] init];
                [dialog setTitle:@"Ошибка Интернет-подключения"];
//                [dialog setMessage:[error localizedDescription]];
                [dialog setMessage:@"Данные будут загружены из локальной копии"];
                [dialog addButtonWithTitle:@"OK"];
                [dialog show];
    //            [dialog release];
//                return NO;
            }
        }
        
    }
    else {

        NSLog(@"Stored XML data is loaded");

    }
    
    if(responseData != nil) {
        
        [responseData writeToFile:filePath atomically:YES];
        [Common instance].langChanged = NO;
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

- (UIImage*) getImage: (NSString*) name {
    
//    NSString* n = [name lastPathComponent];
    NSString* n1 = [name stringByReplacingOccurrencesOfString:@":" withString:@"-"];//[tr.url lastPathComponent];
    NSString* n = [n1 stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
//    NSLog(@"url = %@", n);

    NSArray* sp = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* docpath = [sp objectAtIndex: 0];
    NSString* filePath = [docpath stringByAppendingPathComponent:n];
//    NSLog(@"filepath for image = %@", filePath);
    UIImage* im = [UIImage imageWithContentsOfFile:filePath];
//    if(im != nil)
//        NSLog(@"Local image found: %@", filePath);

//    if(im == nil) {
//
//        im = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:name]]];
//        NSData *imgData = UIImagePNGRepresentation(im);
//        [imgData writeToFile:filePath atomically:YES];
//    }
    return im;

}

//- (UIImage*) getImageForStep: (NSString*) name {
//    
//    NSString* n = [name lastPathComponent];
//    NSArray* sp = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString* docpath = [sp objectAtIndex: 0];
//    NSString* filePath = [docpath stringByAppendingPathComponent:n];
//    //    NSLog(@"filepath for image = %@", filePath);
//    UIImage* im = [UIImage imageWithContentsOfFile:filePath];
//    if(im == nil) {
//
//        im = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:name]]];
//        NSData *imgData = UIImagePNGRepresentation(im);
//        [imgData writeToFile:filePath atomically:YES];
//    }
//    return im;
//    
//}


@end
