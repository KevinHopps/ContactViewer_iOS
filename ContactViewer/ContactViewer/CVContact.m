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
    
    return self;    
}

@end
