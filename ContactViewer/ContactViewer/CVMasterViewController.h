//
//  CVMasterViewController.h
//  ContactViewer
//
//  Created by Kevin Hopps on 3/9/13.
//  Copyright (c) 2013 MSSE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CVContactList.h"

@class CVDetailViewController;

@interface CVMasterViewController : UITableViewController

@property (strong, nonatomic) CVDetailViewController *detailViewController;

@property (strong, nonatomic) CVContactList* contacts;

-(void)storeContacts;

@end
