//
//  CVDetailViewController.h
//  ContactViewer
//
//  Created by Kevin Hopps on 3/9/13.
//  Copyright (c) 2013 MSSE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CVEditViewController.h"
#import "CVContact.h"

@interface CVDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) CVContact* contact;
@property (strong, nonatomic) CVEditViewController *editViewController;

@property (weak, nonatomic) IBOutlet UILabel *nameData;
@property (weak, nonatomic) IBOutlet UILabel *titleData;
@property (weak, nonatomic) IBOutlet UILabel *phoneData;
@property (weak, nonatomic) IBOutlet UILabel *emailData;

@property (weak, nonatomic) IBOutlet UILabel *twitterIDData;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
