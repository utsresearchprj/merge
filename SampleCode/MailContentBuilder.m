//
//  MailContentBuilder.m
//  Social Network Privacy Management
//
//  Created by Cong Phap Bui on 24/09/2014.
//
//

#import "MailContentBuilder.h"

@implementation MailContentBuilder
@synthesize myAccoutData;

- (id) initWithData:(Account*) account
{
    self = [super init];
    if (self) {
        myAccoutData = account;
        [self prepareTemplateData];
    }
    return self;
}

- (void)prepareTemplateData
{
    self.rowDataFieldTemplate = @"[[ROW_DATA]]";
    self.dataTableFieldTemplate = @"[[DATA_TABLE]]";
    
    self.headerFieldTemplate = @"[[HEADER]]";
    self.contentKeyFieldTemplate = @"[[KEY]]";
    self.contentValueFieldTemplate = @"[[VALUE]]";
    self.contentPrivacyFieldTemplate = @"[[PRIVACY]]";
    self.rowSpanFieldTemplate = @"[[ROW_SPAN]]";
    
    NSURL *mailContentFile = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"MailContent" ofType:@"html"] isDirectory:NO];
    
    NSURL *mailDataTableFile = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"MailDataTable" ofType:@"html"] isDirectory:NO];
    
    NSURL *mailDataTableHeaderFile = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"MailDataTableHeader" ofType:@"html"] isDirectory:NO];
    
    NSURL *mailDataTableContentFile = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"MailDataTableContent" ofType:@"html"] isDirectory:NO];
    
    self.contentTemplate = [NSString stringWithContentsOfURL:mailContentFile encoding:NSUTF8StringEncoding error:nil];
    
    self.dataTableTemplate = [NSString stringWithContentsOfURL:mailDataTableFile encoding:NSUTF8StringEncoding error:nil];
    
    self.dataTableHeaderTemplate = [NSString stringWithContentsOfURL:mailDataTableHeaderFile encoding:NSUTF8StringEncoding error:nil];
    
    self.dataTableContentTemplate = [NSString stringWithContentsOfURL:mailDataTableContentFile encoding:NSUTF8StringEncoding error:nil];
}

- (NSString*) buildProfileMailContent
{
    NSString *mailContent = nil;
    
    NSString *mailContentDataTable = @"";
    
    NSString *bIDataTable = [self buildProfileBasicInfoDataTable];
    NSString *wIDataTable = [self buildProfileWorkInfoDataTable];
    NSString *eIDataTable = [self buildProfileEducationInfoDataTable];
    
    mailContentDataTable = [mailContentDataTable stringByAppendingString:bIDataTable];
    mailContentDataTable = [mailContentDataTable stringByAppendingString:@"<br/>"];
    mailContentDataTable = [mailContentDataTable stringByAppendingString:wIDataTable];
    mailContentDataTable = [mailContentDataTable stringByAppendingString:@"<br/>"];
    mailContentDataTable = [mailContentDataTable stringByAppendingString:eIDataTable];
    
    mailContent = [self.contentTemplate stringByReplacingOccurrencesOfString:self.dataTableFieldTemplate withString:mailContentDataTable];
    
    return mailContent;
}

- (NSString*) buildProfileEducationInfoDataTable
{
    NSString * eIRowData = @"";
    
    NSMutableArray *eduPropList = self.myAccoutData.educationInfo.propertyList;
    
    for (int i = 0; i < [eduPropList count]; i++)
    {
        Property *eduHistoryProp = [eduPropList objectAtIndex:i];
        self.headerTitle = eduHistoryProp.key;
        
        NSMutableArray *dataList = eduHistoryProp.value;
        NSString *privacyData = [self.myAccoutData.educationInfo.privacySettingList objectAtIndex:i];
        
        NSString * rowData = [self buildRowDataFromListData:dataList AndPrivacyData:privacyData DisplayPrivacyForEachRow:NO];
        eIRowData = [eIRowData stringByAppendingString:rowData];
    }
    
    NSString *eIDataTable = [self.dataTableTemplate stringByReplacingOccurrencesOfString:self.rowDataFieldTemplate withString:eIRowData];
    
    return eIDataTable;
}

