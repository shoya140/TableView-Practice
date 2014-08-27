//
//  Item.h
//  TableView-Practice
//
//  Created by Shoya Ishimaru on 2014/08/27.
//  Copyright (c) 2014年 shoya140. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TPItem : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * imagePath;

@end
