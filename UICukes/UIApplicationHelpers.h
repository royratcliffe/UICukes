/* UICukes UIApplicationHelpers.h
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

#import <UIKit/UIKit.h>

/*!
 * @brief Answers an array of localised strings describing a given user
 * interface orientation.
 * @result Answers an array because more than one way may exist to describe the
 * orientation, a general way plus a more specific way. Take portrait
 * orientation for example. You can describe this as "portrait" but there are
 * also two other more-specific ways to describe portrait: portrait, or portrait
 * upside down. Hence the answer contains all the valid ways to describe the
 * orientation in general-to-specific order.
 */
NSArray *UILocalizedDescriptionsFromInterfaceOrientation(UIInterfaceOrientation interfaceOrientation);
