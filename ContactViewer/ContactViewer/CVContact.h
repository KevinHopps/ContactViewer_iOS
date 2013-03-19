//
//  CVContact.h
//  ContactViewer
//
//  Created by Kevin Hopps on 3/9/13.
//  Copyright (c) 2013 MSSE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CVContact : NSObject

@property(strong) NSString* name;
@property(strong) NSString* phone;
@property(strong) NSString* title;
@property(strong) NSString* email;
@property(strong) NSString* twitterId;


-(id)initWithName:(NSString*)name
         andPhone:(NSString*)phone
         andTitle:(NSString*)title
         andEmail:(NSString*)email
     andTwitterId:(NSString*)twitterId;

@end
