//
//  ProfileBuilderViewController.m
//  Social Network Privacy Management
//
//  Created by Cong Phap Bui on 23/09/2014.
//
//

#import "ProfileBuilderViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ProfileBuilderViewController ()

@end

static CGFloat cellHeight = 65.0f;
static const CGFloat bICellHeight = 65;
static const CGFloat wICellHeight = 155;
static const CGFloat eICellHeight = 155;

static const CGFloat headerHeight = 30;
static const CGFloat footerHeight = 0;

static const CGFloat viewOffsetY = 70;

static int const genderCount = 3;
static NSString* const gender[] = {@"Male", @"Female", @"Custom"};

static int const relationshipCount = 4;
static NSString* const relationship[] = {@"Single", @"Married", @"In relationship", @"In open relationship"};

static int const schoolTypeCount = 4;
static NSString* const schoolType[] = {@"High school",@"College",@"University",@"Graduate School"};

@implementation ProfileBuilderViewController

@synthesize dsInfo;
@synthesize numberOfRows;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.blockingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
        self.blockingView.alpha = 0.5;
        
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        self.fbAccount = delegate.fbAccount;
        self.gpAccount = delegate.gpAccount;
        self.editIndex = -1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.automaticallyAdjustsScrollViewInsets = NO;
    CGFloat tableHeight = numberOfRows*cellHeight + headerHeight + footerHeight;
    if (tableHeight > 360) {
        tableHeight = 360;
    }
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(10, 0 + viewOffsetY, 300, tableHeight) style:UITableViewStylePlain];
    
    table.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    table.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:1].CGColor;
    table.layer.borderWidth = 1;
    table.layer.cornerRadius = 10;
    
    self.dataTable = table;
    
    [self.dataTable setScrollEnabled:YES];
    [self.dataTable setScrollsToTop:NO];
    
    self.dataTable.delegate = self;
    self.dataTable.dataSource=self;
    
    [[self view] addSubview:self.dataTable];
    
    
    [self registerForKeyboardNotifications];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//===============================Keyboard===============================//
#pragma mark ----------Keyboard Event Handler
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
    
    CGRect viewRect = self.view.frame;
    
    //This height does not need to be add to content Inset
    CGFloat unUsedHeight = viewRect.size.height - viewOffsetY - self.dataTable.frame.size.height;
    
    CGFloat contentInsetsHeight = kbSize.height - unUsedHeight;
    
    CGRect frame = self.dataTable.frame;
    frame.size.height -= contentInsetsHeight;
    
    self.dataTable.frame = frame;
}

// Called when the UIKeyboardWillHideNotification is sent

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    
    self.dataTable.contentInset = contentInsets;
    
    self.dataTable.scrollIndicatorInsets = contentInsets;
    
    CGRect frame = self.dataTable.frame;
    frame.size.height = 360;
    
    self.dataTable.frame = frame;
    
}

//===============================UITextField===============================//
#pragma mark ----------Text Field Handler:
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (self.activeField != nil) {
        return NO;
    }
    self.activeField = textField;

    if (textField.tag == KeyboardType) {
        return YES;
    }
    if (textField.tag != KeyboardType && textField.tag != DatePickerType)
    {
        [self preparePickerDataForType:textField.tag];
        [self showPicker];
    }
    else if (textField.tag == DatePickerType)
    {
        [self showDatePicker];
    }
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *) textField
{
    //self.activeField = textField;
    [self.view addSubview:self.blockingView];
}

- (void)textFieldDidEndEditing:(UITextField *)textField

{
    [self.blockingView removeFromSuperview];
    [self.activeField resignFirstResponder];
    self.activeField = nil;
    [self saveData];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//===============================UITableView===============================//
#pragma mark ----------Build Data Table View:
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self prepareDataSource];
    
    CGFloat tableHeight = numberOfRows*cellHeight + headerHeight + footerHeight;
    if (tableHeight > 360)
    {
        tableHeight = 360;
    }
    
    CGRect frame = self.dataTable.frame;
    frame.size.height = tableHeight;

    self.dataTable.frame = frame;
    
    [self.dataTable reloadData];
}

