//
//  MHAddressBookHelper.m
//  Sale
//
//  Created by jc on 14-7-21.
//  Copyright (c) 2014年 jc. All rights reserved.
//

#import "MHAddressBookHelper.h"

#define CFSafeRelease(obj) ({if(obj){CFRelease(obj); obj = NULL;}})

@implementation MHAddressBookHelper

// Address Book Contacts
+ (void)accessAllPeople:(void (^)(NSArray *people))block
{
    
    [self performAddressBookAction:^(ABAddressBookRef addressBookRef) {
       
        NSArray *people = (__bridge_transfer NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBookRef);
        
        if (block) {
            block(people);
        }
    }];

}


#pragma mark -
+(void)performAddressBookAction:(void (^)(ABAddressBookRef addressBookRef))block
{
    CFErrorRef error = nil;
    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL,&error);
    
    if (addressBookRef) {
        
        [self checkAddressBookAccess:addressBookRef actionBlock:block];
    }
    
    CFSafeRelease(addressBookRef);
}


#pragma mark -
#pragma mark Address Book Access
// Check the authorization status of our application for Address Book
+ (void)checkAddressBookAccess:(ABAddressBookRef)addressBookRef actionBlock:(void (^)(ABAddressBookRef addressBookRef))actionBlock
{
    switch (ABAddressBookGetAuthorizationStatus())
    {
            // Update our UI if the user has granted access to their Contacts
        case  kABAuthorizationStatusAuthorized:
            actionBlock(addressBookRef);
            break;
            
            // Prompt the user for access to Contacts if there is no definitive answer
        case  kABAuthorizationStatusNotDetermined :
            [self requestAddressBookAccess:addressBookRef actionBlock:actionBlock];
            break;
            
            // Display a message if the user has denied or restricted access to Contacts
        case  kABAuthorizationStatusDenied:
        case  kABAuthorizationStatusRestricted:
            break;
        default:
            break;
    }
}

// Prompt the user for access to their Address Book data
+ (void)requestAddressBookAccess:(ABAddressBookRef)addressBookRef actionBlock:(void (^)(ABAddressBookRef addressBookRef))actionBlock
{
    
    ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error)
                                             {
                                                 if (granted)
                                                 {
                                                     actionBlock(addressBookRef);
                                                 }
                                             });
}

@end
