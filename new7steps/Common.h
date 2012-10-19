//
//  Common.h
//  iUnRewards
//
//  Created by вадим on 11/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"

//#define XML_URL @"http://customs.joomsport.com/7steps/index.php?option=com_recipes"

#define RECIPE_TAG @"recipe"
#define RECIPES_TAG @"recipes"
#define NAME_TAG @"name"
#define IMAGE_TAG @"image"
#define INGRID_IMAGE_TAG @"ingridients_image"
#define INGRIDS_TAG @"ingridients"
#define QUANTITY_TAG @"quantity"
#define CATEGORY_TAG @"category"
#define TYPE_TAG @"type"
#define TIME_TAG @"cooking_time"
#define CALORIES_TAG @"calories"
#define PROTEINS_TAG @"proteins"
#define FATS_TAG @"fats"
#define CARBO_TAG @"carbohydrates"
#define STEPS_TAG @"steps"
#define DESCRIPTION_TAG @"description"

#define CAT_MULT 10000

#define FIRSTLOAD_IMAGES_CNT 4

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
- (int) getMaxCategory;
- (int) getMaxRecipesForCategory:(int) cat;
- (Item*) getRecipe: (int) num forCategory:(int) cat;
- (UIImage*) getImage: (NSString*) name;

@property (nonatomic, retain) NSMutableDictionary* cats;
//@property (assign) BOOL again;
@property (assign) BOOL langChanged;
@property (assign) double versionXML;

@property (readwrite, assign) int itemtag;

@end
