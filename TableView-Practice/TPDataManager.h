//
//  TPDataManager.h
//  TableView-Practice
//
//  Created by Shoya Ishimaru on 2014/08/27.
//  Copyright (c) 2014年 shoya140. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPDataManager : NSObject

@property (nonatomic, assign) BOOL launched;

+ (instancetype)sharedManager;
- (void)resetData;
- (NSString *)documentsDirectory;

@end
