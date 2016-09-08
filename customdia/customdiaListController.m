//
//  customdiaListController.m
//  customdia
//
//  Created by maximehip on 13.07.2015.
//  Copyright (c) 2015 maximehip. All rights reserved.
//

#import "customdiaListController.h"

@implementation customdiaListController

- (id)specifiers {
	if (_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"customdia" target:self] retain];
	}
    
	return _specifiers;
}

@end
