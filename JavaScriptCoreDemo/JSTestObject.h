//
//  JSTestObject.h
//  2015-01-31-WKWebViewDemo
//
//  Created by 张海涛 on 2017/4/27.
//  Copyright © 2017年 tangjr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

//声明一个自定义的协议并继承自JSExport协议。然后当你把实现这个自定义协议的对象暴露给JS时，JS就能像使用原生对象一样使用OC对象了
//当你声明一个继承自JSExport的自定义协议时，就是在告诉JSCore，这个自定义协议中声明的属性，实例方法和类方法需要被暴露给JS使用。
@protocol JSTestObjectProtocol <JSExport>


- (void)callOCFunction;
-(void)setName:(NSString *)name;

@end
@interface JSTestObject : NSObject<JSTestObjectProtocol>

@property (nonatomic,copy) NSString *name;
@end
