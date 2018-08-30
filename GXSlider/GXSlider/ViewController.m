//
//  ViewController.m
//  GXSlider
//
//  Created by Pro on 2018/8/24.
//  Copyright © 2018年 Pro. All rights reserved.
//

#import "ViewController.h"
#import "GX_Slider.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    GX_Slider *slider = [[GX_Slider alloc] initSliderWithFrame:CGRectMake(20, 80, self.view.frame.size.width - 40, 50) itemsTitles:@[@"-50%",@"-40%",@"-30%",@"-20%",@"-10%",@"100%",@"+10%",@"+20%",@"+30%",@"+40%",@"+50%"] SideTitles:@[@"-50%",@"50%"] defaultIndex:5 passedColor:[UIColor orangeColor] UnPassColor:[UIColor orangeColor] sliderImage:[UIImage imageNamed:@"centerPoint"]];
    slider.valueChangedBlock = ^(NSInteger currentIdx) {
        NSLog(@"当前index = %ld",(long)currentIdx);
    };
    [self.view addSubview:slider];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
