//
//  ViewController.m
//  DemoRun
//
//  Created by GTXD on 2017/1/10.
//  Copyright © 2017年 GTXD. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "Person.h"
@interface ViewController ()
-(void)crashMethod:(NSString *)str;
+(void)crashClassMethod:(NSString *)str;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   /// [self performSelector:@selector(crashMethod:) withObject:@"崩溃"];
    [self crashMethod:@"未实现的方法"];
}
void addMethod(id self,SEL sel, NSString * str)
{
    NSLog(@"%@",str);
}

//当调用的实例方法不存在时会调用次方法
+(BOOL)resolveInstanceMethod:(SEL)sel
{
    if([NSStringFromSelector(sel) isEqualToString:@"crashMethod:"])
    {
        class_addMethod(self, sel, (IMP)addMethod, "v@:@");
        return YES;
    }
    return NO;
}

-(id)forwardingTargetForSelector:(SEL)aSelector
{

    return [[Person alloc]init];
}

-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
  
    NSMethodSignature * methodSignature = [super methodSignatureForSelector:aSelector];
    if(methodSignature == nil)
    {
        methodSignature = [NSMethodSignature signatureWithObjCTypes:"v@:@"];
        
    }
    return methodSignature;
}
//必须实现methodSignatureForSelector 并返回不为空的NSMethodSignature
-(void)forwardInvocation:(NSInvocation *)anInvocation
{
      Person * person = [[Person alloc]init];
    if([person respondsToSelector:anInvocation.selector])
    {
        [anInvocation invokeWithTarget:person];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
