//
//  ViewController.m
//  StudyHard
//
//  Created by waitwalker on 2020/12/22.
//

#import "ViewController.h"
#import <DeviceHelper/DeviceManager.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DeviceType type = [DeviceManager sharedManager].deviceType;
    NSLog(@"type:%ld",type);
}


@end
