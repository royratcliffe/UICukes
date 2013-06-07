/* UICukes UIApplicationSteps.m
 *
 * Copyright © 2012, The OCCukes Organisation. All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the “Software”), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 *	The above copyright notice and this permission notice shall be included in
 *	all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED “AS IS,” WITHOUT WARRANTY OF ANY KIND, EITHER
 * EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO
 * EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES
 * OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
 * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 ******************************************************************************/

#import <OCCukes/OCCukes.h>
#import <OCExpectations/OCExpectations.h>

#import "UIApplicationHelpers.h"

/*
 * For this to work, you need to add -all_load to your Other Linker Flags. But
 * only for the test target, though you typically need that flag on application
 * targets when linking against static libraries in general. Without that flag,
 * the linker will not automatically run the constructor method. You will need
 * to execute the method manually instead.
 */
__attribute__((constructor))
static void StepDefinitions()
{
	@autoreleasepool {
		// Create a step definition for matching expectations about
		// interface orientation, where the expectation follows one of the forms:
		//
		//	the device is in <some> orientation
		//	the device is not in <some> orientation
		//
		// Here, <some> represents one of the orientation descriptions:
		// portrait, portrait upside down, portrait upside-down, upside-down
		// portrait, landscape, landscape left, landscape right.
		[OCCucumber given:@"^the device is (not )?in (.*?) orientation$" step:^(NSArray *arguments) {
			// There are four orientations: portrait, upside-down portrait,
			// landscape left and landscape right. Hence there are two major
			// descriptions of orientation: portrait and landscape. But within
			// these two a further more-detailed description. Use the
			// Apple-provided macros and enumerators to convert the orientation
			// to strings for comparison with the given argument.
			[OCSpecNullForNil([UIApplication sharedApplication]) shouldNot:be_null];
			UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
			[@(UIDeviceOrientationIsValidInterfaceOrientation(interfaceOrientation)) should:be_true];
			SEL shouldOrShouldNot = arguments[0] == [NSNull null] ? @selector(should:) : @selector(shouldNot:);
			[UILocalizedDescriptionsFromInterfaceOrientation(interfaceOrientation) performSelector:shouldOrShouldNot withObject:include(arguments[1])];
		} file:__FILE__ line:__LINE__];
		
		[OCCucumber given:@"^the app has the name \"(.*?)\"$" step:^(NSArray *arguments) {
			[OCSpecNullForNil([UIApplication sharedApplication]) shouldNot:be_null];
			NSBundle *bundle = [NSBundle mainBundle];
			NSString *displayName = [[NSFileManager defaultManager] displayNameAtPath:[bundle bundlePath]];
			[[displayName stringByDeletingPathExtension] should:be(arguments[0])];
		} file:__FILE__ line:__LINE__];
		
		[OCCucumber then:@"^(?:I )?tap the (\\d+)(?:st|nd|rd|th) (.*?)$" step:^(NSArray *arguments) {
			// Collect all the views in the application's key window. Pick the
			// first. But what does it mean, the 'first' view. Interpret this to
			// mean the top-most and left-most view. Sort them by frame y and x
			// coordinates. Ignore hidden views, including any sub-views
			// belonging to hidden views. Use the key window as the frame of
			// reference when comparing coordinates.
			[OCSpecNullForNil([UIApplication sharedApplication]) shouldNot:be_null];
			UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
			NSMutableString *viewClassName = [[NSMutableString alloc] initWithString:@"UI"];
			for (NSString *word in [arguments[1] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]])
			{
				[viewClassName appendString:[word capitalizedString]];
			}
			Class viewClass = NSClassFromString(viewClassName);
			NSMutableArray *views = [NSMutableArray array];
			for (UIView *view in [[OCRecursiveEnumeration alloc] initWithSuperObject:keyWindow usingSubSelector:@selector(subviews) inclusive:NO inclusiveBlock:^BOOL(UIView *view) {
				return ![view isHidden];
			}])
			{
				if ([view isKindOfClass:viewClass])
				{
					[views addObject:view];
				}
			}
			[views sortUsingComparator:^NSComparisonResult(UITextField *textField1, UITextField *textField2) {
				CGRect frame1 = [keyWindow convertRect:[textField1 frame] fromView:textField1];
				CGRect frame2 = [keyWindow convertRect:[textField2 frame] fromView:textField2];
				NSComparisonResult result = [@(frame1.origin.y) compare:@(frame2.origin.y)];
				return result != NSOrderedSame ? result : [@(frame1.origin.x) compare:@(frame2.origin.x)];
			}];
			NSInteger index = [arguments[0] integerValue];
			[@(1 <= index && index <= views.count) should:be_true];
			[@([views[index - 1] becomeFirstResponder]) should:be_true];
		} file:__FILE__ line:__LINE__];
		
		[OCCucumber then:@"^delay (\\d+) second(?:s)?$" step:^(NSArray *arguments) {
			// Do not sleep. Sleeping freezes the application. Pump the current
			// run loop for the prescribed number of seconds.
			int seconds = [arguments[0] intValue];
			[[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:seconds]];
		} file:__FILE__ line:__LINE__];
		
		[OCCucumber then:@"^type \"(.*?)\"$" step:^(NSArray *arguments) {
			// Typing something means searching for the first responder. The
			// keyboard appears when a text field or view becomes the first
			// responder.
			[OCSpecNullForNil([UIApplication sharedApplication]) shouldNot:be_null];
			UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
			UIView *firstResponder;
			for (firstResponder in [[OCRecursiveEnumeration alloc] initWithSuperObject:keyWindow usingSubSelector:@selector(subviews) inclusive:NO inclusiveBlock:NULL])
			{
				if ([firstResponder isFirstResponder])
				{
					break;
				}
			}
			[OCSpecNullForNil(firstResponder) shouldNot:be_null];
			[@[ @"UITextField", @"UITextView" ] should:include(NSStringFromClass([firstResponder class]))];
			[(id)firstResponder setText:arguments[0]];
		} file:__FILE__ line:__LINE__];
		
		[OCCucumber when:@"^push the \"(.*?)\" button$" step:^(NSArray *arguments) {
			[OCSpecNullForNil([UIApplication sharedApplication]) shouldNot:be_null];
			UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
			UIButton *button;
			for (button in [[OCRecursiveEnumeration alloc] initWithSuperObject:keyWindow usingSubSelector:@selector(subviews) inclusive:NO inclusiveBlock:^BOOL(UIView *view) {
				return ![view isHidden];
			}])
			{
				if ([button isKindOfClass:[UIButton class]] && [[button currentTitle] isEqualToString:arguments[0]])
				{
					break;
				}
			}
			[OCSpecNullForNil(button) shouldNot:be_null];
			[button sendActionsForControlEvents:UIControlEventTouchUpInside];
		} file:__FILE__ line:__LINE__];
	}
}
