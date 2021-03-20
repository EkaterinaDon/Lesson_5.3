//
//  ImageCollectionViewCell.m
//  Lesson_5.3
//
//  Created by Ekaterina on 20.03.21.
//

#import "ImageCollectionViewCell.h"
@implementation ImageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.contentView.layer.shadowColor = [[[UIColor blackColor] colorWithAlphaComponent:0.2] CGColor];
        self.contentView.layer.shadowOffset = CGSizeMake(1.0, 1.0);
        self.contentView.layer.shadowRadius = 10.0;
        self.contentView.layer.shadowOpacity = 1.0;
        self.contentView.layer.cornerRadius = 6.0;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 90, 90)];
        [self.contentView addSubview: self.photoImageView];
        
        self.labelName = [[UILabel alloc] initWithFrame:CGRectMake(5, 100, 90, 40)];
        self.labelName.textAlignment = NSTextAlignmentLeft;
        self.labelName.font = [UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium];
        self.labelName.numberOfLines = 0;
        [self.contentView addSubview: self.labelName];
    }
    
    return self;
}


@end
