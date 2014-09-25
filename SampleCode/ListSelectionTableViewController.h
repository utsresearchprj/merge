//
//  ListSelectionTableViewController.h
//  Social Network Privacy Management
//
//  Created by Cong Phap Bui on 23/09/2014.
//
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
//#import "Account.h"

@interface ListSelectionTableViewController : UITableViewController

@property (strong,nonatomic) NSMutableArray * dataList;
@property (strong,nonatomic) NSMutableDictionary * noticeList;
@property (assign,nonatomic) NSInteger currentSelection;
@property (strong,nonatomic) NSMutableArray *settingList;
@property (assign,nonatomic) NSInteger indexInSettingList;
@property (strong,nonatomic) NSString * noticeText;
- (void) prepareDataList:(NSMutableArray *)dataList_ AndNoticeList: (NSMutableDictionary*)noticeList_ WithSettingList:(NSMutableArray *)settingList AtIndex: (NSInteger) index;
@end
