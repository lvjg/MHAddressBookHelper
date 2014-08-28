//
//  MHRecordHelper.m
//  Sale
//
//  Created by jc on 14-7-21.
//  Copyright (c) 2014年 jc. All rights reserved.
//

#import "MHRecordHelper.h"

@implementation MHRecordHelper

#pragma mark utilities
+ (NSString *) localizedPropertyName: (ABPropertyID) aProperty
{
	return (__bridge_transfer NSString *)ABPersonCopyLocalizedPropertyName(aProperty);
}

+ (ABPropertyType) propertyType: (ABPropertyID) aProperty
{
	return ABPersonGetTypeOfProperty(aProperty);
}

+ (BOOL) propertyIsMultivalue: (ABPropertyID) aProperty;
{
	if (aProperty == kABPersonFirstNameProperty) return NO;
	if (aProperty == kABPersonMiddleNameProperty) return NO;
	if (aProperty == kABPersonLastNameProperty) return NO;
    
	if (aProperty == kABPersonPrefixProperty) return NO;
	if (aProperty == kABPersonSuffixProperty) return NO;
	if (aProperty == kABPersonNicknameProperty) return NO;
    
	if (aProperty == kABPersonFirstNamePhoneticProperty) return NO;
	if (aProperty == kABPersonMiddleNamePhoneticProperty) return NO;
	if (aProperty == kABPersonLastNamePhoneticProperty) return NO;
    
	if (aProperty == kABPersonOrganizationProperty) return NO;
	if (aProperty == kABPersonJobTitleProperty) return NO;
	if (aProperty == kABPersonDepartmentProperty) return NO;
    
	if (aProperty == kABPersonNoteProperty) return NO;
	
	if (aProperty == kABPersonKindProperty) return NO;
    
	if (aProperty == kABPersonBirthdayProperty) return NO;
	if (aProperty == kABPersonCreationDateProperty) return NO;
	if (aProperty == kABPersonModificationDateProperty) return NO;
	
	return YES;
	/*
     if (aProperty == kABPersonEmailProperty) return YES;
     if (aProperty == kABPersonAddressProperty) return YES;
     if (aProperty == kABPersonDateProperty) return YES;
     if (aProperty == kABPersonPhoneProperty) return YES;
     if (aProperty == kABPersonInstantMessageProperty) return YES;
     if (aProperty == kABPersonURLProperty) return YES;
     if (aProperty == kABPersonRelatedNamesProperty) return YES;
	 */
}



+ (id) objectForProperty: (ABPropertyID) anID inRecord: (ABRecordRef) record
{
	return (__bridge_transfer id) ABRecordCopyValue(record, anID);
}

#pragma mark Record ID and Type
+ (ABRecordID) recordID:(ABRecordRef)record {return ABRecordGetRecordID(record);}
+ (ABRecordType) recordType:(ABRecordRef)record {return ABRecordGetRecordType(record);}
+ (BOOL) isPerson:(ABRecordRef)record {return [self recordType:record] == kABPersonType;}

#pragma mark Getting Single Value Strings
+ (NSString *) getRecordString:(ABPropertyID) anID inRecord: (ABRecordRef) record
{
	return (__bridge_transfer NSString *) ABRecordCopyValue(record, anID);
}
+ (NSString *) firstname:(ABRecordRef)record {return [self getRecordString:kABPersonFirstNameProperty inRecord:record];}
+ (NSString *) middlename:(ABRecordRef)record {return [self getRecordString:kABPersonMiddleNameProperty inRecord:record];}
+ (NSString *) lastname:(ABRecordRef)record {return [self getRecordString:kABPersonLastNameProperty inRecord:record];}

+ (NSString *) prefix:(ABRecordRef)record {return [self getRecordString:kABPersonPrefixProperty inRecord:record];}
+ (NSString *) suffix:(ABRecordRef)record {return [self getRecordString:kABPersonSuffixProperty inRecord:record];}
+ (NSString *) nickname:(ABRecordRef)record {return [self getRecordString:kABPersonNicknameProperty inRecord:record];}

+ (NSString *) firstnamephonetic:(ABRecordRef)record {return [self getRecordString:kABPersonFirstNamePhoneticProperty inRecord:record];}
+ (NSString *) middlenamephonetic:(ABRecordRef)record {return [self getRecordString:kABPersonMiddleNamePhoneticProperty inRecord:record];}
+ (NSString *) lastnamephonetic:(ABRecordRef)record {return [self getRecordString:kABPersonLastNamePhoneticProperty inRecord:record];}

+ (NSString *) organization:(ABRecordRef)record {return [self getRecordString:kABPersonOrganizationProperty inRecord:record];}
+ (NSString *) jobtitle:(ABRecordRef)record {return [self getRecordString:kABPersonJobTitleProperty inRecord:record];}
+ (NSString *) department:(ABRecordRef)record {return [self getRecordString:kABPersonDepartmentProperty inRecord:record];}
+ (NSString *) note:(ABRecordRef)record {return [self getRecordString:kABPersonNoteProperty inRecord:record];}

#pragma mark Contact Name Utility

+ (NSString *) contactName:(ABRecordRef)record
{
    if (record) {
        NSMutableArray *stringArray = [NSMutableArray array];
        
        NSString* prefix = [self prefix:record];
        if (prefix.length) {
            
            [stringArray addObject:prefix];
        }
        
        NSString* firstname = [self firstname:record];
        if (firstname) {
            [stringArray addObject:firstname];
        }
        
        NSString* lastname = [self lastname:record];
        if (lastname) {
            [stringArray addObject:lastname];
        }
        
        NSString* suffix = [self suffix:record];
        
        if (suffix) {
            [stringArray addObject:suffix];
        }
        
        if (stringArray.count > 0) {
            return [stringArray componentsJoinedByString:@" "];
        }
        else{
            
            NSString* nickname = [self nickname:record];
            if (nickname) {
                return nickname;
            }
        }
    }
    
    return nil;
    
}

