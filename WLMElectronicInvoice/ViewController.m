//
//  ViewController.m
//  WLMElectronicInvoice
//
//  Created by 刘光强 on 2018/5/2.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import "ViewController.h"
#import "WLMInvoiceApplyVC.h"
#import "WLMInvoiceManagerListVC.h"
#import "WLMInvoiceSearchVC.h"
#import "WLMInvoiceDetailVC.h"

#define ktag 1000

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *array = @[@"电票申请",@"电票管理",@"电票搜索",@"电票详情"];
    for (NSInteger i = 0; i < 4; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(100, 100 + i * 60, 100, 40);
        button.tag = ktag + i;
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"字体图片测试" forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 400, 200, 30);
    btn.backgroundColor = [UIColor redColor];
    // UIButton使用大小自适应行不通
    //    [test.titleLabel sizeToFit];
    [btn setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];
    [btn setImage:[WLIcon iconWithName:@"keyboard_o" size:23 color:[UIColor orangeColor]] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    // UILable使用方式
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 180, 280, 40)];
    label.font = [UIFont fontWithName:@"iconfont" size:15]; //设置label的字体
    label.text = [WLIcon matchIconCodeWithName:@"play_o"];
    label.textColor = [UIColor redColor];
    // lable根据内容自适应大小
    [label sizeToFit];
    [self.view addSubview:label];
}

- (void)btnClick:(UIButton *)button {
    NSInteger tag = button.tag - ktag;
    if (tag == 0) {
        WLMInvoiceApplyVC *VC = [[WLMInvoiceApplyVC alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    } else if (tag == 1) {
        WLMInvoiceManagerListVC *VC = [[WLMInvoiceManagerListVC alloc] init];
      [self.navigationController pushViewController:VC animated:YES];
    } else if (tag == 2) {
        WLMInvoiceSearchVC *VC = [[WLMInvoiceSearchVC alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    } else {
        WLMInvoiceDetailVC *VC = [[WLMInvoiceDetailVC alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }
}
@end
