//
//  DTStorageUpdate.h
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

#pragma clang assume_nonnull begin

/**
 This class encapsulates changes, that happened in <DTStorage> object.
 */

@interface DTStorageUpdate : NSObject

/**
 Indexes of deleted sections for current update.
 */
@property (nonatomic, strong) NSMutableIndexSet *deletedSectionIndexes;

/**
 Indexes of inserted sections for current update.
 */
@property (nonatomic, strong) NSMutableIndexSet *insertedSectionIndexes;

/**
 Indexes of updated sections for current update.
 */
@property (nonatomic, strong) NSMutableIndexSet *updatedSectionIndexes;

/**
 Index paths of deleted rows for current update.
 */
@property (nonatomic, strong) NSMutableArray *deletedRowIndexPaths;

/**
 Index paths of inserted rows for current update.
 */
@property (nonatomic, strong) NSMutableArray *insertedRowIndexPaths;

/**
 Index paths of updated rows for current update.
 */
@property (nonatomic, strong) NSMutableArray *updatedRowIndexPaths;

@end

#pragma clang assume_nonnull end
