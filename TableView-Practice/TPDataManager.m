//
//  TPDataManager.m
//  TableView-Practice
//
//  Created by Shoya Ishimaru on 2014/08/27.
//  Copyright (c) 2014年 shoya140. All rights reserved.
//

#import "TPDataManager.h"
#import "TPItem.h"

static TPDataManager *_sharedmanager = nil;

@implementation TPDataManager

+ (instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedmanager = [[TPDataManager alloc] init];
    });
    return _sharedmanager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithBool:NO], @"launched",
                                        nil]];
        [userDefaults synchronize];
    }
    return self;
}

- (void)setLaunched:(BOOL)launched
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:launched forKey:@"launched"];
    [userDefaults synchronize];
}

- (BOOL)launched
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults boolForKey:@"launched"];
}

- (void)resetData
{
    UIImage *sampleImage = [UIImage imageNamed:@"blank.png"];
    NSString *imageFilePath = [NSString stringWithFormat:@"%@/sample.jpg",[self documentsDirectory]];
    [UIImageJPEGRepresentation(sampleImage, 1.0f) writeToFile:imageFilePath atomically:YES];
    
    [TPItem MR_truncateAll];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    NSArray *sampleItems = @[
                             @{@"title": @"sample",
                               @"imagePath": imageFilePath},
                             ];
    for (NSDictionary *sampleItem in sampleItems) {
        TPItem *item = [TPItem MR_createEntity];
        item.title = [sampleItem objectForKey:@"title"];
        item.imagePath = [sampleItem objectForKey:@"imagePath"];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    }
}

- (NSString *)documentsDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

@end
