//
//  CVEditViewController.h
//  ContactViewer
//
//  Created by Kevin Hopps on 3/18/13.
//  Copyright (c) 2013 MSSE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CVContact.h"

@interface CVEditViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) CVContact* contact;
@property (strong, nonatomic) CVContact* original;
@property (weak, nonatomic) IBOutlet UITextField *nameData;
@property (weak, nonatomic) IBOutlet UITextField *titleData;
@property (weak, nonatomic) IBOutlet UITextField *phoneData;
@property (weak, nonatomic) IBOutlet UITextField *emailData;
@property (weak, nonatomic) IBOutlet UITextField *twitterIDData;
@property (strong, nonatomic) UITextField* activeField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
