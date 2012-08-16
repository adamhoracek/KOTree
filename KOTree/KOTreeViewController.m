//
//  KOSelectingViewController.m
//  Kodiak
//
//  Created by Adam Horacek on 18.04.12.
//  Copyright (c) 2012 Adam Horacek, Kuba Brecka
//
//  Website: http://www.becomekodiak.com/
//  github: http://github.com/adamhoracek/KOTree
//	Twitter: http://twitter.com/becomekodiak
//  Mail: adam@becomekodiak.com, kuba@becomekodiak.com
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#import "KOTreeViewController.h"
#import "KOTreeTableViewCell.h"
#import "KOTreeItem.h"

@implementation KOTreeViewController

@synthesize treeTableView;
@synthesize treeItems;
@synthesize selectedTreeItems;
@synthesize item0, item1, item1_1, item1_2, item1_2_1, item2, item3;

- (NSMutableArray *)listItemsAtPath:(NSString *)path {
	
	item0 = [[KOTreeItem alloc] init];
	[item0 setBase:@"Item 0"];
	[item0 setPath:@"/"];
	[item0 setSubmersionLevel:0];
	[item0 setParentSelectingItem:nil];
	[item0 setAncestorSelectingItems:[NSMutableArray arrayWithObjects:item1, item2, item3, nil]];
	[item0 setNumberOfSubitems:3];
	
	item1 = [[KOTreeItem alloc] init];
	[item1 setBase:@"Item 1"];
	[item1 setPath:@"/Item 0"];
	[item1 setSubmersionLevel:1];
	[item1 setParentSelectingItem:item0];
	[item1 setAncestorSelectingItems:[NSMutableArray arrayWithObjects:item1_1, item1_2, nil]];
	[item1 setNumberOfSubitems:2];
	
	item1_1 = [[KOTreeItem alloc] init];
	[item1_1 setBase:@"Item 1 1"];
	[item1_1 setPath:@"/Item 0/Item 1"];
	[item1_1 setSubmersionLevel:2];
	[item1_1 setParentSelectingItem:item1];
	[item1_1 setAncestorSelectingItems:[NSMutableArray array]];
	[item1_1 setNumberOfSubitems:0];
	
	item1_2 = [[KOTreeItem alloc] init];
	[item1_2 setBase:@"Item 1 2"];
	[item1_2 setPath:@"/Item 0/Item 1"];
	[item1_2 setSubmersionLevel:2];
	[item1_2 setParentSelectingItem:item1];
	[item1_2 setAncestorSelectingItems:[NSMutableArray arrayWithObjects:item1_2_1, nil]];
	[item1_2 setNumberOfSubitems:1];
	
	item1_2_1 = [[KOTreeItem alloc] init];
	[item1_2_1 setBase:@"Item 1 2 1"];
	[item1_2_1 setPath:@"/Item 0/Item 1/Item 1 2"];
	[item1_2_1 setSubmersionLevel:3];
	[item1_2_1 setParentSelectingItem:item1_2];
	[item1_2_1 setAncestorSelectingItems:[NSMutableArray array]];
	[item1_2_1 setNumberOfSubitems:0];
	
	item2 = [[KOTreeItem alloc] init];
	[item2 setBase:@"Item 2"];
	[item2 setPath:@"/Item 0"];
	[item2 setSubmersionLevel:1];
	[item2 setParentSelectingItem:item0];
	[item2 setAncestorSelectingItems:[NSMutableArray array]];
	[item2 setNumberOfSubitems:0];
	
	item3 = [[KOTreeItem alloc] init];
	[item3 setBase:@"Item 3"];
	[item3 setPath:@"/Item 0"];
	[item3 setSubmersionLevel:1];
	[item3 setParentSelectingItem:item0];
	[item3 setAncestorSelectingItems:[NSMutableArray array]];
	[item3 setNumberOfSubitems:0];
	
	NSLog(@"%@", path);
	if ([path isEqualToString:@"/"]) {
		return [NSMutableArray arrayWithObject:item0];
	} else if ([path isEqualToString:@"/Item 0"]) {
		return [NSMutableArray arrayWithObjects:item1, item2, item3, nil];
	} else if ([path isEqualToString:@"/Item 0/Item 1"]) {
		return [NSMutableArray arrayWithObjects:item1_1, item1_2, nil];
	} else if ([path isEqualToString:@"/Item 0/Item 1/Item 1 2"]) {
		return [NSMutableArray arrayWithObjects:item1_2_1, nil];
	} else {
		return [NSMutableArray array];
	}
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.selectedTreeItems = [NSMutableArray array];
	// Do any additional setup after loading the view.
	
	self.treeItems = [self listItemsAtPath:@"/"];
	
	treeTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
	[treeTableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
	[treeTableView setBackgroundColor:[UIColor colorWithRed:1 green:0.976 blue:0.957 alpha:1] /*#fff9f4*/];
	[treeTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	[treeTableView setRowHeight:65.0f];
	[treeTableView setDelegate:(id<UITableViewDelegate>)self];
	[treeTableView setDataSource:(id<UITableViewDataSource>)self];
	[self.view addSubview:treeTableView];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	[[[self treeTableView] delegate] tableView:treeTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
}

#pragma mark - UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.treeItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	KOTreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selectingTableViewCell"];
	if (!cell)
		cell = [[KOTreeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"selectingTableViewCell"];
	
	KOTreeItem *treeItem = [self.treeItems objectAtIndex:indexPath.row];
	
	cell.treeItem = treeItem;
	
	[cell.iconButton setSelected:[self.selectedTreeItems containsObject:cell.treeItem]];
	
	if ([treeItem numberOfSubitems])
		[cell.countLabel setText:[NSString stringWithFormat:@"%d", [treeItem numberOfSubitems]]];
	else
		[cell.countLabel setText:@"-"];
	
	[cell.titleTextField setText:[treeItem base]];
	[cell.titleTextField sizeToFit];
	
	[cell setDelegate:(id<KOTreeTableViewCellDelegate>)self];

	[cell setLevel:[treeItem submersionLevel]];
	
	return cell;
}

- (void)selectingItemsToDelete:(KOTreeItem *)selItems saveToArray:(NSMutableArray *)deleteSelectingItems{
	for (KOTreeItem *obj in selItems.ancestorSelectingItems) {
		[self selectingItemsToDelete:obj saveToArray:deleteSelectingItems];
	}
	
	[deleteSelectingItems addObject:selItems];
}

- (NSMutableArray *)removeIndexPathForTreeItems:(NSMutableArray *)treeItemsToRemove {
	NSMutableArray *result = [NSMutableArray array];
	
	for (NSInteger i = 0; i < [treeTableView numberOfRowsInSection:0]; ++i) {
		NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
		KOTreeTableViewCell *cell = (KOTreeTableViewCell *)[treeTableView cellForRowAtIndexPath:indexPath];

		for (KOTreeItem *tmpTreeItem in treeItemsToRemove) {
			if ([cell.treeItem isEqualToSelectingItem:tmpTreeItem])
				[result addObject:indexPath];
		}
	}	
	
	return result;
}
- (void)tableViewAction:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath {
	
}
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self tableViewAction:tableView withIndexPath:indexPath];
	
	KOTreeTableViewCell *cell = (KOTreeTableViewCell *)[treeTableView cellForRowAtIndexPath:indexPath];
	
	NSInteger insertTreeItemIndex = [self.treeItems indexOfObject:cell.treeItem];
	NSMutableArray *insertIndexPaths = [NSMutableArray array];
	NSMutableArray *insertselectingItems = [self listItemsAtPath:[cell.treeItem.path stringByAppendingPathComponent:cell.treeItem.base]];
	
	NSMutableArray *removeIndexPaths = [NSMutableArray array];
	NSMutableArray *treeItemsToRemove = [NSMutableArray array];
	
	for (KOTreeItem *tmpTreeItem in insertselectingItems) {
		[tmpTreeItem setPath:[cell.treeItem.path stringByAppendingPathComponent:cell.treeItem.base]];
		[tmpTreeItem setParentSelectingItem:cell.treeItem];
		
		[cell.treeItem.ancestorSelectingItems removeAllObjects];
		[cell.treeItem.ancestorSelectingItems addObjectsFromArray:insertselectingItems];
		
		insertTreeItemIndex++;
		
		BOOL contains = NO;
		
		for (KOTreeItem *tmp2TreeItem in self.treeItems) {
			if ([tmp2TreeItem isEqualToSelectingItem:tmpTreeItem]) {
				contains = YES;
				
				[self selectingItemsToDelete:tmp2TreeItem saveToArray:treeItemsToRemove];
				
				removeIndexPaths = [self removeIndexPathForTreeItems:(NSMutableArray *)treeItemsToRemove];
			}
		}
		
		for (KOTreeItem *tmp2TreeItem in treeItemsToRemove) {
			[self.treeItems removeObject:tmp2TreeItem];
			
			for (KOTreeItem *tmp3TreeItem in self.selectedTreeItems) {
				if ([tmp3TreeItem isEqualToSelectingItem:tmp2TreeItem]) {
					NSLog(@"%@", tmp3TreeItem.base);
					[self.selectedTreeItems removeObject:tmp2TreeItem];
					break;
				}
			}
		}
		
		if (!contains) {
			[tmpTreeItem setSubmersionLevel:tmpTreeItem.submersionLevel];
			
			[self.treeItems insertObject:tmpTreeItem atIndex:insertTreeItemIndex];
			
			NSIndexPath *indexPth = [NSIndexPath indexPathForRow:insertTreeItemIndex inSection:0];
			[insertIndexPaths addObject:indexPth];
		}
	}
	
	if ([insertIndexPaths count])
		[treeTableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationBottom];
	
	if ([removeIndexPaths count])
		[treeTableView deleteRowsAtIndexPaths:removeIndexPaths withRowAnimation:UITableViewRowAnimationBottom];
}

#pragma mark - Actions

- (void)iconButtonAction:(KOTreeTableViewCell *)cell treeItem:(KOTreeItem *)tmpTreeItem {
	if ([self.selectedTreeItems containsObject:cell.treeItem]) {
		[cell.iconButton setSelected:NO];		
		[self.selectedTreeItems removeObject:cell.treeItem];
	} else {
		[cell.iconButton setSelected:YES];
		
		[self.selectedTreeItems removeAllObjects];
		[self.selectedTreeItems addObject:cell.treeItem];
		
		[treeTableView reloadData];
	}
}

#pragma mark - KOTreeTableViewCellDelegate

- (void)treeTableViewCell:(KOTreeTableViewCell *)cell didTapIconWithTreeItem:(KOTreeItem *)tmpTreeItem {
	NSLog(@"didTapIconWithselectingItem.base: %@", [tmpTreeItem base]);
	
	[self iconButtonAction:cell treeItem:tmpTreeItem];
}

@end
