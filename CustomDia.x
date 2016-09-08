//
//  CustomDia.x
//  CustomDia
//
//  Created by maximehip on 04.07.2015.
//  Copyright (c) 2015 maximehip. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <libShortcutItems/libShortcutItems.h>

static BOOL landscape = NO;
static BOOL nowarning = NO;
static BOOL hiddentweak = NO;
static BOOL noloading = NO;
static BOOL noback = NO;
static BOOL UseCustomLoading = NO;
static NSString* CustomLoading = @"Chargement";
static UIColor *hudcolor;
static int hudcolordc = 4;
static BOOL blackkey = NO;
static BOOL showSection = YES;
static BOOL showDesp = YES;
static BOOL enabled = YES;
static UIColor *backgroundColor;
static int bc = 13;
static BOOL shakeHome = YES;
static BOOL fullscreen = NO;

#define CYE_COLOR(val) [UIColor colorWithRed:((val >> 16) & 0xFF) / 255.0f green:((val >> 8) & 0xFF) / 255.0f blue:(val & 0xFF) / 255.0f alpha:1.0f]

#define PLIST_PATH @"/var/mobile/Library/Preferences/customdia.plist"

#define UIColorFromRGB(rgbValue) [UIColor \
       colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
       green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
       blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface Cydia
- (bool)requestUpdate;
@end

%hook UIWindow

-(bool)_shouldAutorotateToInterfaceOrientation:(long long)arg1 {
	if (landscape){
		return TRUE;
	}else 
	return %orig;
}
%end

%hook SourcesController

-(id) getWarning {
	if (nowarning){
		return NULL;
	}else{
		return %orig;
	}
}

%end

%hook Package

-(BOOL) uninstalled {
	if(hiddentweak){
		return TRUE;
	}else{
		return %orig;
	}
}

%end

%hook CydiaLoadingView

-(id)initWithFrame:(CGRect)arg1 {
	if (noloading){
		return NULL;
	}else{
		return %orig;
	}
}

%end

%hook HomeController

-(id)leftButton {
		UIBarButtonItem *origLeftButton; // = MSHookIvar<UIBarButtonItem *>(self, "button_");
	origLeftButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(aboutButtonClicked)] autorelease];
	UIGraphicsBeginImageContextWithOptions(CGSizeMake(10, 10), NO, 0.0);
	UIImage *blank = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	[origLeftButton setBackgroundImage:blank forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
	return origLeftButton;
}

-(void)aboutButtonClicked {
	 UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Hello World!"
                                                  message:@"Choose an action to do."
                                                 delegate:self
                                        cancelButtonTitle:@"Stop"
                                        otherButtonTitles:@"Respring", @"Refresh", nil];
[message show];
}

%new 
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
     
    if([title isEqualToString:@"Button 1"])
    {
        NSLog(@"Button 1 was selected.");
    }
    else if([title isEqualToString:@"Respring"])
    {
        system("killall -9 SpringBoard backboardd");
    }
    else if([title isEqualToString:@"Refresh"])
    {
        Cydia *cyAppDelegate = (Cydia *)[UIApplication sharedApplication];
	[cyAppDelegate requestUpdate];
    }
}

%new 
- (BOOL)canBecomeFirstResponder 
{ 
  return YES;
}

%new 
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{ 
  if (motion == UIEventSubtypeMotionShake  && shakeHome) 
  { 
    Cydia *cyAppDelegate = (Cydia *)[UIApplication sharedApplication];
	[cyAppDelegate requestUpdate];
  } 
}

%end

%hook UIView 

