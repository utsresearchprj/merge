//
//  ListSelectionTableViewController.m
//  Social Network Privacy Management
//
//  Created by Cong Phap Bui on 23/09/2014.
//
//

#import "ListSelectionTableViewController.h"

@interface ListSelectionTableViewController ()

@end

@implementation ListSelectionTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSString *className = NSStringFromClass([self.view class]);
        NSLog(@"%@",className);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.dataList count];
}


- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    CGFloat result = 30.0f;

    return result;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CGFloat footerHeight = 80;

    return footerHeight;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    CGFloat viewHeight = 60;
    
    CGFloat viewWidth = tableView.frame.size.width-20;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 10, viewWidth, viewHeight)];
    
    [view setBackgroundColor:[UIColor lightGrayColor]];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:view.frame];
    
    [scrollView setScrollEnabled:YES];
    [scrollView setUserInteractionEnabled:YES];
    scrollView.showsVerticalScrollIndicator=YES;
    scrollView.contentSize = CGSizeMake(viewWidth, 500);
    scrollView.backgroundColor = [UIColor whiteColor];
    
    UILabel * info = [[UILabel alloc] init];
    info.textColor = [UIColor redColor];
    [info setLineBreakMode: NSLineBreakByWordWrapping];

    info.text=self.noticeText;
    
    [info setNumberOfLines: 0];
    info.frame = CGRectMake(10, 0, viewWidth-20, 400);
    [info sizeToFit];
    
    [scrollView addSubview:info];
    
    [view addSubview:scrollView];
    
    return view;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 30)];
    [label setFont:[UIFont boldSystemFontOfSize:15]];
    NSString *string = @"Select: ";

    
    /* Section header is in 0th index... */
    [label setText:string];
    
    [view addSubview:label];
    
    [view setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:1]]; //your background color...
    
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    static NSString *TableViewCellIdentifier = @"ListSelectionTableViewCell";

    cell = [tableView dequeueReusableCellWithIdentifier:TableViewCellIdentifier];
    if (cell == nil){
        //initialize the cell view from the xib file
        //NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:TableViewCellIdentifier
        //                                             owner:self options:nil];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableViewCellIdentifier];
    
    }
    //NSString * ListSelectionTableCellIdentifier = @"ListSelectionTableCell";
    
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ListSelectionTableCellIdentifier forIndexPath:indexPath];
    
    /*if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ListSelectionTableCellIdentifier];
    }*/
    
    NSString * cellText = [self.dataList objectAtIndex:indexPath.row];
    
    cell.textLabel.text = cellText;
    
    cell.accessoryType = (indexPath.row==self.currentSelection) ? UITableViewCellAccessoryCheckmark :UITableViewCellAccessoryNone;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.currentSelection == indexPath.row) {
        return;
    }
    
    [[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentSelection inSection:0]] setAccessoryType:UITableViewCellAccessoryNone];
    self.currentSelection = indexPath.row;
    [[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentSelection inSection:0]] setAccessoryType:UITableViewCellAccessoryCheckmark];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.settingList removeObjectAtIndex:self.indexInSettingList];
    NSString * settingValue = [self.dataList objectAtIndex:indexPath.row];
    [self.settingList insertObject:settingValue atIndex:self.indexInSettingList];
    self.noticeText = [self.noticeList objectForKey: settingValue];
    [tableView reloadData];
}


- (void) prepareDataList:(NSMutableArray *)dataList_ AndNoticeList: (NSMutableDictionary*)noticeList_ WithSettingList:(NSMutableArray *)settingList_ AtIndex: (NSInteger) indexInSettingList_
{
    self.dataList = dataList_;
    self.noticeList = noticeList_;
    self.settingList = settingList_;
    self.indexInSettingList = indexInSettingList_;
    NSString * currentValue = [self.settingList objectAtIndex:self.indexInSettingList];
    self.currentSelection = [self.dataList indexOfObject:currentValue];
    self.noticeText = [self.noticeList objectForKey: currentValue];
}

@end
