//
//  Person.h
//  RunTimeDemo
//
//  Created by GTXD on 2017/1/9.
//  Copyright © 2017年 GTXD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject<NSCopying,NSCoding>
{
    NSString * birthday;
}
@property (nonatomic,copy)NSString * name;
@property (nonatomic,assign) NSInteger age;
+(void)person;
-(void)eat;
-(void)sayHello;
@end
