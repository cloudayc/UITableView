//
//  UITableView.m
//  Bingbong
//
//  Created by wyq.Cloudayc on 25/08/2017.
//  Copyright © 2017 Cloudayc. All rights reserved.
//

#import "UITableView.h"

static const NSString * const UITableViewColumenIdentifier = @"UITableViewColumenIdentifier";

@interface UITableView ()
<NSTableViewDataSource, NSTableViewDelegate>

@property (nonatomic, strong) NSTableView *tableView;

@end

@implementation UITableView

- (instancetype)initWithFrame:(NSRect)frameRect
{
    if (self = [super initWithFrame:frameRect]) {
        [self initContent];
        _tableView.frame = frameRect;
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
    self.tableView.frame = CGRectMake(0.f, 0.f, frame.size.width, frame.size.height);
}

- (void)setDataSource:(id<UITableViewDataSource>)dataSource
{
    _dataSource = dataSource;
    [self initColumn];
    self.tableView.dataSource = self;
}

- (void)initColumn
{
    /* get column from data source */
    NSTableColumn *columen0     = [[NSTableColumn alloc] initWithIdentifier:@"0"];
    columen0.title = @"";
    [_tableView addTableColumn:columen0];
}


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


- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
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
