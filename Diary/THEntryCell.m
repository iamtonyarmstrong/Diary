//
//  THEntryCell.m
//  Diary
//
//  Created by Anthony Armstrong on 6/19/14.
//  Copyright (c) 2014 iamtonyarmstrong. All rights reserved.
//

#import "THEntryCell.h"
#import "THDiaryEntry.h"

@implementation THEntryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)heightForEntry:(THDiaryEntry*) entry
{
    const CGFloat topMargin = 35.0f;
    const CGFloat bottomMargin = 39.0f;
    const CGFloat minHeight = 85.0f;

    UIFont * font = [UIFont systemFontOfSize:[UIFont systemFontSize]];

    CGRect boundingBox = [entry.body boundingRectWithSize:CGSizeMake(215.0, CGFLOAT_MAX)
                                                  options: (NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin)
                                               attributes:@{NSFontAttributeName: font}
                                                  context:nil];
    return MAX(minHeight, CGRectGetHeight(boundingBox) + topMargin + bottomMargin);

}



@end
