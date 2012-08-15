/* UICukes UIApplicationHelpers.m
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

#import "UIApplicationHelpers.h"

NSArray *UILocalizedDescriptionsFromInterfaceOrientation(UIInterfaceOrientation interfaceOrientation)
{
	NSMutableArray *localizedDescriptions = [NSMutableArray array];
	if (UIInterfaceOrientationIsPortrait(interfaceOrientation))
	{
		[localizedDescriptions addObject:NSLocalizedString(@"portrait", nil)];
		switch (interfaceOrientation)
		{
			case UIInterfaceOrientationPortraitUpsideDown:
				[localizedDescriptions addObject:NSLocalizedString(@"portrait upside down", nil)];
				[localizedDescriptions addObject:NSLocalizedString(@"portrait upside-down", nil)];
				[localizedDescriptions addObject:NSLocalizedString(@"upside-down portrait", nil)];
				break;
			default:
				;
		}
	}
	else if (UIInterfaceOrientationIsLandscape(interfaceOrientation))
	{
		[localizedDescriptions addObject:NSLocalizedString(@"landscape", nil)];
		switch (interfaceOrientation)
		{
			case UIInterfaceOrientationLandscapeLeft:
				[localizedDescriptions addObject:NSLocalizedString(@"landscape left", nil)];
				break;
			case UIInterfaceOrientationLandscapeRight:
				[localizedDescriptions addObject:NSLocalizedString(@"landscape right", nil)];
				break;
			default:
				;
		}
	}
	return [localizedDescriptions copy];
}