- (NSString*) buildProfileWorkInfoDataTable
{
    NSString * wIRowData = @"";
    
    NSMutableArray *workPropList = self.myAccoutData.workInfo.propertyList;
    
    for (int i = 0; i < [workPropList count]; i++)
    {
        Property *workHistoryProp = [workPropList objectAtIndex:i];
        self.headerTitle = workHistoryProp.key;
        
        NSMutableArray *dataList = workHistoryProp.value;
        NSString *privacyData = [self.myAccoutData.workInfo.privacySettingList objectAtIndex:i];
        
        NSString * rowData = [self buildRowDataFromListData:dataList AndPrivacyData:privacyData DisplayPrivacyForEachRow:NO];
        
        wIRowData = [wIRowData stringByAppendingString:rowData];
    }
    
    NSString *wIDataTable = [self.dataTableTemplate stringByReplacingOccurrencesOfString:self.rowDataFieldTemplate withString:wIRowData];
    
    return wIDataTable;
}

- (NSString*) buildProfileBasicInfoDataTable
{
    NSString * bIRowData = @"";
    
    self.headerTitle = @"BASIC INFO";
    
    NSMutableArray *dataList = self.myAccoutData.basicInfo.propertyList;
    NSMutableArray *privacyData = self.myAccoutData.basicInfo.privacySettingList;
    
    bIRowData = [self buildRowDataFromListData:dataList AndPrivacyData:privacyData DisplayPrivacyForEachRow:YES];
    
    NSString *bIDataTable = [self.dataTableTemplate stringByReplacingOccurrencesOfString:self.rowDataFieldTemplate withString:bIRowData];
    
    return bIDataTable;
}

- (NSString*) buildRowDataFromListData:(NSMutableArray *) propList AndPrivacyData:(id)privacyData DisplayPrivacyForEachRow:(BOOL) isDisplayPrivacyForEachRow
{
    NSString *rowData = [self buildDataTableHeaderFrom:self.headerTitle];
    
    for (int i=0; i<[propList count];i++)
    {
        Property *prop = [propList objectAtIndex:i];
        NSString *key = [prop.key capitalizedString];
        NSString *value = prop.value;
        
        NSString *newRow = [self.dataTableContentTemplate copy];
        
        newRow = [newRow stringByReplacingOccurrencesOfString:self.contentKeyFieldTemplate withString:key];
        newRow = [newRow stringByReplacingOccurrencesOfString:self.contentValueFieldTemplate withString:value];
        if (isDisplayPrivacyForEachRow)
        {
            NSString *privacy = [privacyData objectAtIndex:i];
            newRow = [newRow stringByReplacingOccurrencesOfString:self.contentPrivacyFieldTemplate withString:privacy];
            newRow = [newRow stringByReplacingOccurrencesOfString:self.rowSpanFieldTemplate withString:[NSString stringWithFormat:@"%d",1]];
        }else
        {
            if (i == 0) {
                newRow = [newRow stringByReplacingOccurrencesOfString:self.contentPrivacyFieldTemplate withString:privacyData];
                newRow = [newRow stringByReplacingOccurrencesOfString:self.rowSpanFieldTemplate withString:[NSString stringWithFormat:@"%d",[propList count]]];
            }else{
                NSString *privacyField = @"<td rowspan='[[ROW_SPAN]]'>[[PRIVACY]]</td>";
                newRow = [newRow stringByReplacingOccurrencesOfString:privacyField withString:@""];
                newRow = [newRow stringByReplacingOccurrencesOfString:self.rowSpanFieldTemplate withString:[NSString stringWithFormat:@"%d",1]];
            }
        }

        rowData = [rowData stringByAppendingString:@"\n"];
        rowData = [rowData stringByAppendingString:newRow];
    }
    return rowData;
}

- (NSString *) buildDataTableHeaderFrom:(NSString*)headerTitle
{
    NSString *headerRow = [self.dataTableHeaderTemplate stringByReplacingOccurrencesOfString:self.headerFieldTemplate withString:headerTitle];
    return headerRow;
}

@end