- (CGFloat) tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat result = 20.0f;
    if ([tableView isEqual:self.dataTable]){
        result = cellHeight;
    }
    return result;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    CGFloat result = 0.0f;
    if ([tableView isEqual:self.dataTable]){
        result = headerHeight;
    }
    return result;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    CGFloat result = 0.0f;
    if ([tableView isEqual:self.dataTable]){
        result = footerHeight;
    }
    return result;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, cellHeight*5, tableView.frame.size.width, 30)];
    
    [view setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:1]];
    
    return view;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
   
    CGRect frame = CGRectMake(10, 0, 200, 30);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    [label setFont:[UIFont boldSystemFontOfSize:15]];
    NSString *string;
    if ([dsInfo isEqualToString:@"BI"]) {
        string = @"BASIC INFO";
    }else if ([dsInfo isEqualToString:@"WI"]){
        if (self.editIndex<0)
        {
            string = @"WORK HISTORY";
        }
        else
        {
            string = @"EDIT WORK HISTORY";
        }
    }else if ([dsInfo isEqualToString:@"EI"]){
        if (self.editIndex<0)
        {
            string = @"EDUCATION HISTORY";
        }
        else
        {
            string = @"EDIT EDUCATION HISTORY";
        }
    }
    
    
    [label setText:string];
    
    [view addSubview:label];
    
    if (self.editIndex<0 && ![self isShowForBasicInfoData]) {
        frame.origin.x += 210;
        frame.size.width = 90;
        UIButton *add = [self addButtonForNewDataWithFrame:frame];
        [view addSubview:add];
    }
    
    [view setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:1]]; //your background color...
    
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([tableView isEqual:self.dataTable]){
        return numberOfRows;
    }
    return 0;
}

- (UITableViewCell *) defaultTableView:(UITableView *)tableView
                 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    if ([tableView isEqual:self.dataTable]){
        
        static NSString *TableViewCellIdentifier = @"ProfileDataTableViewCell";
        
        cell = [tableView dequeueReusableCellWithIdentifier:TableViewCellIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableViewCellIdentifier];
            
            cell.backgroundColor = [UIColor whiteColor];
            
            UILabel *keyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 160, 30)];
            keyLabel.font = [UIFont systemFontOfSize:15];
            keyLabel.textColor = [UIColor redColor];
            
            UITextField *valueField = [[UITextField alloc] initWithFrame:CGRectMake(10, 30, 280, 30)];
            valueField.borderStyle = UITextBorderStyleRoundedRect;
            valueField.font = [UIFont systemFontOfSize:14];
            valueField.autocorrectionType = UITextAutocorrectionTypeNo;
            
            valueField.returnKeyType = UIReturnKeyDone;
            
            CGRect btnFrame = CGRectMake(180, 1, 100, 28);
            
            UIButton *privacySetting = [self privacyButtonForDataWithFrame:btnFrame];
            
            [cell.contentView addSubview:keyLabel];
            [cell.contentView addSubview:valueField];
            
            if ([dsInfo isEqualToString:@"BI"])
            {
                [cell.contentView addSubview:privacySetting];
            }
        }
        
        UILabel * keyLabel = (UILabel *)[cell.contentView subviews][0];
        UITextField * valueField = (UITextField *)[cell.contentView subviews][1];
        
        NSMutableArray *propList = self.tableDataSource;
        NSMutableArray *inputTypeList = self.inputTypeForTableDataSource;
        
        NSString *key = @"";
        NSString *value = @"";
        
        if ([propList count]>0) {
            Property *prop = [propList objectAtIndex:indexPath.row];
            key = [prop key];
            value = [prop value];
        }else
        {
            
        }
        
        keyLabel.text = [key capitalizedString];
        valueField.text = value;
        
        NSNumber *tagType = [inputTypeList objectAtIndex:indexPath.row];
        
        NSInteger tagValue = [tagType intValue];
        valueField.tag = tagValue;
        valueField.delegate = self;
        
        if ([dsInfo isEqualToString:@"BI"])
        {
            UIButton * privacySetting = (UIButton *)[cell.contentView subviews][2];
            NSString *privacy = [self.privacyDataSource objectAtIndex:indexPath.row];
            [privacySetting setTitle:privacy forState:UIControlStateNormal];
            
            privacySetting.tag = indexPath.row;
        }
    }
    
    return cell;
}

