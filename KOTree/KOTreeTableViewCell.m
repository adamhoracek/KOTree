//
//  KOSelectingTableViewCell.m
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

#import "KOTreeTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

#define KOCOLOR_FILES_TITLE [UIColor colorWithRed:0.4 green:0.357 blue:0.325 alpha:1] /*#665b53*/
#define KOCOLOR_FILES_TITLE_SHADOW [UIColor colorWithRed:1 green:1 blue:1 alpha:1] /*#ffffff*/
#define KOCOLOR_FILES_COUNTER [UIColor colorWithRed:0.608 green:0.376 blue:0.251 alpha:1] /*#9b6040*/
#define KOCOLOR_FILES_COUNTER_SHADOW [UIColor colorWithRed:1 green:1 blue:1 alpha:0.35] /*#ffffff*/
#define KOFONT_FILES_TITLE [UIFont fontWithName:@"HelveticaNeue" size:24.0f]
#define KOFONT_FILES_COUNTER [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0f]

@implementation KOTreeTableViewCell

@synthesize backgroundImageView;
@synthesize iconButton;
@synthesize titleTextField;
@synthesize countLabel;
@synthesize delegate;
@synthesize treeItem;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
		
		backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"copymove-cell-bg"]];
		[backgroundImageView setContentMode:UIViewContentModeTopRight];
		
		[self setBackgroundView:backgroundImageView];
		[self setSelectionStyle:UITableViewCellSelectionStyleNone];
		
		iconButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[iconButton setFrame:CGRectMake(0, 0, 100, 65)];
		[iconButton setAdjustsImageWhenHighlighted:NO];
		[iconButton addTarget:self action:@selector(iconButtonAction:) forControlEvents:UIControlEventTouchUpInside];
		[iconButton setImage:[UIImage imageNamed:@"item-icon-folder"] forState:UIControlStateNormal];
		[iconButton setImage:[UIImage imageNamed:@"item-icon-folder-selected"] forState:UIControlStateSelected];
		[iconButton setImage:[UIImage imageNamed:@"item-icon-folder-selected"] forState:UIControlStateHighlighted];
		
		[self.contentView addSubview:iconButton];
		
		titleTextField = [[UITextField alloc] init];
		[titleTextField setFont:KOFONT_FILES_TITLE];
		[titleTextField setTextColor:KOCOLOR_FILES_TITLE];
		[titleTextField.layer setShadowColor:KOCOLOR_FILES_TITLE_SHADOW.CGColor];
		[titleTextField.layer setShadowOffset:CGSizeMake(0, 1)];
		[titleTextField.layer setShadowOpacity:1.0f];
		[titleTextField.layer setShadowRadius:0.0f];
		
		[titleTextField setUserInteractionEnabled:NO];
		[titleTextField setBackgroundColor:[UIColor clearColor]];
		[titleTextField sizeToFit];
		[titleTextField setFrame:CGRectMake(108, 17, titleTextField.frame.size.width, titleTextField.frame.size.height)];
		[self.contentView addSubview:titleTextField];
		
		[self.layer setMasksToBounds:YES];
		
		countLabel = [[UILabel alloc] initWithFrame:CGRectMake(686, 28, 47, 28)];
		[countLabel setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin];
		[countLabel setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"item-counter"]]];
		[countLabel setTextAlignment:UITextAlignmentCenter];
		[countLabel setLineBreakMode:UILineBreakModeMiddleTruncation];
		[countLabel setFont:KOFONT_FILES_COUNTER];
		[countLabel setTextColor:KOCOLOR_FILES_COUNTER];
		[countLabel setShadowColor:KOCOLOR_FILES_COUNTER_SHADOW];
		[countLabel setShadowOffset:CGSizeMake(0, 1)];
		
		[self setAccessoryView:countLabel];
		[self.accessoryView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleBottomMargin];
		
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
	
    // Configure the view for the selected state
}

- (void)setLevel:(NSInteger)level {
	CGRect rect;
	
	rect = iconButton.frame;
	rect.origin.x = 50 * level;
	iconButton.frame = rect;
	
	rect = titleTextField.frame;
	rect.origin.x = 108 + 50 * level;
	titleTextField.frame = rect;
}

- (void)iconButtonAction:(id)sender {
	NSLog(@"iconButtonAction:");
	
	if (delegate && [delegate respondsToSelector:@selector(treeTableViewCell:didTapIconWithTreeItem:)]) {
		[delegate treeTableViewCell:(KOTreeTableViewCell *)self didTapIconWithTreeItem:(KOTreeItem *)treeItem];
	}
}

@end
