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
			UIInterfaceOrientation interfaceOrientation = [[[UIAutomation localTarget] frontMostApp] interfaceOrientation];
			[@(UIDeviceOrientationIsValidInterfaceOrientation(interfaceOrientation)) should:be_true];
		} file:__FILE__ line:__LINE__];
	});
}
