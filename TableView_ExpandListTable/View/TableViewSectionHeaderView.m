//
//  TableViewSectionHeaderView.m
//  TableView_ExpandListTable
//
//  Copyright (c) 2014年 kevin. All rights reserved.
//

#import "TableViewSectionHeaderView.h"

@interface TableViewSectionHeaderView()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *disclosureButton;

@property (nonatomic, assign) NSInteger section;

@end

@implementation TableViewSectionHeaderView

-(id)initWithFrame:(CGRect)frame title:(NSString*)title section:(NSInteger)sectionNumber opened:(BOOL)isOpened delegate:(id)aDelegate{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *aBGImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        aBGImageView.image = [UIImage imageNamed:@"headView.png"];
        [self addSubview:aBGImageView];
        
        
		UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(toggleAction:)];
		[self addGestureRecognizer:tapGesture];
		self.userInteractionEnabled = YES;
        
		_section = sectionNumber;
		_delegate = aDelegate;
      
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 80, 45)];
        _titleLabel.font = [UIFont systemFontOfSize:17.0];
        _titleLabel.textColor = [UIColor colorWithRed:0x1a/255 green:0x1a/255 blue:0x1a/255 alpha:1.0];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.text = title;
        
        _disclosureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _disclosureButton.frame = CGRectMake(280, 10, 35,35);
        [_disclosureButton setImage:[UIImage imageNamed:@"arrowClose.png"] forState:UIControlStateNormal];
        [_disclosureButton setImage:[UIImage imageNamed:@"arrowOpen.png"] forState:UIControlStateSelected];
		_disclosureButton.userInteractionEnabled = NO;
        _disclosureButton.selected = isOpened;
        
        [self addSubview:_titleLabel];
        [self addSubview:_disclosureButton];
		
	}
	return self;
}


#pragma mark - Action

-(void)toggleAction:(id)sender {
	
	self.disclosureButton.selected = !self.disclosureButton.selected;
	
	if (self.disclosureButton.selected) {
		if ([self.delegate respondsToSelector:@selector(sectionHeaderView:sectionOpened:)]) {
			[self.delegate sectionHeaderView:self sectionOpened:self.section];
		}
	}
	else {
		if ([self.delegate respondsToSelector:@selector(sectionHeaderView:sectionClosed:)]) {
			[self.delegate sectionHeaderView:self sectionClosed:self.section];
		}
	}
    
}




@end
