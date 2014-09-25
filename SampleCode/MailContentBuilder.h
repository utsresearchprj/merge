//
//  MailContentBuilder.h
//  Social Network Privacy Management
//
//  Created by Cong Phap Bui on 24/09/2014.
//
//

#import <Foundation/Foundation.h>
#import "Account.h"

@interface MailContentBuilder : NSObject

@property (strong,nonatomic) Account * myAccoutData;
@property (strong,nonatomic) NSString * contentTemplate;
@property (strong,nonatomic) NSString * dataTableTemplate;
@property (strong,nonatomic) NSString * dataTableHeaderTemplate;
@property (strong,nonatomic) NSString * dataTableContentTemplate;

@property (strong,nonatomic) NSString *rowDataFieldTemplate;
@property (strong,nonatomic) NSString *dataTableFieldTemplate;

@property (strong,nonatomic) NSString *headerFieldTemplate;
@property (strong,nonatomic) NSString *contentKeyFieldTemplate;
@property (strong,nonatomic) NSString *contentValueFieldTemplate;
@property (strong,nonatomic) NSString *contentPrivacyFieldTemplate;
@property (strong,nonatomic) NSString *rowSpanFieldTemplate;

@property (strong,nonatomic) NSString *headerTitle;

- (id) initWithData:(Account*) account;

- (NSString*) buildProfileMailContent;

@end
