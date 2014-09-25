//
//  FBAccountSignInViewController.m
//  Social Network Privacy Management
//
//  Created by Cong Phap Bui on 17/09/2014.
//
//

#import "FBAccountSignInViewController.h"
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
#import "AppDelegate.h"
#import "FBAccount.h"
#import "BasicInformationViewController.h"
>>>>>>> FETCH_HEAD
=======
#import "AppDelegate.h"
#import "FBAccount.h"
#import "BasicInformationViewController.h"
>>>>>>> FETCH_HEAD
=======
#import "AppDelegate.h"
#import "FBAccount.h"
#import "BasicInformationViewController.h"
>>>>>>> FETCH_HEAD

static const int fbTVNumberOfSection = 1;
static const int fbTVNumberOfRowsInSection = 3;
static NSString * const fbTVRowItems[fbTVNumberOfRowsInSection] = {
    @"Basic Information", @"Work Information", @"Education Information" };

static BOOL fbTVDisableItems[fbTVNumberOfRowsInSection] = {TRUE, TRUE,TRUE };

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
static NSString * const fbSubViewClassNames = @"ProfileBuilderViewController";
=======
static NSString * const fbSubViewClassNames = @"BasicInformationViewController";
>>>>>>> FETCH_HEAD
=======
static NSString * const fbSubViewClassNames = @"BasicInformationViewController";
>>>>>>> FETCH_HEAD
=======
static NSString * const fbSubViewClassNames = @"BasicInformationViewController";
>>>>>>> FETCH_HEAD

static NSString * const fbSubViewNames[fbTVNumberOfRowsInSection] = {
    @"BI",@"WI",@"EI"};

@interface FBAccountSignInViewController ()

@property (strong, nonatomic) IBOutlet FBProfilePictureView *profilePicture;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *email;
@property (strong, nonatomic) IBOutlet UILabel *status;
@property (strong, nonatomic) IBOutlet UIButton *info;
@property (strong, nonatomic) IBOutlet FBLoginView *fbLoginView;
@property (strong, nonatomic) IBOutlet UITableView *fbFunction;

@end

@implementation FBAccountSignInViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        NSArray *permissionsNeeded = @[@"public_profile", @"email", @"user_relationships", @"user_work_history", @"user_birthday"];
        
        FBLoginView *loginView = [[FBLoginView alloc] init];
        [loginView setReadPermissions:permissionsNeeded];
        
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
        loginView.delegate = self;
        
        loginView.center = self.view.center;
        
        self.fbLoginView = loginView;
=======
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
        // Set this loginUIViewController to be the loginView button's delegate
        loginView.delegate = self;
        
        // Align the button in the center vertically
        loginView.center = self.view.center;
        
        self.fbLoginView = loginView;
        