+ (NSString *) compositeName:(ABRecordRef)record
{
	NSString *string = (__bridge_transfer NSString *)ABRecordCopyCompositeName(record);
	return string;
}

#pragma mark NUMBER
+ (NSNumber *) getRecordNumber: (ABPropertyID) anID inRecord:(ABRecordRef)record
{
	return (__bridge_transfer NSNumber *)ABRecordCopyValue(record, anID);
}

+ (NSNumber *) kind:(ABRecordRef)record {return [self getRecordNumber:kABPersonKindProperty inRecord:record];}

#pragma mark Dates
+ (NSDate *) getRecordDate:(ABPropertyID) anID inRecord:(ABRecordRef)record
{
	return (__bridge_transfer NSDate *) ABRecordCopyValue(record, anID);
}

+ (NSDate *) birthday:(ABRecordRef)record {return [self getRecordDate:kABPersonBirthdayProperty inRecord:record];}
+ (NSDate *) creationDate:(ABRecordRef)record {return [self getRecordDate:kABPersonCreationDateProperty inRecord:record];}
+ (NSDate *) modificationDate:(ABRecordRef)record {return [self getRecordDate:kABPersonModificationDateProperty inRecord:record];}

#pragma mark Getting MultiValue Elements
+ (NSArray *) arrayForProperty: (ABPropertyID) anID inRecord:(ABRecordRef)record
{
	ABMultiValueRef theProperty = ABRecordCopyValue(record, anID);
    
    NSArray* items = nil;
    
    if (theProperty) {
        items = (__bridge_transfer NSArray *)ABMultiValueCopyArrayOfAllValues(theProperty);
        
        CFRelease(theProperty);
    }
    
	return items;
}

+ (NSArray *) labelsForProperty: (ABPropertyID) anID inRecord:(ABRecordRef)record
{
	ABMultiValueRef theProperty = ABRecordCopyValue(record, anID);
	NSMutableArray *labels = [NSMutableArray array];
	for (int i = 0; i < ABMultiValueGetCount(theProperty); i++)
	{
		NSString *label = (__bridge_transfer NSString *)ABAddressBookCopyLocalizedLabel( ABMultiValueCopyLabelAtIndex(theProperty, i));
		[labels addObject:label];
	}
    
    if (theProperty) {
        CFRelease(theProperty);
    }
    
	return labels;
}

+ (NSArray *) emailArray:(ABRecordRef)record {return [self arrayForProperty:kABPersonEmailProperty inRecord:record];}
+ (NSArray *) emailLabels:(ABRecordRef)record {return [self labelsForProperty:kABPersonEmailProperty inRecord:record];}
+ (NSArray *) phoneArray:(ABRecordRef)record {return [self arrayForProperty:kABPersonPhoneProperty inRecord:record];}
+ (NSArray *) phoneLabels:(ABRecordRef)record {return [self labelsForProperty:kABPersonPhoneProperty inRecord:record];}
+ (NSArray *) relatedNameArray:(ABRecordRef)record {return [self arrayForProperty:kABPersonRelatedNamesProperty inRecord:record];}
+ (NSArray *) relatedNameLabels:(ABRecordRef)record {return [self labelsForProperty:kABPersonRelatedNamesProperty inRecord:record];}
+ (NSArray *) urlArray:(ABRecordRef)record {return [self arrayForProperty:kABPersonURLProperty inRecord:record];}
+ (NSArray *) urlLabels:(ABRecordRef)record {return [self labelsForProperty:kABPersonURLProperty inRecord:record];}
+ (NSArray *) dateArray:(ABRecordRef)record {return [self arrayForProperty:kABPersonDateProperty inRecord:record];}
+ (NSArray *) dateLabels:(ABRecordRef)record {return [self labelsForProperty:kABPersonDateProperty inRecord:record];}
+ (NSArray *) addressArray:(ABRecordRef)record {return [self arrayForProperty:kABPersonAddressProperty inRecord:record];}
+ (NSArray *) addressLabels:(ABRecordRef)record {return [self labelsForProperty:kABPersonAddressProperty inRecord:record];}
+ (NSArray *) instantMessageArray:(ABRecordRef)record {return [self arrayForProperty:kABPersonInstantMessageProperty inRecord:record];}


+ (NSDictionary *) addressWithStreet: (NSString *) street withCity: (NSString *) city
						   withState:(NSString *) state withZip: (NSString *) zip
						 withCountry: (NSString *) country withCode: (NSString *) code
{
	NSMutableDictionary *md = [NSMutableDictionary dictionary];
	if (street) [md setObject:street forKey:(NSString *) kABPersonAddressStreetKey];
	if (city) [md setObject:city forKey:(NSString *) kABPersonAddressCityKey];
	if (state) [md setObject:state forKey:(NSString *) kABPersonAddressStateKey];
	if (zip) [md setObject:zip forKey:(NSString *) kABPersonAddressZIPKey];
	if (country) [md setObject:country forKey:(NSString *) kABPersonAddressCountryKey];
	if (code) [md setObject:code forKey:(NSString *) kABPersonAddressCountryCodeKey];
	return md;
}

+ (NSDictionary *) IMWithService: (NSString*)service andUserName: (NSString *) userName
{
	NSMutableDictionary *im = [NSMutableDictionary dictionary];
	if (service) [im setObject:service forKey:(__bridge NSString *) kABPersonInstantMessageServiceKey];
	if (userName) [im setObject:userName forKey:(__bridge NSString *) kABPersonInstantMessageUsernameKey];
	return im;
}

@end
