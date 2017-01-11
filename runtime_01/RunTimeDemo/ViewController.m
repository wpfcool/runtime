//
//  ViewController.m
//  RunTimeDemo
//
//  Created by GTXD on 2017/1/9.
//  Copyright © 2017年 GTXD. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/runtime.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    Peopele * one = [[Peopele alloc]init];
    unsigned int count = 0;
    Ivar * ivars = class_copyIvarList([Person class], &count);

    for (int i = 0; i < count; i++) {
        Ivar var = ivars[i];
        const char * name = ivar_getName(var);
        const char * type = ivar_getTypeEncoding(var);
        
        
        NSLog(@"name:%s type:%s",name,type);
        
    }
    
    
    
    unsigned propertyCount = 0;
    objc_property_t * pro =   class_copyPropertyList([Person class], &propertyCount);
    for (int i = 0;  i < propertyCount; i++) {
        
       const char * name =  property_getName(pro[i]);
        NSLog(@"name-->%s",name);
        
    }
    
    
    
    unsigned methodCount = 0;
    Method * methods =  class_copyMethodList([Person class], &methodCount);
    for (int  i = 0; i < methodCount; i++) {
        Method  method = methods[i];
        SEL sel = method_getName(method);
        const char * name = sel_getName(sel);
        NSLog(@"%s",name);
    }
    
    unsigned protocolCount = 0;
    __unsafe_unretained Protocol ** protocolList = class_copyProtocolList([Person class], &protocolCount);
    for (int  i = 0; i < protocolCount; i++) {
        Protocol * myPrototcl = protocolList[i];
        NSLog(@"%s",protocol_getName(myPrototcl));
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