<<<<<<< HEAD
<<<<<<< HEAD
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
    }
    return self;
}

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user
{
    self.profilePicture.profileID = [user objectID];
=======
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
// This method will be called when the user information has been fetched
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user
{
    
    self.profilePicture.profileID = [user id];
<<<<<<< HEAD
<<<<<<< HEAD
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
    self.name.text = [user name];
    self.email.text = [user objectForKey:@"email"];
    
    if(FBSession.activeSession.isOpen)
    {
        [self requestWithPermissions];
    }
}

- (void) requestWithPermissions
{
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
    NSArray *permissionsNeeded = @[@"public_profile", @"email", @"user_relationships", @"user_work_history", @"user_birthday", @"user_education_history", @"read_friendlists"];
=======
    NSArray *permissionsNeeded = @[@"public_profile", @"email", @"user_relationships", @"user_work_history", @"user_birthday", @"user_education_history"];
>>>>>>> FETCH_HEAD
=======
    NSArray *permissionsNeeded = @[@"public_profile", @"email", @"user_relationships", @"user_work_history", @"user_birthday", @"user_education_history"];
>>>>>>> FETCH_HEAD
=======
    NSArray *permissionsNeeded = @[@"public_profile", @"email", @"user_relationships", @"user_work_history", @"user_birthday", @"user_education_history"];
>>>>>>> FETCH_HEAD
    
    // Request the permissions the user currently has
    [FBRequestConnection startWithGraphPath:@"/me/permissions"
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error)
    {
        if (!error){
            // These are the current permissions the user has
            //NSDictionary *currentPermissions= [(NSArray *)[result data] objectAtIndex:0];
            NSArray *currentPermissions = FBSession.activeSession.permissions;
            //NSLog(@"%@",[currentPermissions allKeys]);
            // We will store here the missing permissions that we will have to request
            NSMutableArray *requestPermissions = [[NSMutableArray alloc] initWithArray:@[]];
                                  
            // Check if all the permissions we need are present in the user's current permissions
            // If they are not present add them to the permissions to be requested
            for (NSString *permission in permissionsNeeded){
                if (![currentPermissions containsObject:permission]){
                    [requestPermissions addObject:permission];
                }
            }
                                  
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
            if ([requestPermissions count] > 0)
            {
=======
            // If we have permissions to request
            if ([requestPermissions count] > 0){
                // Ask for the missing permissions
>>>>>>> FETCH_HEAD
=======
            // If we have permissions to request
            if ([requestPermissions count] > 0){
                // Ask for the missing permissions
>>>>>>> FETCH_HEAD
=======
            // If we have permissions to request
            if ([requestPermissions count] > 0){
                // Ask for the missing permissions
>>>>>>> FETCH_HEAD
                [FBSession.activeSession
                        requestNewReadPermissions:requestPermissions
                        completionHandler:^(FBSession *session, NSError *error)
                {
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
                    if (!error)
                    {
                        [self makeRequestForUserData];
                        [self makeRequestForUserFriendList];
                    }
                    else
                    {
                        NSLog(@"error %@", error.description);
=======
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
                    if (!error) {
                        // Permission granted, we can request the user information
                        [self makeRequestForUserData];
                    } else {
                        // An error occurred, we need to handle the error
                        // Check out our error handling guide: https://developers.facebook.com/docs/ios/errors/
                            NSLog(@"error %@", error.description);
<<<<<<< HEAD
<<<<<<< HEAD
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
                    }
                }];
            }
            else
            {
                // Permissions are present
                // We can request the user information
                [self makeRequestForUserData];
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
                [self makeRequestForUserFriendList];
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
            }
        }
        else
        {
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
            // An error occurred, we need to handle the error
            // Check out our error handling guide: https://developers.facebook.com/docs/ios/errors/
>>>>>>> FETCH_HEAD
=======
            // An error occurred, we need to handle the error
            // Check out our error handling guide: https://developers.facebook.com/docs/ios/errors/
>>>>>>> FETCH_HEAD
=======
            // An error occurred, we need to handle the error
            // Check out our error handling guide: https://developers.facebook.com/docs/ios/errors/
>>>>>>> FETCH_HEAD
            NSLog(@"error %@", error.description);
        }
    }];
}

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
- (void) makeRequestForUserFriendList
{
    NSString * graphPath = @"me/friendlists";
    NSString * httpMethod = @"GET";
    FBRequest * friendListRequest = [FBRequest requestWithGraphPath:graphPath parameters:nil HTTPMethod:httpMethod];
    [friendListRequest startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            if ([result isKindOfClass:[FBGraphObject class]])
            {
                AppDelegate * delegate = [UIApplication sharedApplication].delegate;
                Account * fbAccount = delegate.fbAccount;
                [fbAccount fetchFacebookPrivacySettingDataFromFBGraphObject:result];
            }
        }
    }];
}

=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
- (void) makeRequestForUserData
{
    [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error)
    {
        if (!error) {
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
            
            AppDelegate * delegate = [UIApplication sharedApplication].delegate;
            Account * fbAccount = delegate.fbAccount;
            if (fbAccount) {
                if (![fbAccount isNeedReload]) {
                    return;
                }
            }
            Account * newFBAccount = [[Account alloc] init];
            [newFBAccount fetchFacebookDataFromFBGraphObject:result];
            
            [delegate storeFBAccount:newFBAccount];
            
=======
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
            // Success! Include your code to handle the results here
            
            AppDelegate * delegate = [UIApplication sharedApplication].delegate;
            FBAccount * fbAccount = delegate.fbAccount;
            if (fbAccount) {
                if (![fbAccount isNeedReload]) {
                    NSLog(@"Data is not need to be reload");
                    return;
                }
            }
            
            FBAccount * newFBAccount = [[FBAccount alloc] init];
            
            BasicInfo *fbBasicInfo = [[BasicInfo alloc] init];
            
            NSMutableArray *bIkeyList = [fbBasicInfo keyList];
            
            for (NSString * key in bIkeyList) {
                NSString* value = [result objectForKey:key];
                Property *prop = [[Property alloc]initWithKey:key Value:value];
                [fbBasicInfo addProperty:prop];
            }
            
            WorkInfo *fbWorkInfo = [[WorkInfo alloc] init];
            
            NSMutableArray *wIkeyList = [fbWorkInfo keyList];
            
            int workCount = [[result objectForKey:@"work"] count];
            
            for (int i=0; i<workCount; i++) {
                FBGraphObject * workInfoGraph = [result objectForKey:@"work"][i];
                NSMutableArray * workDetail = [[NSMutableArray alloc] init];
                
                for (NSString * key in wIkeyList) {
                    NSString* value = [workInfoGraph objectForKey:key];
                    if ([[workInfoGraph objectForKey:key] isKindOfClass:([FBGraphObject class])]) {
                        value = [[workInfoGraph objectForKey:key] objectForKey:@"name"];
                    }

                    Property *prop = [[Property alloc]initWithKey:key Value:value];
                    [workDetail addObject:prop];
                }
                NSString * mainKey = [NSString stringWithFormat:@"Work_%d",i+1];
                Property *workDetailProp = [[Property alloc] initWithKey:mainKey Value:workDetail];
                [fbWorkInfo addProperty:workDetailProp];
            }
            
            
            EducationInfo *fbEduInfo = [[EducationInfo alloc]init];
            
            NSMutableArray *eIkeyList = [fbEduInfo keyList];
            
            int eduCount = [[result objectForKey:@"education"] count];
            
            for (int i=0; i<eduCount; i++) {
                FBGraphObject * eduInfoGraph = [result objectForKey:@"education"][i];
                NSMutableArray * eduDetail = [[NSMutableArray alloc] init];
                
                for (NSString * key in eIkeyList) {
                    NSString* value = [eduInfoGraph objectForKey:key];
                    int total = 0;
                    @try{
                        total = [[eduInfoGraph objectForKey:key] count];
                    }
                    @catch(NSException *ex){
                        NSLog(@"Key %@",key);
                    }
                    if ([[eduInfoGraph objectForKey:key] isKindOfClass:([FBGraphObject class])])
                    {
                        value = [[eduInfoGraph objectForKey:key] objectForKey:@"name"];
                    }
                    else if (total > 0)
                    {
                        
                        value = @"";
                        int total = [[eduInfoGraph objectForKey:key] count];
                        for (int i=0; i<total; i++) {
                            value = [value stringByAppendingString: [[eduInfoGraph objectForKey:key][i] objectForKey:@"name"]];
                        }
                    }
                    Property *prop = [[Property alloc]initWithKey:key Value:value];
                    [eduDetail addObject:prop];
                }
                NSString * mainKey = [NSString stringWithFormat:@"Education_%d",i+1];
                Property *eduDetailProp = [[Property alloc] initWithKey:mainKey Value:eduDetail];
                [fbEduInfo addProperty:eduDetailProp];
            }
            newFBAccount.basicInfo = fbBasicInfo;
            newFBAccount.workInfo = fbWorkInfo;
            newFBAccount.educationInfo = fbEduInfo;

            [delegate storeFBAccount:newFBAccount];
<<<<<<< HEAD
<<<<<<< HEAD
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
            fbTVDisableItems[0] = FALSE;
            fbTVDisableItems[1] = FALSE;
            fbTVDisableItems[2] = FALSE;
            [self.fbFunction reloadData];
            
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
        }
        else
        {
            NSLog(@"%@ : Error while request Facebook data for user", NSStringFromClass([self class]));
=======
        } else {
            // An error occurred, we need to handle the error
            // Check out our error handling guide: https://developers.facebook.com/docs/ios/errors/
>>>>>>> FETCH_HEAD
=======
        } else {
            // An error occurred, we need to handle the error
            // Check out our error handling guide: https://developers.facebook.com/docs/ios/errors/
>>>>>>> FETCH_HEAD
=======
        } else {
            // An error occurred, we need to handle the error
            // Check out our error handling guide: https://developers.facebook.com/docs/ios/errors/
>>>>>>> FETCH_HEAD
            NSLog(@"error %@", error.description);
        }
    }];
}

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======

// Implement the loginViewShowingLoggedInUser: delegate method to modify your app's UI for a logged-in user experience
>>>>>>> FETCH_HEAD
=======

// Implement the loginViewShowingLoggedInUser: delegate method to modify your app's UI for a logged-in user experience
>>>>>>> FETCH_HEAD
=======

// Implement the loginViewShowingLoggedInUser: delegate method to modify your app's UI for a logged-in user experience
>>>>>>> FETCH_HEAD
- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    self.status.text = @"Status: Authenticated!";
}

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
// Implement the loginViewShowingLoggedOutUser: delegate method to modify your app's UI for a logged-out user experience
>>>>>>> FETCH_HEAD
=======
// Implement the loginViewShowingLoggedOutUser: delegate method to modify your app's UI for a logged-out user experience
>>>>>>> FETCH_HEAD
=======
// Implement the loginViewShowingLoggedOutUser: delegate method to modify your app's UI for a logged-out user experience
>>>>>>> FETCH_HEAD
- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    self.profilePicture.profileID = nil;
    self.name.text = @"<Name>";
    self.email.text = @"<Email>";
    self.status.text= @"Status: Unauthenticated!";
    fbTVDisableItems[0] = TRUE;
    fbTVDisableItems[1] = TRUE;
    fbTVDisableItems[2] = TRUE;
    [self.fbFunction reloadData];
}

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    NSString *alertMessage, *alertTitle;

    if ([FBErrorUtility shouldNotifyUserForError:error])
    {
        alertTitle = @"Facebook error";
        alertMessage = [FBErrorUtility userMessageForError:error];
    }
    else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession)
    {
        alertTitle = @"Session Error";
        alertMessage = @"Your current session is no longer valid. Please log in again.";
    }
    else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled)
    {
        NSLog(@"User cancelled login");
    }
    else
    {
=======
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD

// You need to override loginView:handleError in order to handle possible errors that can occur during login
- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    NSString *alertMessage, *alertTitle;
    
    // If the user should perform an action outside of you app to recover,
    // the SDK will provide a message for the user, you just need to surface it.
    // This conveniently handles cases like Facebook password change or unverified Facebook accounts.
    if ([FBErrorUtility shouldNotifyUserForError:error]) {
        alertTitle = @"Facebook error";
        alertMessage = [FBErrorUtility userMessageForError:error];
        
        // This code will handle session closures since that happen outside of the app.
        // You can take a look at our error handling guide to know more about it
        // https://developers.facebook.com/docs/ios/errors
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession) {
        alertTitle = @"Session Error";
        alertMessage = @"Your current session is no longer valid. Please log in again.";
        
        // If the user has cancelled a login, we will do nothing.
        // You can also choose to show the user a message if cancelling login will result in
        // the user not being able to complete a task they had initiated in your app
        // (like accessing FB-stored information or posting to Facebook)
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
        NSLog(@"user cancelled login");
        
        // For simplicity, this sample handles other errors with a generic message
        // You can checkout our error handling guide for more detailed information
        // https://developers.facebook.com/docs/ios/errors
    } else {
<<<<<<< HEAD
<<<<<<< HEAD
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
        alertTitle  = @"Something went wrong";
        alertMessage = @"Please try again later.";
        NSLog(@"Unexpected error:%@", error);
    }
    
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
    if (alertMessage)
    {
=======
    if (alertMessage) {
>>>>>>> FETCH_HEAD
=======
    if (alertMessage) {
>>>>>>> FETCH_HEAD
=======
    if (alertMessage) {
>>>>>>> FETCH_HEAD
        [[[UIAlertView alloc] initWithTitle:alertTitle
                                    message:alertMessage
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
- (void)viewWillAppear:(BOOL)animated
{
=======
- (void)viewWillAppear:(BOOL)animated {
>>>>>>> FETCH_HEAD
=======
- (void)viewWillAppear:(BOOL)animated {
>>>>>>> FETCH_HEAD
=======
- (void)viewWillAppear:(BOOL)animated {
>>>>>>> FETCH_HEAD
    [super viewWillAppear:animated];
    [self.fbFunction reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
    // Return the number of sections.
>>>>>>> FETCH_HEAD
=======
    // Return the number of sections.
>>>>>>> FETCH_HEAD
=======
    // Return the number of sections.
>>>>>>> FETCH_HEAD
    return fbTVNumberOfSection;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
    return fbTVNumberOfRowsInSection;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    CGFloat result = 30.0f;
    
    return result;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, tableView.frame.size.width, 30)];
    [label setFont:[UIFont boldSystemFontOfSize:15]];
    [label setTextAlignment:NSTextAlignmentCenter];
    NSString *string = @"YOUR PROFILE BUILDER";
    
    [label setText:string];
    
    [view addSubview:label];
    
    [view setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:1]];
    
    return view;
}
=======
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
    // Return the number of rows in the section.
    return fbTVNumberOfRowsInSection;
}

<<<<<<< HEAD
<<<<<<< HEAD
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL selectable = [self isSelectable:indexPath];
    NSString * const kCellIdentifier = selectable ? @"Cell" : @"GreyCell";
    UITableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (cell == nil)
    {
        cell =
        [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                               reuseIdentifier:kCellIdentifier];
        if (selectable)
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else
        {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.textColor = [UIColor lightGrayColor];
        }
    }
    cell.textLabel.text = fbTVRowItems[indexPath.row];
    cell.accessibilityLabel = cell.textLabel.text;
    
    UIImage *theImage = [UIImage imageNamed:@"signin.png"];

    cell.imageView.image = theImage;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
    // Navigation logic may go here, for example:
    // Create the next view controller.
>>>>>>> FETCH_HEAD
=======
    // Navigation logic may go here, for example:
    // Create the next view controller.
>>>>>>> FETCH_HEAD
=======
    // Navigation logic may go here, for example:
    // Create the next view controller.
>>>>>>> FETCH_HEAD
    if (![self isSelectable:indexPath])
    {
        return;
    }
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
    
    NSString * info = fbSubViewNames[indexPath.row];
    
    ProfileBuilderViewController *controller =
    [[ProfileBuilderViewController alloc] initWithNibName:nil bundle:nil];
    [controller setFacebookAccountAsTargetAccount];
    
    if ([info isEqualToString:@"BI"])
    {
        [controller showBasicInfoData];
    }
    else if ([info isEqualToString:@"WI"])
    {
        [controller showWorkInfoData];
    }
    else if ([info isEqualToString:@"EI"])
    {
        [controller showEducationInfoData];
    }
=======
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD

    Class nibClass = NSClassFromString(fbSubViewClassNames);
    
    NSString * info = fbSubViewNames[indexPath.row];
    
    BasicInformationViewController *controller =
    [[nibClass alloc] initWithNibName:nil bundle:nil];
    
    [controller loadDSInfFo:info];
<<<<<<< HEAD
<<<<<<< HEAD
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
    
    controller.navigationItem.title = fbTVRowItems[indexPath.row];
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (BOOL)isSelectable:(NSIndexPath *)indexPath
{
    if (fbTVDisableItems[indexPath.row])
    {
        return FALSE;
    }
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
    // Do any additional setup after loading the view from its nib.
>>>>>>> FETCH_HEAD
=======
    // Do any additional setup after loading the view from its nib.
>>>>>>> FETCH_HEAD
=======
    // Do any additional setup after loading the view from its nib.
>>>>>>> FETCH_HEAD
    
    self.fbFunction.delegate = self;
    self.fbFunction.dataSource = self;
    
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
    //create Email button on toolbar
    //self.navigationController.toolbarHidden = false;
>>>>>>> FETCH_HEAD
=======
    //create Email button on toolbar
    //self.navigationController.toolbarHidden = false;
>>>>>>> FETCH_HEAD
=======
    //create Email button on toolbar
    //self.navigationController.toolbarHidden = false;
>>>>>>> FETCH_HEAD
    UIBarButtonItem *EmailButtonItem = [[UIBarButtonItem alloc]
                                        initWithBarButtonSystemItem:UIBarButtonSystemItemCompose
                                        target:self action:@selector(sendMailBt)];
    self.toolbarItems = [NSArray arrayWithObjects:EmailButtonItem,nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
    // Dispose of any resources that can be recreated.
>>>>>>> FETCH_HEAD
=======
    // Dispose of any resources that can be recreated.
>>>>>>> FETCH_HEAD
=======
    // Dispose of any resources that can be recreated.
>>>>>>> FETCH_HEAD
}

#pragma - Button Delegate

- (void)sendMailBt {
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
    AppDelegate * delegate = [UIApplication sharedApplication].delegate;

    MailContentBuilder *builder = [[MailContentBuilder alloc] initWithData:delegate.fbAccount];
    NSString * content = [builder buildProfileMailContent];
    // Email Subject
    NSString *emailTitle = @"Standard Profile Builder";
    // Email Content
    NSString *messageBody = content;
=======
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
    
    // Email Subject
    NSString *emailTitle = @"Standard Profile Builder";
    // Email Content
    NSString *messageBody = @"iOS programming is so fun!";
<<<<<<< HEAD
<<<<<<< HEAD
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
    // To address
    //NSArray *toRecipents = [NSArray arrayWithObject:@"khanhtruong@yahoo.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:YES];
    //[mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
