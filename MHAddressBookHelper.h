//
//  MHAddressBookHelper.h
//  Sale
//
//  Created by jc on 14-7-21.
//  Copyright (c) 2014年 jc. All rights reserved.
//

#import <Foundation/Foundation.h>
@import AddressBook;

@interface MHAddressBookHelper : NSObject

// Address Book Contacts
+ (void)accessAllPeople:(void (^)(NSArray *people))block;


//Transaction
+ (void)performAddressBookAction:(void (^)(ABAddressBookRef addressBookRef))block;


@end