- (UITableViewCell *) workInfoTableView:(UITableView *)tableView
                  cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    if ([tableView isEqual:self.dataTable]){
        
        static NSString *TableViewCellIdentifier = @"ProfileDataTableViewCell";
        
        cell = [tableView dequeueReusableCellWithIdentifier:TableViewCellIdentifier];
        if (cell == NULL)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableViewCellIdentifier];
            
            cell.backgroundColor = [UIColor whiteColor];
            
            CGRect frame = CGRectMake(10, 0, 160, 30);
            UILabel * employer = [[UILabel alloc] initWithFrame:frame];
            employer.textColor = [UIColor redColor];
            employer.font = [UIFont systemFontOfSize:17];
            
            frame.origin.y += 30;
            frame.origin.x += 10;
            UILabel * position = [[UILabel alloc] initWithFrame:frame];
            position.textColor = [UIColor brownColor];
            position.font = [UIFont systemFontOfSize:13];
            
            frame.origin.y += 30;
            UILabel * date = [[UILabel alloc] initWithFrame:frame];
            date.textColor = [UIColor lightGrayColor];
            date.font = [UIFont systemFontOfSize:13];
            
            frame.origin.y += 30;
            UILabel * location = [[UILabel alloc] initWithFrame:frame];
            location.textColor = [UIColor lightGrayColor];
            location.font = [UIFont systemFontOfSize:13];
            
            frame.origin.y += 30;
            UILabel * description = [[UILabel alloc] initWithFrame:frame];
            description.textColor = [UIColor blackColor];
            description.font = [UIFont systemFontOfSize:13];
            
            CGRect btnFrame = CGRectMake(200, 1, 100, 28);
            UIButton *privacySetting = [self privacyButtonForDataWithFrame:btnFrame];
            
            btnFrame.origin.y += 50;
            btnFrame.origin.x += 10;
            UIButton *edit = [self editButtonForDataWithFrame:btnFrame];
            
            btnFrame.origin.y += 30;
            UIButton *delete = [self deleteButtonForDataWithFrame:btnFrame];
            
            [cell.contentView addSubview:employer];
            [cell.contentView addSubview:position];
            [cell.contentView addSubview:date];
            [cell.contentView addSubview:location];
            [cell.contentView addSubview:description];
            
            [cell.contentView addSubview:privacySetting];
            [cell.contentView addSubview:edit];
            [cell.contentView addSubview:delete];
        }
        UILabel * employer = [cell.contentView subviews][0];
        UILabel * position = [cell.contentView subviews][1];
        UILabel * date = [cell.contentView subviews][2];
        UILabel * location = [cell.contentView subviews][3];
        UILabel * description = [cell.contentView subviews][4];
        
        UIButton * privacySetting = (UIButton *)[cell.contentView subviews][5];
        UIButton * edit = (UIButton *)[cell.contentView subviews][6];
        UIButton * delete = (UIButton *)[cell.contentView subviews][7];
        
        Property * workHistory = [self.tableDataSource objectAtIndex:indexPath.row];
        NSMutableArray *propList = workHistory.value;
        NSInteger rowCount = [propList count];
        
        if (rowCount > 0) {
            for (int i = 0; i < rowCount; i++) {
                Property * row = [propList objectAtIndex:i];
                
                if ([row.key isEqualToString:@"employer"])
                {
                    employer.text = row.value;
                }
                else if ([row.key isEqualToString:@"position"])
                {
                    position.text = row.value;
                }
                else if ([row.key isEqualToString:@"start_date"])
                {
                    date.text = row.value;
                }
                else if ([row.key isEqualToString:@"end_date"])
                {
                    NSString * endDate = row.value;
                    
                    if (!endDate || [endDate isEqualToString:@""])
                    {
                        endDate = @"Present";
                    }
                    date.text = [NSString stringWithFormat:@"%@ - %@",date.text,endDate];
                }
                else if ([row.key isEqualToString:@"location"])
                {
                    location.text = row.value;
                }
                else if ([row.key isEqualToString:@"description"])
                {
                    description.text = row.value;
                }
            }
        }else
        {
            
        }
        
        NSString *privacy = [self.privacyDataSource objectAtIndex:indexPath.row];
        [privacySetting setTitle:privacy forState:UIControlStateNormal];
        
        privacySetting.tag = indexPath.row;
        edit.tag = indexPath.row;
        delete.tag = indexPath.row;
    }
    
    return cell;
}

