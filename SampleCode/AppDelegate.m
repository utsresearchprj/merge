//
//  AppDelegate.m
//
//  Copyright 2012 Google Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "AppDelegate.h"

#import <FacebookSDK/FacebookSDK.h>
#import <GooglePlus/GooglePlus.h>
#import "AccountViewController.h"

@interface AppDelegate () <GPPDeepLinkDelegate>

@end

@implementation AppDelegate

@synthesize fbAccount;
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
@synthesize gpAccount;
// DO NOT USE THIS CLIENT ID. IT WILL NOT WORK FOR YOUR APP.
// Please use the client ID created for you by Google.
//clientID by project "quick sample", bundle "com.google.GooglePlusPlatformSample" on Google Developer Console
//static NSString * const kClientID = @"886332375107-m9uqfghf0j6n447a6pet8dhfu0ncleki.apps.googleusercontent.com";
//static NSString * const kBundle = @"google";

//clientID by project "Privacy Management", bundle "com.aus-fresh.PrivacyMngt" on Google Developer Console
static NSString * const kClientID = @"717769283079-7t5g6h5al448t1u5jp47n46cvjfmsqaq.apps.googleusercontent.com";
static NSString * const kBundle = @"aus-fresh";

static NSString * const kURLFB = @"facebook";
=======
// DO NOT USE THIS CLIENT ID. IT WILL NOT WORK FOR YOUR APP.
// Please use the client ID created for you by Google.

//clientID by project "quick sample" on Google Developer Console
//static NSString * const kClientID = @"886332375107-m9uqfghf0j6n447a6pet8dhfu0ncleki.apps.googleusercontent.com";
>>>>>>> FETCH_HEAD
=======
// DO NOT USE THIS CLIENT ID. IT WILL NOT WORK FOR YOUR APP.
// Please use the client ID created for you by Google.

//clientID by project "quick sample" on Google Developer Console
//static NSString * const kClientID = @"886332375107-m9uqfghf0j6n447a6pet8dhfu0ncleki.apps.googleusercontent.com";
>>>>>>> FETCH_HEAD
=======
// DO NOT USE THIS CLIENT ID. IT WILL NOT WORK FOR YOUR APP.
// Please use the client ID created for you by Google.

//clientID by project "quick sample" on Google Developer Console
//static NSString * const kClientID = @"886332375107-m9uqfghf0j6n447a6pet8dhfu0ncleki.apps.googleusercontent.com";
>>>>>>> FETCH_HEAD

//clientID by project "Privacy Management" on Google Developer Console
static NSString * const kClientID = @"717769283079-7t5g6h5al448t1u5jp47n46cvjfmsqaq.apps.googleusercontent.com";

#pragma mark Object life-cycle.


- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
  [FBProfilePictureView class];
  // Set app's client ID for |GPPSignIn| and |GPPShare|.
  [GPPSignIn sharedInstance].clientID = kClientID;

  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//  MasterViewController *masterViewController =
//      [[MasterViewController alloc] initWithNibName:@"MasterViewController"
//                                             bundle:nil];
//  self.navigationController =
//      [[UINavigationController alloc]
//          initWithRootViewController:masterViewController];
    
    AccountViewController *accountViewController =
    [[AccountViewController alloc] initWithNibName:@"AccountViewController"
                                           bundle:nil];
    self.navigationController =
    [[UINavigationController alloc]
     initWithRootViewController:accountViewController];
    
  self.window.rootViewController = self.navigationController;
  [self.window makeKeyAndVisible];

  // Read Google+ deep-link data.
  [GPPDeepLink setDelegate:self];
  [GPPDeepLink readDeepLinkAfterInstall];
  return YES;
}

- (BOOL)application:(UIApplication *)application
              openURL:(NSURL *)url
    sourceApplication:(NSString *)sourceApplication
           annotation:(id)annotation {
    NSString *urlStr = [url absoluteString];
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
    if ([urlStr rangeOfString:kBundle].location != NSNotFound) {
=======
    if ([urlStr rangeOfString:@"google"].location != NSNotFound) {
>>>>>>> FETCH_HEAD
=======
    if ([urlStr rangeOfString:@"google"].location != NSNotFound) {
>>>>>>> FETCH_HEAD
=======
    if ([urlStr rangeOfString:@"google"].location != NSNotFound) {
>>>>>>> FETCH_HEAD
        //NSLog(@"URL from Google");
        return [GPPURLHandler handleURL:url
                      sourceApplication:sourceApplication
                             annotation:annotation];
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
    }else if ([urlStr rangeOfString:kURLFB].location != NSNotFound){
=======
    }else if ([urlStr rangeOfString:@"facebook"].location != NSNotFound){
>>>>>>> FETCH_HEAD
=======
    }else if ([urlStr rangeOfString:@"facebook"].location != NSNotFound){
>>>>>>> FETCH_HEAD
=======
    }else if ([urlStr rangeOfString:@"facebook"].location != NSNotFound){
>>>>>>> FETCH_HEAD
        //NSLog(@"URL from Facebook");
        return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
    }
    return FALSE;
}

#pragma mark - GPPDeepLinkDelegate

- (void)didReceiveDeepLink:(GPPDeepLink *)deepLink {
  // An example to handle the deep link data.
  UIAlertView *alert = [[UIAlertView alloc]
          initWithTitle:@"Deep-link Data"
                message:[deepLink deepLinkID]
               delegate:nil
      cancelButtonTitle:@"OK"
      otherButtonTitles:nil];
  [alert show];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [FBAppEvents activateApp];
    [FBAppCall handleDidBecomeActive];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
- (void) storeFBAccount: (Account *) myFBAccount
=======
- (void) storeFBAccount: (FBAccount *) myFBAccount
>>>>>>> FETCH_HEAD
=======
- (void) storeFBAccount: (FBAccount *) myFBAccount
>>>>>>> FETCH_HEAD
=======
- (void) storeFBAccount: (FBAccount *) myFBAccount
>>>>>>> FETCH_HEAD
{
    fbAccount = myFBAccount;
}

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
- (void) storeGPAccount: (Account *) myGPAccount
{
    gpAccount = myGPAccount;
}

=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
@end
