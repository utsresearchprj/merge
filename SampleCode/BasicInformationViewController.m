//
//  BasicInformationViewController.m
//  Social Network Privacy Management
//
//  Created by Cong Phap Bui on 19/09/2014.
//
//

#import "BasicInformationViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface BasicInformationViewController ()

@end

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
static CGFloat cellHeight = 65.0f;
static const CGFloat bICellHeight = 65;
static const CGFloat wICellHeight = 155;
static const CGFloat eICellHeight = 155;

//static int numberOfRows = 0;
=======
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
static const CGFloat cellHeight = 65.0f;

static int numberOfRows = 0;
static int numberOfPages = 1;
<<<<<<< HEAD
<<<<<<< HEAD
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD

static const CGFloat headerHeight = 30;
static const CGFloat footerHeight = 30;

static const CGFloat viewOffsetY = 70;

static int const genderCount = 3;
static NSString* const gender[] = {@"Male", @"Female", @"Custom"};

static int const relationshipCount = 4;
static NSString* const relationship[] = {@"Single", @"Married", @"In relationship", @"In open relationship"};

static int const schoolTypeCount = 3;
static NSString* const schoolType[] = {@"College",@"University",@"High school"};

@implementation BasicInformationViewController
@synthesize fbAccount;
@synthesize dsInfo;
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
@synthesize numberOfRows;
=======

>>>>>>> FETCH_HEAD
=======

>>>>>>> FETCH_HEAD
=======

>>>>>>> FETCH_HEAD

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //dsInfo = nibNameOrNil;
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        self.fbAccount = delegate.fbAccount;
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
        self.editIndex = -1;
=======
        self.pageNumber = 0;
>>>>>>> FETCH_HEAD
=======
        self.pageNumber = 0;
>>>>>>> FETCH_HEAD
=======
        self.pageNumber = 0;
>>>>>>> FETCH_HEAD
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
    //[self prepareDataSource];
    //self.view.backgroundColor = [UIColor lightGrayColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    CGFloat tableHeight = numberOfRows*cellHeight + headerHeight + footerHeight;
    if (tableHeight > 360) {
        tableHeight = 360;
=======
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
    
    //self.view.backgroundColor = [UIColor lightGrayColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    CGFloat tableHeight = numberOfRows*cellHeight + headerHeight + footerHeight;
    if (tableHeight > 380) {
        tableHeight = 380;
<<<<<<< HEAD
<<<<<<< HEAD
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
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

//===============================Keyboard===============================//

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
    frame.size.height = 380;
    
    self.dataTable.frame = frame;
    
}

//===============================UITextField===============================//

- (void)textFieldDidBeginEditing:(UITextField *) textField

{
    self.activeField = textField;
    CGFloat offsetY = CGRectGetMinY(self.activeField.superview.superview.superview.frame);
    offsetY -= 30;
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
    NSString *className = NSStringFromClass([self.activeField.superview.superview class]);
    NSLog(@"%@",className);
    
    className = NSStringFromClass([self.activeField.superview class]);
    NSLog(@"%@",className);
    
    className = NSStringFromClass([self.activeField.superview.superview.superview class]);
    NSLog(@"%@",className);
    
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
    [self.dataTable setContentOffset:CGPointMake(0.0, offsetY) animated:YES];
    
    if (textField.tag != KeyboardType && textField.tag != DatePickerType)
    {
        [self preparePickerDataForType:textField.tag];
        [self showPicker];
    }
    else if (textField.tag == DatePickerType)
    {
        [self showDatePicker];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField

{
    self.activeField = nil;
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
    [self.activeField resignFirstResponder];
    [self saveData];
=======
    //[self.activeField resignFirstResponder];
>>>>>>> FETCH_HEAD
=======
    //[self.activeField resignFirstResponder];
>>>>>>> FETCH_HEAD
=======
    //[self.activeField resignFirstResponder];
>>>>>>> FETCH_HEAD
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
    [self saveData];
    return YES;
}
#pragma UITableView
=======
    return YES;
}

>>>>>>> FETCH_HEAD
=======
    return YES;
}

>>>>>>> FETCH_HEAD
=======
    return YES;
}

>>>>>>> FETCH_HEAD
//===============================UITableView===============================//

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
    [self prepareDataSource];
=======

>>>>>>> FETCH_HEAD
=======

>>>>>>> FETCH_HEAD
=======

