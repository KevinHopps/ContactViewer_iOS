//
//  CVContactList.m
//  ContactViewer
//
//  Created by Kevin Hopps on 3/9/13.
//  Copyright (c) 2013 MSSE. All rights reserved.
//

#import "CVContactList.h"

static CVContactList* _singleton = nil;

@implementation CVContactList

+(void)initSingleton {
    _singleton = [[CVContactList alloc] initWithCapacity:4];
    
    [_singleton addContact:[[CVContact alloc] initWithName:@"Malcom Reynolds"
                                                andPhone:@"612-555-1234"
                                                andTitle:@"Captain"
                                                andEmail:@"mal@serenity.com"
                                                andTwitterId:@"malcomreynolds"]];
    [_singleton addContact:[[CVContact alloc] initWithName:@"Zoe Washburne"
                                                andPhone:@"612-555-5678"
                                                andTitle:@"First Mate"
                                                andEmail:@"zoe@serenity.com"
                                                andTwitterId:@"zoewashburne"]];
    [_singleton addContact:[[CVContact alloc] initWithName:@"Hoban Washburne"
                                                andPhone:@"612-555-9012"
                                                andTitle:@"Pilot"
                                                andEmail:@"wash@serenity.com"
                                                andTwitterId:@"wash"]];
    [_singleton addContact:[[CVContact alloc] initWithName:@"Jayne Cobb"
                                                andPhone:@"612-555-1234"
                                                andTitle:@"Muscle"
                                                andEmail:@"jayne@serenity.com"
                                                andTwitterId:@"heroofcanton"]];
    [_singleton addContact:[[CVContact alloc] initWithName:@"Kaylee Frye"
                                                andPhone:@"612-555-7890"
                                                andTitle:@"Engineer"
                                                andEmail:@"kaylee@serenity.com"
                                                andTwitterId:@"kaylee"]];
    [_singleton addContact:[[CVContact alloc] initWithName:@"Simon Tam"
                                                andPhone:@"612-555-4321"
                                                andTitle:@"Doctor"
                                                andEmail:@"simon@serenity.com"
                                                andTwitterId:@"simontam"]];
    [_singleton addContact:[[CVContact alloc] initWithName:@"River Tam"
                                                andPhone:@"612-555-8765"
                                                andTitle:@"Doctor's Sister"
                                                andEmail:@"river@serenity.com"
                                                andTwitterId:@"miranda"]];
    [_singleton addContact:[[CVContact alloc] initWithName:@"Shepherd Book"
                                                andPhone:@"612-555-2109"
                                                andTitle:@"Shepherd"
                                                andEmail:@"shepherd@serenity.com"
                                                andTwitterId:@"shepherdbook"]];
}

+(CVContactList*)singleton {
    return _singleton;
}

-(id)initWithCapacity:(NSInteger)capacity {
    self = [super init];

    self.allContacts = [[NSMutableArray alloc] initWithCapacity:capacity];
    
    return self;
}

-(NSInteger)count {
    return [self.allContacts count];
}

-(CVContact*)contactAtIndex:(NSInteger)index {
    return [self.allContacts objectAtIndex:index];
}

-(void)addContact:(CVContact *)contact {
    [self.allContacts addObject:contact];
}

@end
