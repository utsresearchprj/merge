//
//  AppDelegate.h
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

#import <UIKit/UIKit.h>
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
#import "Account.h"
=======
#import "FBAccount.h"
>>>>>>> FETCH_HEAD
=======
#import "FBAccount.h"
>>>>>>> FETCH_HEAD
=======
#import "FBAccount.h"
>>>>>>> FETCH_HEAD
@class GTMOAuth2Authentication;

@interface AppDelegate : UIResponder<UIApplicationDelegate>

// The sample app's |UIWindow|.
@property(strong, nonatomic) UIWindow *window;
// The navigation controller.
@property(strong, nonatomic) UINavigationController *navigationController;

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
@property(nonatomic, copy) Account * fbAccount;
@property(nonatomic, copy) Account * gpAccount;

- (void) storeFBAccount: (Account *) myFBAccount;
- (void) storeGPAccount: (Account *) myGPAccount;
=======
@property(nonatomic, copy) FBAccount * fbAccount;

- (void) storeFBAccount: (FBAccount *) myFBAccount;
>>>>>>> FETCH_HEAD
=======
@property(nonatomic, copy) FBAccount * fbAccount;

- (void) storeFBAccount: (FBAccount *) myFBAccount;
>>>>>>> FETCH_HEAD
=======
@property(nonatomic, copy) FBAccount * fbAccount;

- (void) storeFBAccount: (FBAccount *) myFBAccount;
>>>>>>> FETCH_HEAD
@end
