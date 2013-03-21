//
//  CVContact.m
//  ContactViewer
//
//  Created by Kevin Hopps on 3/9/13.
//  Copyright (c) 2013 MSSE. All rights reserved.
//

#import "CVContact.h"

@implementation CVContact

-(id)initWithName:(NSString*)name
         andPhone:(NSString*)phone
         andTitle:(NSString*)title
         andEmail:(NSString*)email
     andTwitterId:(NSString*)twitterId {
    
    self = [super init];
    
    self.name = name;
    self.phone = phone;
    self.title = title;
    self.email = email;
    self.twitterId = twitterId;
    
    self.isNew = YES;
    
    return self;    
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.phone forKey:@"phone"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.twitterId forKey:@"twitterId"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.phone = [aDecoder decodeObjectForKey:@"phone"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.email = [aDecoder decodeObjectForKey:@"email"];
        self.twitterId = [aDecoder decodeObjectForKey:@"twitterId"];
        self.isNew = NO;
    }
    
    return self;
}

@end
