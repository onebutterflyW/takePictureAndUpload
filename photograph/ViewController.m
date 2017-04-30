//
//  ViewController.m
//  photograph
//
//  Created by 415 on 17/4/5.
//  Copyright © 2017年 415. All rights reserved.
//

#import "ViewController.h"
#import "JiuXZhenJiLu.h"
#import "AppDelegate.h"

@interface ViewController ()
{
    AppDelegate *delegate;

}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
       
    self.view.backgroundColor = [UIColor lightGrayColor];
    delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 150, 200, 40)];
    [btn setTitle:@"记录" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnTap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    delegate.titlePictureArr = [[NSMutableArray alloc]init];
    delegate.timePictureArr = [[NSMutableArray alloc]init];
    delegate.infoPictureArr = [[NSMutableArray alloc]init];
    delegate.contextPictrueArr = [[NSMutableArray alloc]init];
    delegate.pictureJiLuArr = [[NSMutableArray alloc]init];
    
}



-(void)btnTap{
    
   
    
    JiuXZhenJiLu *vc = [[JiuXZhenJiLu alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
