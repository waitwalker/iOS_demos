//
//  ViewController.m
//  ForwardingMethod
//
//  Created by etiantian on 2020/5/18.
//  Copyright © 2020 etiantian. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "NSObject+ForwardMethod.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton new];
    button.frame = CGRectMake(100, 100, 100, 100);
    button.backgroundColor = UIColor.brownColor;
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)buttonAction {
    [self performSelector:@selector(buttonAction) withObject:[Person new]];
}

//- (id)forwardingTargetForSelector:(SEL)aSelector {
//    if (aSelector == @selector(buttonAction)) {
//        return [Person new];
//    }
//    return [super forwardingTargetForSelector:aSelector];
//}


@end
