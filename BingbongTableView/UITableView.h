/*
 MIT License
 
 Copyright (c) 2017 cloudayc
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

#import <Cocoa/Cocoa.h>

@protocol UITableViewDelegate <NSObject>

@optional

-(BOOL)tableView:(NSTableView *)tableView shouldSelectRowAtIndexPath:(NSIndexPath *)indexPath; // not ready
-(BOOL)tableView:(NSTableView *)tableView shouldSelectSection:(NSInteger)section; // not ready

@end

@protocol UITableViewDataSource <NSObject>

-(NSInteger)tableView:(NSTableView *)tableView numberOfRowsInSection:(NSInteger)section; // ready

@optional

-(NSInteger)numberOfColumnsInTableView:(NSTableView *)tableView; // not ready
-(NSInteger)numberOfSectionsInTableView:(NSTableView *)tableView; // not ready

-(BOOL)tableView:(NSTableView *)tableView hasHeaderViewForSection:(NSInteger)section; // not ready

-(CGFloat)tableView:(NSTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath; // ready
-(CGFloat)tableView:(NSTableView *)tableView heightForHeaderViewForSection:(NSInteger)section; // not ready

-(NSView *)tableView:(NSTableView *)tableView viewForHeaderInSection:(NSInteger)section; // not ready
-(NSView *)tableView:(NSTableView *)tableView viewForIndexPath:(NSIndexPath *)indexPath; // ready

@end


@interface UITableView : NSScrollView

@property (nonatomic, weak) id<UITableViewDelegate> delegate;
@property (nonatomic, weak) id<UITableViewDataSource> dataSource;

@end


@interface NSIndexPath (UITableView)

+ (NSIndexPath *)indexPathForColumn:(NSUInteger)column section:(NSUInteger)section row:(NSUInteger)row;


/**
 column in table view
 */
@property(nonatomic, readonly) NSUInteger column;

/**
 section in column
 now it is 0.
 */
@property(nonatomic, readonly) NSUInteger section;

/**
 row in section
 */
@property(nonatomic, readonly) NSUInteger row;

@end
