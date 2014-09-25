//
//  BasicInformationViewController.h
//  Social Network Privacy Management
//
//  Created by Cong Phap Bui on 19/09/2014.
//
//

#import <UIKit/UIKit.h>
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
#import "ListSelectionTableViewController.h"
#import "AppDelegate.h"

#define KEY_TAG 1
#define VALUE_TAG 2
#define PRIVACY_TAG 3
#define EDIT_TAG 4

=======
#import "BasicInformationViewCell.h"
#import "FBAccount.h"
#import "AppDelegate.h"
>>>>>>> FETCH_HEAD
=======
#import "BasicInformationViewCell.h"
#import "FBAccount.h"
#import "AppDelegate.h"
>>>>>>> FETCH_HEAD
=======
#import "BasicInformationViewCell.h"
#import "FBAccount.h"
#import "AppDelegate.h"
>>>>>>> FETCH_HEAD
@interface BasicInformationViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong,nonatomic) UITextField *activeField;

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
@property (strong,nonatomic) UIButton *editBtn;

>>>>>>> FETCH_HEAD
=======
@property (strong,nonatomic) UIButton *editBtn;

>>>>>>> FETCH_HEAD
=======
@property (strong,nonatomic) UIButton *editBtn;

>>>>>>> FETCH_HEAD
@property (strong,nonatomic) UIDatePicker *datePicker;

@property (strong,nonatomic) NSMutableArray *pickerViewDataSource;

@property (strong, nonatomic) UITableView *dataTable;

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
@property (strong,nonatomic) Account *fbAccount;

@property (strong,nonatomic) NSString *dsInfo;

=======
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
@property (strong,nonatomic) FBAccount *fbAccount;

@property (strong,nonatomic) NSString *dsInfo;

@property (assign,nonatomic) NSInteger pageNumber;

<<<<<<< HEAD
<<<<<<< HEAD
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
@property (strong,nonatomic) NSMutableArray *tableDataSource;

@property (strong,nonatomic) NSMutableArray *inputTypeForTableDataSource;

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
@property (strong,nonatomic) NSMutableArray *privacyDataSource;

@property (assign,nonatomic) NSInteger numberOfRows;

@property (assign,nonatomic) NSInteger editIndex;

=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
- (void) loadDSInfFo:(NSString*) dsInfo_;
@end
