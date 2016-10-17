//
//  ViewController.m
//  rrr
//
//  Created by  张晓宇 on 16/7/15.
//  Copyright © 2016年 SH. All rights reserved.
//

#import "ViewController.h"
#import "LSYReadViewController.h"
#import "LSYReadPageViewController.h"
#import "LSYReadUtilites.h"
#import "LSYReadModel.h"


#import "shuJiaViewController.h"
@interface ViewController ()
@property (nonatomic,strong) UIActivityIndicatorView * activity;
@property (nonatomic,strong) UIActivityIndicatorView * epubActivity;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    self.title = @"电子书模块";
    _activity.hidesWhenStopped = YES;
   // self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"1111"]];
    [self createBookDemo];
}
//进入电子书模块
-(void)createBookDemo
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(50, 150, 200, 40);
    [btn setTitle:@"电子书模块" forState:UIControlStateNormal];
     btn.backgroundColor = [UIColor whiteColor];
    [btn addTarget:self action:@selector(bookDemoBtn:) forControlEvents:
     UIControlEventTouchUpInside];
    //btn.backgroundColor = [UIColor blackColor];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithTitle:[NSString stringWithFormat:@"电子书"]
                                             style:UIBarButtonItemStylePlain
                                             target:self
                                             action:nil];
    [self.view addSubview:btn];
}
-(void)bookDemoBtn:(UIButton *)sender
{
    shuJiaViewController * shujia = [[shuJiaViewController alloc]init];
    [self.navigationController pushViewController:shujia animated:YES];
    //[self presentModalViewController:shujia animated:YES];
}


-(void)createUI
{
    UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn1.frame = CGRectMake(self.view.frame.size.width / 2 - 50, 300, 100, 50);
    [btn1 setTitle:@"测试阅读界面" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor whiteColor];
    [btn1 addTarget:self action:@selector(btn1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
}
-(void)btn1:(UIButton *)btn1
{
  
    
    
    [_epubActivity startAnimating];

    LSYReadPageViewController *pageView = [[LSYReadPageViewController alloc] init];
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"未来很美好15" withExtension:@"epub"];
  //  NSURL * fileUrl = [NSURL URLWithString:@"未来边缘"];
    pageView.resourceURL = fileURL;    //文件位置
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        pageView.model = [LSYReadModel getLocalModelWithURL:fileURL];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_epubActivity stopAnimating];
           
            [self presentViewController:pageView animated:YES completion:nil];
           
        });
    });
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
