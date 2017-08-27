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

#import "UITableView.h"

static const NSString * const UITableViewColumenIdentifier = @"UITableViewColumenIdentifier";

@interface UITableView ()
<NSTableViewDataSource, NSTableViewDelegate>

@property (nonatomic, strong) NSTableView *tableView;

@property (nonatomic, strong) NSMutableArray *columnList;

@end

@implementation UITableView

- (instancetype)initWithFrame:(NSRect)frameRect
{
    if (self = [super initWithFrame:frameRect]) {
        [self initContent];
        [self updateLayoutWithFrame:frameRect];
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initContent];
    }
    return self;
}

- (void)initContent
{
    self.hasVerticalScroller = YES;
    
    self.tableView = [[NSTableView alloc] init];
    self.tableView.delegate = self;
    
    self.documentView = _tableView;
}

- (void)setFrame:(NSRect)frame
{
    [super setFrame:frame];
    [self updateLayoutWithFrame:frame];
}

- (void)updateLayoutWithFrame:(CGRect)frame
{
    self.tableView.frame = CGRectMake(0.f, 0.f, frame.size.width, frame.size.height);
}

- (void)updateColumnWithFrame:(CGRect)frame
{
    CGFloat columnWidth = frame.size.width / _columnList.count;
    for (NSTableColumn *column in _columnList) {
        column.width = columnWidth;
    }
}

- (void)setDataSource:(id<UITableViewDataSource>)dataSource
{
    _dataSource = dataSource;
    [self initColumn];
    self.tableView.dataSource = self;
}

- (void)initColumn
{
    /* TODO: get column from data source */
    NSTableColumn *column0     = [[NSTableColumn alloc] initWithIdentifier:@"0"];
    column0.title = @"";
    [_tableView addTableColumn:column0];
    
    [self updateColumnWithFrame:_tableView.frame];
}

#pragma mark - NSTableView data source

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    if ([self.dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
        return [self.dataSource tableView:_tableView numberOfRowsInSection:0];
    }
    return 1;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    
    NSUInteger column = (NSUInteger)[tableColumn.identifier integerValue];
    NSIndexPath *indexPath = [NSIndexPath indexPathForColumn:column section:0 row:row];
    
    if ([self.dataSource respondsToSelector:@selector(tableView:viewForIndexPath:)]) {
        return [self.dataSource tableView:_tableView viewForIndexPath:indexPath];
    }
    return [[NSView alloc] initWithFrame:CGRectMake(0.f, 0.f, tableView.frame.size.width, [self tableView:tableView heightOfRow:row])];
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row{
    NSIndexPath *indexPath = [NSIndexPath indexPathForColumn:0 section:0 row:row];
    if ([self.dataSource respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
        return [self.dataSource tableView:_tableView heightForRowAtIndexPath:indexPath];
    }
    return 44;
}

@end



@implementation NSIndexPath (UITableView)

+ (NSIndexPath *)indexPathForColumn:(NSUInteger)column section:(NSUInteger)section row:(NSUInteger)row
{
    NSUInteger path[3] = {column, section, row};
    return [self indexPathWithIndexes:path length:3];
}

- (NSUInteger)row
{
    return [self indexAtPosition:2];
}

-(NSUInteger)section
{
    return [self indexAtPosition:1];
}

-(NSUInteger)column
{
    return [self indexAtPosition:0];
}

@end
