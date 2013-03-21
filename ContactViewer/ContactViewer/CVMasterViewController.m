//
//  CVMasterViewController.m
//  ContactViewer
//
//  Created by Kevin Hopps on 3/9/13.
//  Copyright (c) 2013 MSSE. All rights reserved.
//

#import "CVMasterViewController.h"

#import "CVDetailViewController.h"

#import "CVContactList.h"

@interface CVMasterViewController () {
    NSInteger selectedItem;
}
@end

@implementation CVMasterViewController

@synthesize contacts;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Master", @"Master");
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            self.clearsSelectionOnViewWillAppear = NO;
            self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
        }
        
        // get the contact list
        [CVContactList initSingleton];
        contacts = [CVContactList singleton];
        
        [self loadContacts];
        
        selectedItem = -1;
        
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
}

// This is called when the detail view is popped.
// Since a contact has been updated, we must reload the view's data.
// There might be a way to be smart about this, but for now we just
// reload the entire view's data.
//
- (void)viewDidAppear:(BOOL)animated
{
    [self checkLastItem];
    [self.tableView reloadData];
}

-(void) checkLastItem
{
    NSInteger last = self.contacts.count - 1;
    if (last >= 0)
    {
        CVContact* contact = [self.contacts contactAtIndex:last];
        if (contact.isNew)
        {
            [self.contacts.allContacts removeObjectAtIndex:last];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString*)getStoragePath
{
    NSString* filename = @"contacts.json";
    NSString* filepath = [[NSBundle mainBundle] pathForResource: filename ofType:@""];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* docsPath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    NSString* outputPath = [docsPath stringByAppendingPathComponent:filename ];
    
    return outputPath;
}

- (void)storeContacts
{
    [self checkLastItem];
    NSString* outputPath = [self getStoragePath];
    [NSKeyedArchiver archiveRootObject:contacts toFile:outputPath];
}

- (void)loadContacts
{
    NSString* outputPath = [self getStoragePath];
    contacts = [NSKeyedUnarchiver unarchiveObjectWithFile:outputPath];
}

- (void)insertNewObject:(id)sender
{
    CVContact* contact = [[CVContact alloc] initWithName:@"" andPhone:@"" andTitle:@"" andEmail:@"" andTwitterId:@""];
    NSInteger row = contacts.count;
    [contacts addContact:contact];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

    CVEditViewController* editViewController = [[CVEditViewController alloc] initWithNibName:@"CVEditViewController" bundle:nil];
    editViewController.contact = contact;
    [self.navigationController pushViewController:editViewController animated:YES];
    /*
    if (!self.editViewController)
    {
        self.editViewController = [[CVEditViewController alloc] initWithNibName:@"CVEditViewController" bundle:nil];
    }
    self.editViewController.contact = self.contact;
    [self.navigationController pushViewController:self.editViewController animated:YES];
     */
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return contacts.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }


    CVContact* contact = [contacts contactAtIndex:indexPath.row];
    cell.textLabel.text = contact.name;
    // this is a bit of a hack, but now we don't need to make a custom cell item
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@            %@",
                                 contact.phone, contact.title];

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [contacts.allContacts removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CVContact* contact = [contacts contactAtIndex:indexPath.row];
    selectedItem = indexPath.row;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
	    if (!self.detailViewController) {
	        self.detailViewController = [[CVDetailViewController alloc] initWithNibName:@"CVDetailViewController_iPhone" bundle:nil];
	    }
	    self.detailViewController.detailItem = contact;
        [self.navigationController pushViewController:self.detailViewController animated:YES];
    } else {
        self.detailViewController.detailItem = contact;
    }
}

@end