- (UITableViewCell *) educationInfoTableView:(UITableView *)tableView
                       cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    if ([tableView isEqual:self.dataTable]){
        
        static NSString *TableViewCellIdentifier = @"ProfileDataTableViewCell";
        
        cell = [tableView dequeueReusableCellWithIdentifier:TableViewCellIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableViewCellIdentifier];
            
            cell.backgroundColor = [UIColor whiteColor];
            
            CGRect frame = CGRectMake(10, 0, 160, 60);
            UILabel * school = [[UILabel alloc] initWithFrame:frame];
            school.numberOfLines=2;
            school.textColor = [UIColor redColor];
            school.font = [UIFont systemFontOfSize:17];
            
            frame = CGRectMake(20, 60, 160, 30);
            UILabel * type = [[UILabel alloc] initWithFrame:frame];
            type.textColor = [UIColor blackColor];
            type.font = [UIFont systemFontOfSize:13];
            
            frame.origin.y += 30;
            UILabel * date = [[UILabel alloc] initWithFrame:frame];
            date.textColor = [UIColor lightGrayColor];
            date.font = [UIFont systemFontOfSize:13];
            
            CGRect btnFrame = CGRectMake(200, 1, 100, 28);
            UIButton *privacySetting = [self privacyButtonForDataWithFrame:btnFrame];
            
            btnFrame.origin.y += 50;
            btnFrame.origin.x += 30;
            UIButton *edit = [self editButtonForDataWithFrame:btnFrame];
            
            btnFrame.origin.y += 30;
            UIButton *delete = [self deleteButtonForDataWithFrame:btnFrame];
            
            [cell.contentView addSubview:school];
            [cell.contentView addSubview:type];
            [cell.contentView addSubview:date];
            
            [cell.contentView addSubview:privacySetting];
            [cell.contentView addSubview:edit];
            [cell.contentView addSubview:delete];
        }
        
        UILabel *school = [cell.contentView subviews][0];
        UILabel *type = [cell.contentView subviews][1];
        UILabel *date = [cell.contentView subviews][2];
        
        UIButton * privacySetting = (UIButton *)[cell.contentView subviews][3];
        UIButton * edit = (UIButton *)[cell.contentView subviews][4];
        UIButton * delete = (UIButton *)[cell.contentView subviews][5];
        
        Property * eduHistory = [self.tableDataSource objectAtIndex:indexPath.row];
        NSMutableArray *propList = eduHistory.value;
        NSInteger rowCount = [propList count];
        
        if (rowCount > 0)
        {
            for (int i = 0; i < rowCount; i++) {
                Property * row = [propList objectAtIndex:i];
                
                if ([row.key isEqualToString:@"school"])
                {
                    school.text = row.value;
                }
                else if ([row.key isEqualToString:@"type"])
                {
                    type.text = row.value;
                }
                else if ([row.key isEqualToString:@"year"])
                {
                    date.text = row.value;
                }
            }
        }
        else
        {
            
        }
        
        NSString *privacy = [self.privacyDataSource objectAtIndex:indexPath.row];
        [privacySetting setTitle:privacy forState:UIControlStateNormal];
        
        privacySetting.tag = indexPath.row;
        edit.tag = indexPath.row;
        delete.tag = indexPath.row;
    }
    
    return cell;
}

- (UITableViewCell *) tableView:(UITableView *)tableView
          cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%@ - Row %d", dsInfo, indexPath.row);
    
    if ([dsInfo isEqualToString:@"BI"])
    {
        return [self defaultTableView:tableView cellForRowAtIndexPath:indexPath];
    }
    else if ([dsInfo isEqualToString:@"WI"])
    {
        if (self.editIndex<0)
        {
            return [self workInfoTableView:tableView cellForRowAtIndexPath:indexPath];
        }
        else
        {
            return [self defaultTableView:tableView cellForRowAtIndexPath:indexPath];
        }
        
    }
    else if ([dsInfo isEqualToString:@"EI"])
    {
        if (self.editIndex<0)
        {
            return [self educationInfoTableView:tableView cellForRowAtIndexPath:indexPath];
        }
        else
        {
            return [self defaultTableView:tableView cellForRowAtIndexPath:indexPath];
        }
    }
    return nil;
}

