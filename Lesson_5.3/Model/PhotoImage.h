//
//  PhotoImage.h
//  Lesson_5.3
//
//  Created by Ekaterina on 20.03.21.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface PhotoImage : NSObject

@property (nonatomic, strong) UIImage *photo;
@property (nonatomic, strong) NSString *name;

- (instancetype)initWithName: (NSString *) name photo: (UIImage *) photo;

@end
