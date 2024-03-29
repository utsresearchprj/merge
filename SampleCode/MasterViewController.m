//
//  MasterViewController.m
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

#import "MasterViewController.h"
#import <GooglePlus/GooglePlus.h>

static const int kNumSections = 2;
static NSString * const kSections[kNumSections] = {@"", @"YOUR PROFILE BUILDER"};
static const int kNumViewControllers = 3;
static NSString * const kMenuOptions[kNumViewControllers] = {
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
    @"Awareness",@"Sign in", @"Profile" };
static NSString * const kMenuOptionsOfProfileBuilder[kNumViewControllers] = {
    @"Basic Information",@"Work Information", @"Education Information" };
=======
    @"Misleading",@"Sign in", @"Profile" };
>>>>>>> FETCH_HEAD
=======
    @"Misleading",@"Sign in", @"Profile" };
>>>>>>> FETCH_HEAD
=======
    @"Misleading",@"Sign in", @"Profile" };
>>>>>>> FETCH_HEAD
static NSString * const kUnselectableMenuOptions[kNumViewControllers] = {
    nil, nil, @"Profile"};
static NSString * const kNibNames[kNumViewControllers] = {
    @"AwarenessViewController",@"SignInViewController",@"PrivacySettingViewController"};

@implementation MasterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.title = @"Social Network Privacy Management";
  }
    self.tableView.tableFooterView = [[UIView alloc] init];
  return self;
}

#pragma mark - View lifecycle

- (NSUInteger)supportedInterfaceOrientations {
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    return UIInterfaceOrientationMaskAllButUpsideDown;
  } else {
    return UIInterfaceOrientationMaskAll;
  }
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate/UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return kNumSections;
}

- (NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section {
    return kNumViewControllers;
}
- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return kSections[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  BOOL selectable = [self isSelectable:indexPath];
  NSString * const kCellIdentifier = selectable ? @"Cell" : @"GreyCell";
  UITableViewCell *cell =
      [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
  if (cell == nil) {
    cell =
        [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                               reuseIdentifier:kCellIdentifier];
    if (selectable) {
      cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
      cell.selectionStyle = UITableViewCellSelectionStyleNone;
      cell.textLabel.textColor = [UIColor lightGrayColor];
    }
  }
    
    if(indexPath.section == 0)
    {
        cell.textLabel.text = (selectable ? kMenuOptions : kUnselectableMenuOptions)
        [indexPath.row];
        cell.accessibilityLabel = cell.textLabel.text;
        
        UIImage *theImage = [UIImage imageNamed:@"osa_awareness.png"];
        if (indexPath.row == 1) {
            theImage = [UIImage imageNamed:@"signin.png"];
        }
        else if (indexPath.row == 2) {
            theImage = [UIImage imageNamed:@"privacy.png"];
        }
        cell.imageView.image = theImage;
    }else{
        cell.textLabel.text = kMenuOptionsOfProfileBuilder[indexPath.row];
        
        cell.imageView.image = [UIImage imageNamed:@"wrenches.png"];
        

    }
  
    
  return cell;
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
    if (![self isSelectable:indexPath]) {
        return;
    }
    // do not allow to open profile builder at the moment
    if(indexPath.section == 1)
        return;
  Class nibClass = NSClassFromString(kNibNames[indexPath.row]);
  UIViewController *controller =
      [[nibClass alloc] initWithNibName:nil bundle:nil];
    controller.navigationItem.title = kMenuOptions[indexPath.row];
//    if(indexPath.row == 1)
//    {
//        
//        [controller.navigationItem.rightBarButtonItem init].title = @"Try";
//    }

  [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Helper methods

- (BOOL)isSelectable:(NSIndexPath *)indexPath {
    
  if (indexPath.section == 0 && kUnselectableMenuOptions[indexPath.row]) {
    // To use Google+ app activities, you need to sign in.
    return [GPPSignIn sharedInstance].authentication != nil;
  }
  return YES;
}

@end
