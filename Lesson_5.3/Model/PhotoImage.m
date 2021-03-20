//
//  PhotoImage.m
//  Lesson_5.3
//
//  Created by Ekaterina on 20.03.21.
//

#import "PhotoImage.h"

@implementation PhotoImage

- (instancetype)initWithName: (NSString *) name photo: (UIImage *) photo {
    self = [super init];
    if (self) {
        self.name = name;
        self.photo = photo;
    }
    return self;
}

@end
