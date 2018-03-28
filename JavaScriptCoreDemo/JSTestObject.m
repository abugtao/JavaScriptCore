//
//  JSTestObject.m
//  2015-01-31-WKWebViewDemo
//
//  Created by 张海涛 on 2017/4/27.
//  Copyright © 2017年 tangjr. All rights reserved.
//

#import "JSTestObject.h"

@implementation JSTestObject
- (void)callOCFunction{
    NSLog(@"aa,name = %@",self.name);
    
}

-(void)setName:(NSString *)name{
    _name = name;
}
@end
