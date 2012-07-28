/* UICukes UIStepDefinitions.m
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
#import <UIExpectations/UIExpectations.h>

@interface NSArray(UICukes)

- (id)objectAtIndexedSubscript:(NSUInteger)index;

@end

@implementation NSArray(UICukes)

- (id)objectAtIndexedSubscript:(NSUInteger)index
{
	return [self objectAtIndex:index];
}

@end

/*
 * For this to work, you need to add -all_load to your Other Linker Flags. But
 * only for the test target. Without that flag, the linker will not
 * automatically run the constructor method. You will need to execute the method
 * manually instead.
 */
__attribute__((constructor))
void UICukesLoadStepDefinitions()
{
	static dispatch_once_t once;
	dispatch_once(&once, ^{
		[OCCucumber given:@"^the device is in \"(.*?)\" orientation$" step:^(NSArray *arguments) {
			// There are four orientations: portrait, upside-down portrait,
			// landscape left and landscape right. Hence there are two major
			// descriptions of orientation: portrait and landscape. But within
			// these two a further more-detailed description. Use the
			// Apple-provided macros and enumerators to convert the orientation
			// to strings for comparison with the given argument.
			UIInterfaceOrientation interfaceOrientation = [[[UIAutomation localTarget] frontMostApp] interfaceOrientation];
			[@(UIDeviceOrientationIsValidInterfaceOrientation(interfaceOrientation)) should:be_true];
			NSMutableArray *strings = [NSMutableArray array];
			if (UIInterfaceOrientationIsPortrait(interfaceOrientation))
			{
				[strings addObject:NSLocalizedString(@"portrait", nil)];
				switch (interfaceOrientation)
				{
					case UIInterfaceOrientationPortraitUpsideDown:
						[strings addObject:NSLocalizedString(@"portrait upside down", nil)];
						break;
					default:
						;
				}
			}
			else if (UIInterfaceOrientationIsLandscape(interfaceOrientation))
			{
				[strings addObject:NSLocalizedString(@"landscape", nil)];
				switch (interfaceOrientation)
				{
					case UIInterfaceOrientationLandscapeLeft:
						[strings addObject:NSLocalizedString(@"landscape left", nil)];
						break;
					case UIInterfaceOrientationLandscapeRight:
						[strings addObject:NSLocalizedString(@"landscape right", nil)];
						break;
					default:
						;
				}
			}
			[strings should:include(arguments[0])];
		} file:__FILE__ line:__LINE__];
	});
}