>>>>>>> FETCH_HEAD
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

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
=======
- (CGFloat) tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section{
>>>>>>> FETCH_HEAD
=======
- (CGFloat) tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section{
>>>>>>> FETCH_HEAD
=======
- (CGFloat) tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section{
>>>>>>> FETCH_HEAD
    
    CGFloat result = 0.0f;
    if ([tableView isEqual:self.dataTable]){
        result = headerHeight;
    }
    return result;
}

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
=======
- (CGFloat) tableView:(UITableView *)tableView
heightForFooterInSection:(NSInteger)section{
>>>>>>> FETCH_HEAD
=======
- (CGFloat) tableView:(UITableView *)tableView
heightForFooterInSection:(NSInteger)section{
>>>>>>> FETCH_HEAD
=======
- (CGFloat) tableView:(UITableView *)tableView
heightForFooterInSection:(NSInteger)section{
>>>>>>> FETCH_HEAD
    
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
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD

=======
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
    if (numberOfPages > 1) {
        for (int i=0; i<numberOfPages; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            [button setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
            button.frame = CGRectMake(20+(i*30), 0, 50, 30);
            [button addTarget:self action:@selector(goToPage:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:button];
        }
    }
<<<<<<< HEAD
<<<<<<< HEAD
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
    return view;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 30)];
    [label setFont:[UIFont boldSystemFontOfSize:15]];
    NSString *string;
    if ([dsInfo isEqualToString:@"BI"]) {
        string = @"BASIC INFO";
    }else if ([dsInfo isEqualToString:@"WI"]){
        string = @"WORK HISTORY";
    }else if ([dsInfo isEqualToString:@"EI"]){
        string = @"EDUCATION";
    }

    /* Section header is in 0th index... */
    [label setText:string];
    
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
    [view addSubview:label];
=======
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
    UIButton *edit = [UIButton buttonWithType:UIButtonTypeSystem];
    
    self.editBtn = edit;
    
    [self.editBtn addTarget:self action:@selector(saveData:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.editBtn setTitle:@"Save" forState:UIControlStateNormal];
    self.editBtn.frame = CGRectMake(230, 0, 50, 30);
    
    [view addSubview:label];
    [view addSubview:self.editBtn];
<<<<<<< HEAD
<<<<<<< HEAD
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
    
    [view setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:1]]; //your background color...
    
    return view;
}

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
=======
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
>>>>>>> FETCH_HEAD
=======
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
>>>>>>> FETCH_HEAD
=======
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
>>>>>>> FETCH_HEAD

    if ([tableView isEqual:self.dataTable]){
        return numberOfRows;
    }
    return 0;
}

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
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
            
            UIButton *privacySetting = [self privacyButtonForDataAtIndex:indexPath.row WithFrame:btnFrame];
            
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
            UIButton *privacySetting = [self privacyButtonForDataAtIndex:indexPath.row WithFrame:btnFrame];
            
            btnFrame.origin.y += 50;
            btnFrame.origin.x += 10;
            UIButton *edit = [self editButtonForDataAtIndex:indexPath.row WithFrame:btnFrame];
            
            btnFrame.origin.y += 30;
            UIButton *delete = [self deleteButtonForDataAtIndex:indexPath.row WithFrame:btnFrame];
            
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
                    
                    if (!endDate)
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
            UIButton *privacySetting = [self privacyButtonForDataAtIndex:indexPath.row WithFrame:btnFrame];

            
            btnFrame.origin.y += 50;
            btnFrame.origin.x += 30;
            UIButton *edit = [self editButtonForDataAtIndex:indexPath.row WithFrame:btnFrame];
            
            btnFrame.origin.y += 30;
            UIButton *delete = [self deleteButtonForDataAtIndex:indexPath.row WithFrame:btnFrame];
            
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
    
    /*UITableViewCell *cell = nil;
    
    if ([tableView isEqual:self.dataTable]){
        
        static NSString *TableViewCellIdentifier = @"ProfileDataTableViewCell";
        
        //this method dequeues an existing cell if one is available or creates a new one
        //if no cell is available for reuse, this method returns nil
        cell = [tableView dequeueReusableCellWithIdentifier:TableViewCellIdentifier];
        if (cell == nil){
            //initialize the cell view from the xib file
            //NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:TableViewCellIdentifier
             //                                             owner:self options:nil];
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableViewCellIdentifier];
            //cell.frame = CGRectMake(0, indexPath.row * cellHeight, tableView.frame.size.width, cellHeight);
            cell.backgroundColor = [UIColor whiteColor];
            
            UILabel *keyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 160, 30)];
            keyLabel.font = [UIFont systemFontOfSize:15];
            keyLabel.textColor = [UIColor redColor];
            
            UITextField *valueField = [[UITextField alloc] initWithFrame:CGRectMake(10, 30, 280, 30)];
            valueField.borderStyle = UITextBorderStyleRoundedRect;
            valueField.font = [UIFont systemFontOfSize:14];
            valueField.autocorrectionType = UITextAutocorrectionTypeNo;

            valueField.returnKeyType = UIReturnKeyDone;
            
            UIButton *privacySetting = [UIButton buttonWithType:UIButtonTypeRoundedRect];

            privacySetting.frame = CGRectMake(180, 1, 100, 28);
            
            privacySetting.titleLabel.font = [UIFont systemFontOfSize:13];
            
            [privacySetting addTarget:self action:@selector(selectPrivacySetting:) forControlEvents:UIControlEventTouchUpInside];
            
            UIImage * img = [UIImage imageNamed:@"drop_down.png"];
            
            [privacySetting setImage:img forState:UIControlStateNormal];
            
            privacySetting.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            
            keyLabel.tag = KEY_TAG;
            valueField.tag = VALUE_TAG;
            privacySetting.tag = indexPath.row;
            
            [cell.contentView addSubview:keyLabel];
            [cell.contentView addSubview:valueField];
            [cell.contentView addSubview:privacySetting];
        }
        
        UILabel * keyLabel = (UILabel *)[cell.contentView subviews][0];
        UITextField * valueField = (UITextField *)[cell.contentView subviews][1];
        UIButton * privacySetting = (UIButton *)[cell.contentView subviews][2];
        
        NSMutableArray *propList = self.tableDataSource;
        NSMutableArray *inputTypeList = self.inputTypeForTableDataSource;
        
        NSString *key = @"";
        NSString *value = @"";
        //NSString *privacy = @"Public";
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
        
        NSString *privacy = [self.privacyDataSource objectAtIndex:indexPath.row];
        [privacySetting setTitle:privacy forState:UIControlStateNormal];
    }
    
    return cell;*/
}

//======================================VIEW INIT======================================//
- (UIButton*) editButtonForDataAtIndex: (NSInteger)index
                                 WithFrame: (CGRect)frame
{
    UIButton *edit = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    edit.frame =frame;
    [edit setTitle:@"EDIT" forState:UIControlStateNormal];
    edit.titleLabel.font = [UIFont systemFontOfSize:13];
    edit.tag = index;
    edit.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    UIImage * editImg = [UIImage imageNamed:@"edit.png"];
    [edit setImage:editImg forState:UIControlStateNormal];
    [edit addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    return edit;
}

- (UIButton*) deleteButtonForDataAtIndex: (NSInteger)index
                             WithFrame: (CGRect)frame
{
    UIButton *delete = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    delete.frame = frame;
    [delete setTitle:@"DELETE" forState:UIControlStateNormal];
    delete.titleLabel.font = [UIFont systemFontOfSize:13];
    delete.tag = index;
    delete.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    UIImage * deleteImg = [UIImage imageNamed:@"delete.png"];
    [delete setImage:deleteImg forState:UIControlStateNormal];
    [delete addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
    return delete;
}

- (UIButton*) privacyButtonForDataAtIndex: (NSInteger)index
                             WithFrame: (CGRect)frame
{
    UIButton *privacySetting = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    privacySetting.frame = frame;
    privacySetting.titleLabel.font = [UIFont systemFontOfSize:13];
    [privacySetting addTarget:self action:@selector(selectPrivacySetting:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage * img = [UIImage imageNamed:@"drop_down.png"];
    [privacySetting setImage:img forState:UIControlStateNormal];
    privacySetting.tag = index;
    privacySetting.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    return privacySetting;
}


//======================================ACTION SHEET======================================//
#pragma UIActionSheet
=======
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
- (UITableViewCell *) tableView:(UITableView *)tableView
          cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%@",@"Render cell at a given Index Path Section and Row");
    BasicInformationViewCell *bICell = nil;
    
    if ([tableView isEqual:self.dataTable]){
        
        static NSString *TableViewCellIdentifier = @"BasicInformationViewCell";
        
        //this method dequeues an existing cell if one is available or creates a new one
        //if no cell is available for reuse, this method returns nil
        bICell = [tableView dequeueReusableCellWithIdentifier:TableViewCellIdentifier];
        if (bICell == nil){
            //initialize the cell view from the xib file
            NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"BasicInformationViewCell"
                                                          owner:self options:nil];
            bICell = (BasicInformationViewCell *)[nibs objectAtIndex:0];
        }
        
        NSMutableArray *propList = self.tableDataSource;
        NSMutableArray *inputTypeList = self.inputTypeForTableDataSource;
        
        //populate data from your country object to table view cell
        Property *prop = [propList objectAtIndex:indexPath.row];
        
        bICell.typeLabel.text = [[prop key] capitalizedString];
        bICell.valueLabel.text = [prop value];
        
        NSNumber *tagType = [inputTypeList objectAtIndex:indexPath.row];
        NSInteger tagValue = [tagType intValue];
        bICell.valueLabel.tag = tagValue;
        
        bICell.valueLabel.delegate = self;
        [bICell.valueLabel setReturnKeyType:UIReturnKeyDone];
    }
    return bICell;
}

//======================================ACTION SHEET======================================//
<<<<<<< HEAD
<<<<<<< HEAD
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
- (void) dismissActionSheet: (id)sender
{
    if (self.activeField.tag == DatePickerType) {
        NSDate *selectedDate = self.datePicker.date;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM/dd/yyyy"];
        self.activeField.text = [dateFormatter stringFromDate:selectedDate];
    }
    UIActionSheet *sheet = (UIActionSheet *)[(UISegmentedControl*)sender superview];
    
    [sheet dismissWithClickedButtonIndex:0 animated:YES];
    [self.activeField resignFirstResponder];
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
    [self saveData];
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
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
    NSInteger index = [self.pickerViewDataSource indexOfObject: [value capitalizedString]];
    
    [pickerView selectRow:index inComponent:0 animated:YES];
    
    [actionSheet addSubview:pickerView];
    
    //[pickerView release];
    
    UISegmentedControl *doneButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Done"]];
    doneButton.momentary = YES;
    doneButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
    doneButton.segmentedControlStyle = UISegmentedControlStyleBar;
    doneButton.tintColor = [UIColor blackColor];
    [doneButton addTarget:self action:@selector(dismissActionSheet:) forControlEvents:UIControlEventValueChanged];
    [actionSheet addSubview:doneButton];
    //[closeButton release];
    
    [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
    
    [actionSheet setBounds:CGRectMake(0, 0, 320, 485)];
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
    
    //[pickerView release];
    
    UISegmentedControl *doneButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Done"]];
    doneButton.momentary = YES;
    doneButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
    doneButton.segmentedControlStyle = UISegmentedControlStyleBar;
    doneButton.tintColor = [UIColor blackColor];
    [doneButton addTarget:self action:@selector(dismissActionSheet:) forControlEvents:UIControlEventValueChanged];
    [actionSheet addSubview:doneButton];
    //[closeButton release];
    
    [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
    
    [actionSheet setBounds:CGRectMake(0, 0, 320, 485)];
}

- (void) loadDSInfFo:(NSString*) dsInfo_
{
    dsInfo = dsInfo_;
    [self prepareDataSource];
}

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
- (void) loadDSInfFo:(NSString*) dsInfo_ WithIndexForEdit:(NSInteger) index_
{
    self.editIndex = index_;
    [self loadDSInfFo:dsInfo_];
}

=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
- (void) prepareDataSource
{
    
    NSMutableArray *propList;
    NSMutableArray *inputTypeList;
    
    //BasicInfo *info = self.fbAccount.basicInfo;
    if ([dsInfo isEqualToString:@"BI"])
    {
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
        //numberOfPages = 1;
        propList = self.fbAccount.basicInfo.propertyList;
        inputTypeList = self.fbAccount.basicInfo.inputTypeList;
        self.privacyDataSource = self.fbAccount.basicInfo.privacySettingList;
        cellHeight = bICellHeight;
    }
    else if ([dsInfo isEqualToString:@"WI"])
    {
        //numberOfPages = [self.fbAccount.workInfo.propertyList count];
        //Property * wiProp = [self.fbAccount.workInfo.propertyList objectAtIndex:self.pageNumber];
        //propList = [wiProp value];
        propList = self.fbAccount.workInfo.propertyList;
        inputTypeList = self.fbAccount.workInfo.inputTypeList;
        self.privacyDataSource = self.fbAccount.workInfo.privacySettingList;
        cellHeight = wICellHeight;
    }
    else if ([dsInfo isEqualToString:@"EI"])
    {
        //numberOfPages = [self.fbAccount.educationInfo.propertyList count];
        //Property * eiProp = [self.fbAccount.educationInfo.propertyList objectAtIndex:self.pageNumber];
        //propList = [eiProp value];
        propList = self.fbAccount.educationInfo.propertyList;
        inputTypeList = self.fbAccount.educationInfo.inputTypeList;
        self.privacyDataSource = self.fbAccount.educationInfo.privacySettingList;
        cellHeight = eICellHeight;
    }
    
    if (self.editIndex >=0) {
        Property * prop = [propList objectAtIndex:self.editIndex];
        propList = [prop value];
        cellHeight = bICellHeight;
=======
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
        numberOfPages = 1;
        propList = self.fbAccount.basicInfo.propertyList;
        inputTypeList = self.fbAccount.basicInfo.inputTypeList;
    }else if ([dsInfo isEqualToString:@"WI"])
    {
        numberOfPages = [self.fbAccount.workInfo.propertyList count];
        Property * wiProp = [self.fbAccount.workInfo.propertyList objectAtIndex:self.pageNumber];
        propList = [wiProp value];
        inputTypeList = self.fbAccount.workInfo.inputTypeList;
    }else if ([dsInfo isEqualToString:@"EI"])
    {
        numberOfPages = [self.fbAccount.educationInfo.propertyList count];
        Property * eiProp = [self.fbAccount.educationInfo.propertyList objectAtIndex:self.pageNumber];
        propList = [eiProp value];
        inputTypeList = self.fbAccount.educationInfo.inputTypeList;
<<<<<<< HEAD
<<<<<<< HEAD
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
    }
    
    self.tableDataSource = propList;
    self.inputTypeForTableDataSource = inputTypeList;
    
    numberOfRows = [self.tableDataSource count];
}

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
- (void)goToPage:(UIButton*)sender {
    
    NSString *page =[sender titleLabel].text;
    self.pageNumber = [page intValue]-1;
    [self prepareDataSource];
    [self.dataTable reloadData];
}

<<<<<<< HEAD
<<<<<<< HEAD
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
- (void)saveData
{
    for (int i = 0; i < numberOfRows; i++) {
        UITableViewCell *cell = [self.dataTable cellForRowAtIndexPath: [NSIndexPath indexPathForRow:i inSection:0]];
        Property * prop = [self.tableDataSource objectAtIndex:i];
        UITextField *valueField = (UITextField *)[cell.contentView subviews][1];
        prop.value = valueField.text;
        
    }
}

- (void)selectPrivacySetting:(UIButton*)sender
{
    ListSelectionTableViewController *controller = [[ListSelectionTableViewController alloc] initWithNibName:nil bundle:nil];
    
    NSMutableArray *settingList = self.privacyDataSource;
    
    [controller prepareDataList:self.fbAccount.privacyData.privacySettingList AndNoticeList:self.fbAccount.privacyData.privacyAwarenessList WithSettingList:settingList AtIndex:sender.tag];
    
    controller.navigationItem.title = @"Privacy";
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)edit:(UIButton*)sender
{
    NSInteger editIndex = sender.tag;
    
    NSString * info = dsInfo;
    
    BasicInformationViewController *controller =
    [[BasicInformationViewController alloc] initWithNibName:nil bundle:nil];
    
    [controller loadDSInfFo:info WithIndexForEdit:editIndex];
    
    controller.navigationItem.title = @"Edit";
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)delete:(UIButton*)sender
{
    NSInteger index = sender.tag;
    [self.tableDataSource removeObjectAtIndex:index];
    numberOfRows = [self.tableDataSource count];
    [self.dataTable reloadData];
}

=======
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
- (void)saveData:(UIButton*)sender {
    for (int i = 0; i < numberOfRows; i++) {
        BasicInformationViewCell *cell = (BasicInformationViewCell*)[self.dataTable cellForRowAtIndexPath: [NSIndexPath indexPathForRow:i inSection:0]];
        Property * prop = [self.tableDataSource objectAtIndex:i];
        prop.value = cell.valueLabel.text;
    }
}

<<<<<<< HEAD
<<<<<<< HEAD
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
@end
