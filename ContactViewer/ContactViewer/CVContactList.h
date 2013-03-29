//
//  CVContactList.h
//  ContactViewer
//
//  Created by Kevin Hopps on 3/9/13.
//  Copyright (c) 2013 MSSE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CVContact.h"

@interface CVContactList : NSObject <NSCoding>

-(id)initWithCapacity:(NSInteger)capacity;

-(NSInteger)count;

-(CVContact*)contactAtIndex:(NSInteger)index;

-(void)addContact:(CVContact*)contact;

-(void)encodeWithCoder:(NSCoder *)aCoder;

-(id)initWithCoder:(NSCoder *)aDecoder;

@property(strong) NSMutableArray* allContacts;

@end
