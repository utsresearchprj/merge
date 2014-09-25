//
//  ProfileBuilderViewController.h
//  Social Network Privacy Management
//
//  Created by Cong Phap Bui on 23/09/2014.
//
//

#import <UIKit/UIKit.h>
#import "ListSelectionTableViewController.h"
#import "AppDelegate.h"

@interface ProfileBuilderViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong,nonatomic) UIView * blockingView;

@property (strong,nonatomic) UITextField *activeField;

@property (strong,nonatomic) UIDatePicker *datePicker;

@property (strong,nonatomic) UIPickerView *pickerView;

@property (strong,nonatomic) NSMutableArray *pickerViewDataSource;

@property (strong, nonatomic) UITableView *dataTable;

@property (strong,nonatomic) Account *fbAccount;

@property (strong,nonatomic) Account *gpAccount;

@property (strong,nonatomic) Account *targetAccount;

@property (strong,nonatomic) NSString *dsInfo;

@property (strong,nonatomic) NSMutableArray *tableDataSource;

@property (strong,nonatomic) NSMutableArray *inputTypeForTableDataSource;

@property (strong,nonatomic) NSMutableArray *privacyDataSource;

@property (assign,nonatomic) NSInteger numberOfRows;

@property (assign,nonatomic) NSInteger editIndex;

- (void) prepareDataSourceWithSInfFo:(NSString*) dsInfo_;

- (void) setFacebookAccountAsTargetAccount;
- (void) setGooglePlusAccountAsTargetAccount;

- (void) showBasicInfoData;

- (void) showWorkInfoData;

- (void) showEducationInfoData;
@end

