//
//  ViewController.m
//  BingbongTableView
//
//  Created by wyq.Cloudayc on 25/08/2017.
//  Copyright © 2017 Cloudayc. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableview.delegate = self;
    tableview.dataSource = self;
    
    [self.view addSubview:tableview];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

-(NSInteger)tableView:(NSTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(NSView *)tableView:(NSTableView *)tableView viewForIndexPath:(NSIndexPath *)indexPath
{
    CGRect frame = tableView.bounds;
    frame.size.height = 40;
    NSTextField *textView = [[NSTextField alloc] initWithFrame:frame];
    textView.bordered = NO;
    textView.editable = NO;
    
    NSString *text = [NSString stringWithFormat:@"%lu_%lu_%lu", indexPath.column, indexPath.section, indexPath.row];
    
    textView.stringValue = text;
    
    return textView;
}

@end
