//
//  UITableView.h
//  Bingbong
//
//  Created by wyq.Cloudayc on 25/08/2017.
//  Copyright © 2017 Cloudayc. All rights reserved.
//

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
 */
@property(nonatomic, readonly) NSUInteger section;

/**
 row in section
 */
@property(nonatomic, readonly) NSUInteger row;

@end
