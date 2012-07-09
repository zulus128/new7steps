//
//  Common.h
//  iUnRewards
//
//  Created by вадим on 11/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"

#define XML_URL @"http://customs.joomsport.com/7steps/index.php?option=com_recipes"

#define RECIPE_TAG @"recipe"
#define NAME_TAG @"name"
#define IMAGE_TAG @"image"

enum item_types {
    
    TYPE_NONE,
    TYPE_RECIPE
};

@interface Common : NSObject <UITabBarControllerDelegate> {
    
    NSMutableArray* recipes;

}

+ (Common*) instance;

- (void)clearRecipes;
- (void)addRecipe: (Item*)item;
- (int) getRecipesCount;
- (Item*) getRecipeAt: (int)num;
- (BOOL)addRecipes;

@end