//======================================BUTTON INIT======================================//
#pragma mark ----------Generate ADD/EDIT/DELETE/PRIVACY Button:
- (UIButton*) addButtonForNewDataWithFrame: (CGRect)frame
{
    UIButton *add = [UIButton buttonWithType:UIButtonTypeContactAdd];
    add.frame =frame;
    [add setTitle:@"ADD" forState:UIControlStateNormal];
    add.titleLabel.font = [UIFont systemFontOfSize:13];
    add.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [add addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    return add;
}

- (UIButton*) editButtonForDataWithFrame: (CGRect)frame
{
    UIButton *edit = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    edit.frame =frame;
    [edit setTitle:@"EDIT" forState:UIControlStateNormal];
    edit.titleLabel.font = [UIFont systemFontOfSize:13];

    edit.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    UIImage * editImg = [UIImage imageNamed:@"edit.png"];
    [edit setImage:editImg forState:UIControlStateNormal];
    [edit addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    return edit;
}

- (UIButton*) deleteButtonForDataWithFrame: (CGRect)frame
{
    UIButton *delete = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    delete.frame = frame;
    [delete setTitle:@"DELETE" forState:UIControlStateNormal];
    delete.titleLabel.font = [UIFont systemFontOfSize:13];

    delete.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    UIImage * deleteImg = [UIImage imageNamed:@"delete.png"];
    [delete setImage:deleteImg forState:UIControlStateNormal];
    [delete addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
    return delete;
}

- (UIButton*) privacyButtonForDataWithFrame: (CGRect)frame
{
    UIButton *privacySetting = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    privacySetting.frame = frame;
    privacySetting.titleLabel.font = [UIFont systemFontOfSize:13];
    [privacySetting addTarget:self action:@selector(selectPrivacySetting:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage * img = [UIImage imageNamed:@"drop_down.png"];
    [privacySetting setImage:img forState:UIControlStateNormal];

    privacySetting.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    return privacySetting;
}

- (void)selectPrivacySetting:(UIButton*)sender
{
    ListSelectionTableViewController *controller = [[ListSelectionTableViewController alloc] initWithNibName:nil bundle:nil];
    
    NSMutableArray *settingList = self.privacyDataSource;
    
    NSMutableArray * dataList = self.targetAccount.privacyData.privacySettingList;
    
    NSMutableDictionary * noticeList = self.targetAccount.privacyData.privacyAwarenessList;
    
    [controller prepareDataList:dataList AndNoticeList:noticeList WithSettingList:settingList AtIndex:sender.tag];
    
    controller.navigationItem.title = @"Privacy";
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)add:(UIButton*)sender
{
    NSInteger editIndex = numberOfRows;
    
    NSString * info = dsInfo;
    
    if ([self isShowForWorkInfoData])
    {
        NSMutableArray *keyList = self.targetAccount.workInfo.keyList;
        NSMutableArray *newWorkHistory = [[NSMutableArray alloc] init];
        for (NSString *key in keyList) {
            Property *prop = [[Property alloc] init];
            prop.key=key;
            prop.value=@"";
            [newWorkHistory addObject:prop];
        }
        Property *newWorkHistoryProp = [[Property alloc] init];
        newWorkHistoryProp.key = [NSString stringWithFormat:@"Work_%d",editIndex];
        newWorkHistoryProp.value = newWorkHistory;
        
        [self.targetAccount addPropertyToWorkInfo:newWorkHistoryProp];
    }else if ([self isShowForEducationInfoData])
    {
        NSMutableArray *keyList = self.targetAccount.educationInfo.keyList;
        NSMutableArray *newEducationHistory = [[NSMutableArray alloc] init];
        for (NSString *key in keyList) {
            Property *prop = [[Property alloc] init];
            prop.key=key;
            prop.value=@"";
            [newEducationHistory addObject:prop];
        }
        Property *newEducationHistoryProp = [[Property alloc] init];
        newEducationHistoryProp.key = [NSString stringWithFormat:@"Education_%d",editIndex];
        newEducationHistoryProp.value = newEducationHistory;
        
        [self.targetAccount addPropertyToEducationInfo:newEducationHistoryProp];
    }
    
    ProfileBuilderViewController *controller =
    [[ProfileBuilderViewController alloc] initWithNibName:nil bundle:nil];
    controller.targetAccount = self.targetAccount;
    
    [controller prepareDataSourceWithSInfFo:info WithIndexForEdit:editIndex];
    
    controller.navigationItem.title = @"ADD";
    
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancel setTitle:@"Cancel" forState:UIControlStateNormal];
    cancel.frame = CGRectMake(15, 30, 70, 25);
    cancel.titleLabel.textColor = [UIColor redColor];
    cancel.layer.masksToBounds = NO;
    cancel.layer.cornerRadius = 5;
    cancel.layer.borderWidth = 1;
    cancel.layer.backgroundColor = [UIColor whiteColor].CGColor;
    cancel.layer.borderColor = [UIColor redColor].CGColor;
    cancel.tag = editIndex;
    [cancel addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *done = [UIButton buttonWithType:UIButtonTypeSystem];
    [done setTitle:@"Done" forState:UIControlStateNormal];
    done.frame = CGRectMake(15, 35, 70, 25);
    done.titleLabel.textColor = [UIColor colorWithRed:0 green:0.478431 blue:1.0 alpha:1.0];
    done.layer.masksToBounds = NO;
    done.layer.cornerRadius = 5;
    done.layer.borderWidth = 1;

    done.layer.borderColor = [UIColor colorWithRed:0 green:0.478431 blue:1.0 alpha:1.0].CGColor;
    done.layer.backgroundColor = [UIColor whiteColor].CGColor;
    
    done.tag = editIndex;
    [done addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *cancelBarItem = [[UIBarButtonItem alloc] initWithCustomView:cancel];

    UIBarButtonItem *doneBarItem = [[UIBarButtonItem alloc] initWithCustomView:done];
    
    controller.navigationItem.leftBarButtonItem = cancelBarItem;
    controller.navigationItem.rightBarButtonItem = doneBarItem;
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)cancel:(UIButton*)sender
{
    NSInteger index = sender.tag;
    
    if ([self isShowForWorkInfoData])
    {
        [self.targetAccount.workInfo.propertyList removeObjectAtIndex:index];
    }
    else if ([self isShowForEducationInfoData])
    {
        [self.targetAccount.educationInfo.propertyList removeObjectAtIndex:index];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)done:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)edit:(UIButton*)sender
{
    NSInteger editIndex = sender.tag;
    
    NSString * info = dsInfo;
    
    ProfileBuilderViewController *controller =
    [[ProfileBuilderViewController alloc] initWithNibName:nil bundle:nil];
    controller.targetAccount = self.targetAccount;
    [controller prepareDataSourceWithSInfFo:info WithIndexForEdit:editIndex];
    
    controller.navigationItem.title = @"EDIT";
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)delete:(UIButton*)sender
{
    NSInteger index = sender.tag;
    [self.tableDataSource removeObjectAtIndex:index];

    [self viewDidAppear:YES];
}

//======================================ACTION SHEET======================================//
#pragma mark ----------Generate ActionSheet:
- (void) dismissActionSheet: (id)sender
{
    NSInteger pickerViewSelectedRow = 0;
    
    if (self.activeField.tag == DatePickerType) {
        NSDate *selectedDate = self.datePicker.date;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM/dd/yyyy"];
        self.activeField.text = [dateFormatter stringFromDate:selectedDate];
        self.datePicker = nil;
    }
    else
    {
        pickerViewSelectedRow = [self.pickerView selectedRowInComponent:0];
        self.pickerView = nil;
    }
    
    if (self.activeField.tag == GenderPickerType)
    {
        self.activeField.text = gender[pickerViewSelectedRow];
    }
    else if (self.activeField.tag == SchoolPickerType)
    {
        self.activeField.text = schoolType[pickerViewSelectedRow];
    }
    else if (self.activeField.tag == RelationshipPickerType)
    {
        self.activeField.text = relationship[pickerViewSelectedRow];
    }
    
    UIActionSheet *sheet = (UIActionSheet *)[(UISegmentedControl*)sender superview];

    [sheet dismissWithClickedButtonIndex:0 animated:YES];
    self.activeField = nil;
    [self saveData];
    
    CGRect frame = self.dataTable.frame;
    frame.size.height = 360;
    self.dataTable.frame=frame;
}

- (void)pickerView:(UIPickerView *)pV didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *value = [self.pickerViewDataSource objectAtIndex:row];
    self.activeField.text = value;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.pickerViewDataSource count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.pickerViewDataSource objectAtIndex:row];
}


- (void) preparePickerDataForType: (TextFieldInputType) type
{
    NSMutableArray *datasource = [[NSMutableArray alloc] init];
    switch (type) {
        case GenderPickerType:
            for (int i=0; i<genderCount; i++) {
                [datasource addObject:gender[i]];
            }
            self.pickerViewDataSource = datasource;
            break;
        case RelationshipPickerType:
            for (int i=0; i<relationshipCount; i++) {
                [datasource addObject:relationship[i]];
            }
            self.pickerViewDataSource = datasource;
            break;
        case SchoolPickerType:
            for (int i=0; i<schoolTypeCount; i++) {
                [datasource addObject:schoolType[i]];
            }
            self.pickerViewDataSource = datasource;
            break;
        default:
            break;
    }
}

- (void) showPicker
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:nil
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil];
    
    [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    
    
    
    CGRect pickerFrame = CGRectMake(0, 30, 0, 0);
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    pickerView.showsSelectionIndicator = YES;
    pickerView.dataSource = self;
    pickerView.delegate = self;
    
    NSString *value = self.activeField.text;
    NSInteger index = 0;
    
    if (value && ![value isEqualToString:@""])
    {
        index = [self.pickerViewDataSource indexOfObject: [value capitalizedString]];
    }
    
    [pickerView selectRow:index inComponent:0 animated:YES];
    
    self.pickerView = pickerView;
    
    [actionSheet addSubview:pickerView];

    
    UISegmentedControl *doneButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Done"]];
    doneButton.momentary = YES;
    doneButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
    doneButton.segmentedControlStyle = UISegmentedControlStyleBar;
    doneButton.tintColor = [UIColor blackColor];
    [doneButton addTarget:self action:@selector(dismissActionSheet:) forControlEvents:UIControlEventValueChanged];
    [actionSheet addSubview:doneButton];
    
    [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
    
    [actionSheet setBounds:CGRectMake(0, 0, 320, 485)];
    
    /*CGRect actionSheetFrame = actionSheet.frame;
    
    CGRect viewRect = self.view.frame;
    
    //This height does not need to be add to content Inset
    CGFloat unUsedHeight = viewRect.size.height - viewOffsetY - self.dataTable.frame.size.height;
    
    CGFloat contentInsetsHeight = (480 - actionSheetFrame.origin.y) - unUsedHeight;
    
    CGRect frame = self.dataTable.frame;
    frame.size.height -= contentInsetsHeight;
    
    self.dataTable.frame = frame;
    
    [self.dataTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];*/
}

- (void) showDatePicker
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:nil
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil];
    
    [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    
    
    
    CGRect pickerFrame = CGRectMake(0, 30, 0, 0);
    
    UIDatePicker *pickerView = [[UIDatePicker alloc] initWithFrame:pickerFrame];
    
    NSString *dateString = self.activeField.text;
    if (![dateString isEqualToString:@""]) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        @try
        {
            [dateFormatter setDateFormat:@"MM/dd/yyyy"];
            NSDate *dateValue = [dateFormatter dateFromString:dateString];
            [pickerView setDate: dateValue];
        }
        @catch(NSException *ex)
        {
            @try {
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                NSDate *dateValue = [dateFormatter dateFromString:dateString];
                [pickerView setDate: dateValue];
            }
            @catch (NSException *exception) {
                [dateFormatter setDateFormat:@"yyyy"];
                NSDate *dateValue = [dateFormatter dateFromString:dateString];
                [pickerView setDate: dateValue];
            }
        }
    }
    
    pickerView.datePickerMode = UIDatePickerModeDate;
    self.datePicker = pickerView;
    
    [actionSheet addSubview:self.datePicker];
    
    UISegmentedControl *doneButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Done"]];
    doneButton.momentary = YES;
    doneButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
    doneButton.segmentedControlStyle = UISegmentedControlStyleBar;
    doneButton.tintColor = [UIColor blackColor];
    [doneButton addTarget:self action:@selector(dismissActionSheet:) forControlEvents:UIControlEventValueChanged];
    [actionSheet addSubview:doneButton];
    
    [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
    
    [actionSheet setBounds:CGRectMake(0, 0, 320, 485)];
    
    /*CGRect actionSheetFrame = actionSheet.frame;
    
    CGRect viewRect = self.view.frame;
    
    //This height does not need to be add to content Inset
    CGFloat unUsedHeight = viewRect.size.height - viewOffsetY - self.dataTable.frame.size.height;
    
    CGFloat contentInsetsHeight = (480 - actionSheetFrame.origin.y) - unUsedHeight;
    
    CGRect frame = self.dataTable.frame;
    frame.size.height -= contentInsetsHeight;
    
    self.dataTable.frame = frame;
    
    [self.dataTable scrollRectToVisible:self.activeField.frame animated:YES];*/
}

//=====================================GENERAL FUNC=====================================//
#pragma mark ----------General Function:
- (void)saveData
{
    for (int i = 0; i < numberOfRows; i++) {
        UITableViewCell *cell = [self.dataTable cellForRowAtIndexPath: [NSIndexPath indexPathForRow:i inSection:0]];
        Property * prop = [self.tableDataSource objectAtIndex:i];
        UITextField *valueField = (UITextField *)[cell.contentView subviews][1];
        prop.value = valueField.text;
        
    }
}

- (void) prepareDataSourceWithSInfFo:(NSString*) dsInfo_
{
    dsInfo = dsInfo_;
    [self prepareDataSource];
}

- (void) prepareDataSourceWithSInfFo:(NSString*) dsInfo_ WithIndexForEdit:(NSInteger) index_
{
    self.editIndex = index_;
    [self prepareDataSourceWithSInfFo:dsInfo_];
}

- (void) prepareDataSource
{
    
    NSMutableArray *propList;
    NSMutableArray *inputTypeList;
    

    if ([dsInfo isEqualToString:@"BI"])
    {
        propList = self.targetAccount.basicInfo.propertyList;
        inputTypeList = self.targetAccount.basicInfo.inputTypeList;
        self.privacyDataSource = self.targetAccount.basicInfo.privacySettingList;
        cellHeight = bICellHeight;
    }
    else if ([dsInfo isEqualToString:@"WI"])
    {
        propList = self.targetAccount.workInfo.propertyList;
        inputTypeList = self.targetAccount.workInfo.inputTypeList;
        self.privacyDataSource = self.targetAccount.workInfo.privacySettingList;
        cellHeight = wICellHeight;
    }
    else if ([dsInfo isEqualToString:@"EI"])
    {
        propList = self.targetAccount.educationInfo.propertyList;
        inputTypeList = self.targetAccount.educationInfo.inputTypeList;
        self.privacyDataSource = self.targetAccount.educationInfo.privacySettingList;
        cellHeight = eICellHeight;
    }
    
    if (self.editIndex >=0) {
        Property * prop = [propList objectAtIndex:self.editIndex];
        propList = [prop value];
        cellHeight = bICellHeight;
    }
    
    self.tableDataSource = propList;
    self.inputTypeForTableDataSource = inputTypeList;
    
    numberOfRows = [self.tableDataSource count];
}

- (void) showBasicInfoData
{
    [self prepareDataSourceWithSInfFo:@"BI"];
}

- (void) showWorkInfoData
{
    [self prepareDataSourceWithSInfFo:@"WI"];
}

- (void) showEducationInfoData
{
    [self prepareDataSourceWithSInfFo:@"EI"];
}

- (BOOL) isShowForBasicInfoData
{
    return [dsInfo isEqualToString:@"BI"];
}

- (BOOL) isShowForWorkInfoData
{
    return [dsInfo isEqualToString:@"WI"];
}

- (BOOL) isShowForEducationInfoData
{
    return [dsInfo isEqualToString:@"EI"];
}

- (void) setFacebookAccountAsTargetAccount
{
    self.targetAccount = self.fbAccount;
}
- (void) setGooglePlusAccountAsTargetAccount
{
    self.targetAccount = self.gpAccount;
}

@end
