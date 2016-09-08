//
//  customdiaListController.m
//  customdia
//
//  Created by maximehip on 13.07.2015.
//  Copyright (c) 2015 maximehip. All rights reserved.
//

#import "CreditsListController.h"

@implementation CreditsListController

- (id)specifiers {
	if (_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"credit" target:self] retain];
	}
    
	return _specifiers;
}

-(void) openTwitter
{
    NSString *user = @"maximehip";
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetbot:"]])
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tweetbot:///user_profile/" stringByAppendingString:user]]];
	else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitterrific:"]])
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"twitterrific:///profile?screen_name=" stringByAppendingString:user]]];
	else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetings:"]])
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tweetings:///user?screen_name=" stringByAppendingString:user]]];
	else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter:"]])
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"twitter://user?screen_name=" stringByAppendingString:user]]];
	else
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"https://mobile.twitter.com/" stringByAppendingString:user]]];
}

-(void) sendEmail
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:imax-my@live.fr?subject=CustomDia"]];
}

-(void) openTwitterAn
{
    NSString *user = @"An1sn0w";
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetbot:"]])
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tweetbot:///user_profile/" stringByAppendingString:user]]];
	else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitterrific:"]])
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"twitterrific:///profile?screen_name=" stringByAppendingString:user]]];
	else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetings:"]])
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tweetings:///user?screen_name=" stringByAppendingString:user]]];
	else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter:"]])
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"twitter://user?screen_name=" stringByAppendingString:user]]];
	else
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"https://mobile.twitter.com/" stringByAppendingString:user]]];
}

-(void) openTwitterSup
{
    NSString *user = @"SuperMaXAleX";
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetbot:"]])
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tweetbot:///user_profile/" stringByAppendingString:user]]];
	else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitterrific:"]])
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"twitterrific:///profile?screen_name=" stringByAppendingString:user]]];
	else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetings:"]])
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tweetings:///user?screen_name=" stringByAppendingString:user]]];
	else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter:"]])
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"twitter://user?screen_name=" stringByAppendingString:user]]];
	else
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"https://mobile.twitter.com/" stringByAppendingString:user]]];
}


@end
