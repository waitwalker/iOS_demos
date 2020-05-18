//
//  ViewController.m
//  fastocr
//
//  Created by etiantian on 2020/5/8.
//  Copyright © 2020 etiantian. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadButton];
}

- (void)loadButton {
    UIButton *tipBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 150, 200, 60)];
    tipBtn.backgroundColor = [UIColor greenColor];
    [tipBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [tipBtn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [tipBtn setTitle:@"hello_jspatch" forState:UIControlStateNormal];
    [tipBtn addTarget:self action:@selector(clickedBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tipBtn];
}

- (void)clickedBtn:(UIButton *)sender {
    
}



@end
