//
//  CVEditViewController.m
//  ContactViewer
//
//  Created by Kevin Hopps on 3/18/13.
//  Copyright (c) 2013 MSSE. All rights reserved.
//

#import "CVEditViewController.h"

@interface CVEditViewController ()
{
    BOOL canceled;
}

@end

@implementation CVEditViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self registerForKeyboardNotifications];
        self.title = NSLocalizedString(@"Edit", @"Edit");
        self.original = [[CVContact alloc] initWithName:@"" andPhone:@"" andTitle:@"" andEmail:@"" andTwitterId:@""];
        //[self.navigationItem.leftBarButtonItem setAction:@selector(saveItems:)];
        canceled = NO;
    }
    return self;
}

-(void) saveItems:(id)sender
{
	self.contact.name = self.nameData.text;
	self.contact.title = self.titleData.text;
	self.contact.phone = self.phoneData.text;
	self.contact.email = self.emailData.text;
	self.contact.twitterId = self.twitterIDData.text;
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(doCancel)];
    self.navigationItem.rightBarButtonItem = cancelButton;

    self.nameData.delegate = self;
    self.titleData.delegate = self;
    self.phoneData.delegate = self;
    self.emailData.delegate = self;
    self.twitterIDData.delegate = self;
    
    [self loadFromContact];
    
}

-(void)doCancel
{
    self.contact.name = self.original.name;
    self.contact.title = self.original.title;
    self.contact.phone = self.original.phone;
    self.contact.email = self.original.email;
    self.contact.twitterId = self.original.twitterId;
    
    canceled = YES;
    self.contact.isNew = YES;
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self loadFromContact];
}

- (void)loadFromContact
{
    canceled = NO;
    self.contact.isNew = NO;
    
    self.nameData.text = self.contact.name;
    self.titleData.text = self.contact.title;
    self.phoneData.text = self.contact.phone;
    self.emailData.text = self.contact.email;
    self.twitterIDData.text = self.contact.twitterId;
    
    self.original.name = self.contact.name;
    self.original.title = self.contact.title;
    self.original.phone = self.contact.phone;
    self.original.email = self.contact.email;
    self.original.twitterId = self.contact.twitterId;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Check this link for how to move text fields into view:
// http://developer.apple.com/library/ios/#documentation/StringsTextFonts/Conceptual/TextAndWebiPhoneOS/KeyboardManagement/KeyboardManagement.html#//apple_ref/doc/uid/TP40009542-CH5-SW1

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
//    UIAlertView *someError = [[UIAlertView alloc] initWithTitle: @"Howdy" message: @"in textFieldDidBeginEditing" delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
//    [someError show];
    //[self animateTextField: textField up: YES];
    
    self.activeField = textField;
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    //[self animateTextField: textField up: NO];

    if (!canceled)
    {
        if (textField == self.nameData)
            self.contact.name = textField.text;
        else if (textField == self.titleData)
            self.contact.title = textField.text;
        else if (textField == self.phoneData)
            self.contact.phone = textField.text;
        else if (textField == self.emailData)
            self.contact.email = textField.text;
        else if (textField == self.twitterIDData)
            self.contact.twitterId = textField.text;        
    }

    self.activeField = nil;
}

/*
- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 80; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

- (void)keyboardWasShown:(NSNotification*)aNotification {
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGRect bkgndRect = self.activeField.superview.frame;
    bkgndRect.size.height += kbSize.height;
    [self.activeField.superview setFrame:bkgndRect];
    [self.scrollView setContentOffset:CGPointMake(0.0, self.activeField.frame.origin.y-kbSize.height) animated:YES];
}
 */

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, self.activeField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, self.activeField.frame.origin.y-kbSize.height);
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

@end