-(void) setTintColor:(id)arg1 {
	NSDictionary *settings = [[NSDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.maximehip.customdia.plist"];
	if (settings) {
		enabled = ([settings objectForKey:@"enabled"] ? [[settings objectForKey:@"enabled"] boolValue] : enabled);
        bc = ([settings objectForKey:@"bc"] ? [[settings objectForKey:@"bc"] intValue] : bc);
    }   
    switch (bc) {
		case 1:
			backgroundColor = [UIColor blackColor];
			break;
		case 2:
			backgroundColor = [UIColor blueColor];
			break;
		case 3:
			backgroundColor = [UIColor brownColor];
			break;
		case 4:
			backgroundColor = [UIColor clearColor];
			break;
		case 5:
			backgroundColor = [UIColor cyanColor];
			break;
		case 6:
			backgroundColor = [UIColor darkGrayColor];
			break;
		case 7:
			backgroundColor = [UIColor grayColor];
			break;
		case 8:
			backgroundColor = [UIColor greenColor];
			break;
		case 9:
			backgroundColor = [UIColor lightGrayColor];
			break;
		case 10:
			backgroundColor = [UIColor magentaColor];
			break;
		case 11:
			backgroundColor = [UIColor orangeColor];
			break;
		case 12:
			backgroundColor = [UIColor purpleColor];
			break;
		case 13:
			backgroundColor = [UIColor redColor];
			break;
		case 14:
			backgroundColor = [UIColor whiteColor];
			break;
		case 15:
			backgroundColor = [UIColor yellowColor];
			break;
		default:
			break;
	}

    if (enabled) {
        arg1 = backgroundColor;
        return %orig(arg1);
    }
    return %orig;
}
%end

%hook UITextInputTraits 

-(long long) keyboardAppearance{
	if(blackkey){
		return 1;
		%orig;
	}else{
		return %orig;
	}
}
%end

%hook Cydia

-(void)applicationDidEnterBackground:(id)back {
	if (noback){
		back = NULL;
	}else{

	}
}

-(void)applicationDidReceiveMemoryWarning:(id)arg1 {
	arg1 = NULL;
}
%end

%hook AppCacheController

-(bool)retainsNetworkActivityIndicator {
	return true;
}
%end

%hook UIProgressHUD

-(void) setText:(id)text {

	if (UseCustomLoading && CustomLoading){
		text = CustomLoading;
				%orig(text);
	} else {
		%orig;
	}
}
%end

%hook SearchController

-(BOOL)showsSections{
	if(showSection){
		return TRUE;
}else{
	return %orig;
}
}

-(BOOL)isSummarized{
	if(showDesp){
		return FALSE;
	}else{
		return %orig;
	}
	
}

-(BOOL)shouldBlock{
	if(showSection){
		return FALSE;
	}else{
	return %orig;
}
}

-(BOOL)shouldYield{
if(showSection){
	return TRUE;
	}else{
	return %orig;
}
}

%end

%hook ChangesController 

-(BOOL)shouldYield{
	if(showSection){
		return TRUE;
	}else{
	return %orig;
}
}
%end

%hook UISearchBar

-(BOOL)isTranslucent {
	if(showSection){
		return TRUE;
	}else{
	return %orig;
	}
}

-(void)setTranslucent:(BOOL)arg1 {
	if(showSection){
		arg1 = FALSE;
	}else{
	return %orig;
}
}

%end

%hook UISearchBarTextField

-(BOOL)_shouldCenterPlaceholder {
	if(showSection){
		return TRUE;
	}else{
	return %orig;
}
}
%end

%hook CyteTabBarController
-(BOOL) shouldAutorotate {
	return TRUE;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(int)arg1 {
	return TRUE;
}
%end

%hook CyteViewController

-(BOOL)shouldAutorotateToInterfaceOrientation:(int)arg1 {
	return TRUE;
}
-(BOOL)shouldAutorotate {
	return TRUE;
}
%end

%hook UITabBar

-(BOOL)isTranslucent {
	return TRUE;
}
%end

%hook UINavigationBar

-(BOOL)isTranslucent {
	return TRUE;
}
%end

%hook ProgressController

-(void)webView:(id)arg1 didClearWindowObject:(id)arg2 forFrame:(id)arg3 {
	%orig;
	arg1 = [UIColor clearColor];
}

%end

%hook UIStatusBarStyleAttributes

-(float) foregroundAlpha {
	if(fullscreen){
		return 0;
	}else{
		return %orig;
	}
}
%end

%hook UIApplication
-(BOOL)isStatusBarHidden {
	if(fullscreen){
		return TRUE;
	}else{
		return %orig;
	}
}
%end

%hook UILabel

-(void)_setTextColor:(id)arg1 {
	NSDictionary *settings = [[NSDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.maximehip.systemwide.plist"];
	if (settings) {
		UseCustomLoading = ([settings objectForKey:@"UseCustomLoading"] ? [[settings objectForKey:@"UseCustomLoading"] boolValue] : UseCustomLoading);
        hudcolordc = ([settings objectForKey:@"hudcolordc"] ? [[settings objectForKey:@"hudcolordc"] intValue] : hudcolordc);
    }   
    switch (hudcolordc) {
		case 1:
			hudcolor = [UIColor blackColor];
			break;
		case 2:
			hudcolor = [UIColor blueColor];
			break;
		case 3:
			hudcolor = [UIColor brownColor];
			break;
		case 4:
			hudcolor = [UIColor clearColor];
			break;
		case 5:
			hudcolor = [UIColor cyanColor];
			break;
		case 6:
			hudcolor = [UIColor darkGrayColor];
			break;
		case 7:
			hudcolor = [UIColor grayColor];
			break;
		case 8:
			hudcolor = [UIColor greenColor];
			break;
		case 9:
			hudcolor = [UIColor lightGrayColor];
			break;
		case 10:
			hudcolor = [UIColor magentaColor];
			break;
		case 11:
			hudcolor = [UIColor orangeColor];
			break;
		case 12:
			hudcolor = [UIColor purpleColor];
			break;
		case 13:
			hudcolor = [UIColor redColor];
			break;
		case 14:
			hudcolor = [UIColor whiteColor];
			break;
		case 15:
			hudcolor = [UIColor yellowColor];
			break;
		default:
			break;
	}

    if (UseCustomLoading) {
        arg1 = hudcolor;
        return %orig(arg1);
    }
    return %orig;
}
%end

static void loadPrefs()
 {
	NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.maximehip.customdia.plist"];
    if(prefs) {
    landscape = ( [prefs objectForKey:@"landscape"] ? [[prefs objectForKey:@"landscape"] boolValue] : landscape );	
    nowarning = ( [prefs objectForKey:@"nowarning"] ? [[prefs objectForKey:@"nowarning"] boolValue] : nowarning );	
    hiddentweak = ( [prefs objectForKey:@"hiddentweak"] ? [[prefs objectForKey:@"hiddentweak"] boolValue] : hiddentweak );	
    noloading = ( [prefs objectForKey:@"noloading"] ? [[prefs objectForKey:@"noloading"] boolValue] : noloading );
    noback = ( [prefs objectForKey:@"noback"] ? [[prefs objectForKey:@"noback"] boolValue] : noback );	
	UseCustomLoading = ( [prefs objectForKey:@"UseCustomLoading"] ? [[prefs objectForKey:@"UseCustomLoading"] boolValue] : UseCustomLoading );
        CustomLoading    = ( [prefs objectForKey:@"CustomLoading"]    ? [prefs objectForKey:@"CustomLoading"]                : CustomLoading );
    [CustomLoading retain];
    blackkey = ( [prefs objectForKey:@"blackkey"] ? [[prefs objectForKey:@"blackkey"] boolValue] : noback );
    showSection = ( [prefs objectForKey:@"showSection"] ? [[prefs objectForKey:@"showSection"] boolValue] : showSection );
    showDesp = ( [prefs objectForKey:@"showDesp"] ? [[prefs objectForKey:@"showDesp"] boolValue] : showDesp );
    shakeHome = ( [prefs objectForKey:@"shakeHome"] ? [[prefs objectForKey:@"shakeHome"] boolValue] : shakeHome );
    fullscreen = ( [prefs objectForKey:@"fullscreen"] ? [[prefs objectForKey:@"fullscreen"] boolValue] : shakeHome );
    }
   [prefs release];
}

%ctor 

%ctor 
{
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPrefs, CFSTR("com.maxmehip.customdiaprefs/settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    loadPrefs();
}