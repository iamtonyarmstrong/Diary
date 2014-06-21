//
//  THEntryCell.m
//  Diary
//
//  Created by Anthony Armstrong on 6/19/14.
//  Copyright (c) 2014 iamtonyarmstrong. All rights reserved.
//

#import "THEntryCell.h"
#import "THDiaryEntry.h"


@interface THEntryCell()

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UIImageView *moodImageView;
@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@end

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
    const CGFloat topMargin = 20.0f;
    const CGFloat bottomMargin = 60.0f;
    const CGFloat minHeight = 90.0f;

    UIFont * font = [UIFont systemFontOfSize:[UIFont systemFontSize]];

    CGRect boundingBox = [entry.body boundingRectWithSize:CGSizeMake(211.0, CGFLOAT_MAX)
                                                  options:(NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin)
                                               attributes:@{NSFontAttributeName: font}
                                                  context:nil];

    return MAX(minHeight, CGRectGetHeight(boundingBox) + topMargin + bottomMargin);

}

- (void)configureCellForEntry:(THDiaryEntry *)entry
{
    self.bodyLabel.text = entry.body;
    self.locationLabel.text = @"Miami, Florida"; // entry.location

    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"EEEE MMMM d, yyyy"];
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:entry.date];
    self.dateLabel.text = [dateFormatter stringFromDate:date];

    if(entry.imageData){
        self.mainImageView.image = [UIImage imageWithData:entry.imageData];
    } else {
        self.mainImageView.image = [UIImage imageNamed:@"icn_noimage"];
    }
    if(entry.mood == THDiaryEntryMoodGood){
        self.moodImageView.image = [UIImage imageNamed:@"icn_happy"]; //This will be the default because primitives default to 0
    } else if (entry.mood == THDiaryEntryMoodAverage) {
        self.moodImageView.image = [UIImage imageNamed:@"icn_average"];
    } else if (entry.mood == THDiaryEntryMoodBad) {
        self.moodImageView.image = [UIImage imageNamed:@"icn_bad"];
    }

}


@end
