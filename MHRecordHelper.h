//
//  MHRecordHelper.h
//  Sale
//
//  Created by jc on 14-7-21.
//  Copyright (c) 2014年 jc. All rights reserved.
//

#import <Foundation/Foundation.h>
@import AddressBook;

@interface MHRecordHelper : NSObject

#pragma mark Record ID and Type
+ (ABRecordID) recordID:(ABRecordRef)record;
+ (ABRecordType) recordType:(ABRecordRef)record;
+ (BOOL) isPerson:(ABRecordRef)record;

#pragma mark Getting Single Value Strings
+ (NSString *) contactName:(ABRecordRef)record;
+ (NSString *) firstname:(ABRecordRef)record;
+ (NSString *) compositeName:(ABRecordRef)record;
+ (NSString *) nickname:(ABRecordRef)record;

+ (NSString *) organization:(ABRecordRef)record;
+ (NSString *) jobtitle:(ABRecordRef)record;
+ (NSString *) department:(ABRecordRef)record;
+ (NSString *) note:(ABRecordRef)record;

+ (NSArray *) emailArray:(ABRecordRef)record;
+ (NSArray *) emailLabels:(ABRecordRef)record;
+ (NSArray *) phoneArray:(ABRecordRef)record;
+ (NSArray *) phoneLabels:(ABRecordRef)record;
+ (NSArray *) addressArray:(ABRecordRef)record;
+ (NSArray *) addressLabels:(ABRecordRef)record;
+ (NSArray *) instantMessageArray:(ABRecordRef)record;


+ (NSDictionary *) addressWithStreet: (NSString *) street
                            withCity: (NSString *) city
						   withState: (NSString *) state
                             withZip: (NSString *) zip
						 withCountry: (NSString *) country
                            withCode: (NSString *) code;

+ (NSDictionary *) IMWithService: (NSString*)service andUserName: (NSString *) userName;


@end
