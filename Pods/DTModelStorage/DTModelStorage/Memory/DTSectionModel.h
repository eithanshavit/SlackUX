//
//  DTSectionModel.h
//  DTModelStorage
//
//  Created by Denys Telezhkin on 15.12.13.
//  Copyright (c) 2013 Denys Telezhkin. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "DTSection.h"

#pragma clang assume_nonnull begin

/**
 This class represents data of the section used by `DTMemoryStorage`.
 */
@interface DTSectionModel : NSObject <DTSection>

/**
 Items for current section
 */
@property (nonatomic, strong) NSMutableArray * objects;

/**
 Method to retrieve supplementary model for current section. This can be header,footer model, or anything you need.
 
 @param kind Kind of supplementary model
 
 @return supplementary model
 */
-(nullable id)supplementaryModelOfKind:(NSString *)kind;

/**
 Method to set supplementary model for current section. This can be header,footer model, or anything you need. Number of supplementary models is not limited. Any custom kind is accepted.
 
 @param model supplementary model to set
 
 @param kind Kind of supplementary model
 */
-(void)setSupplementaryModel:(nullable id)model forKind:(NSString *)kind;

@end

#pragma clang assume_nonnull end
