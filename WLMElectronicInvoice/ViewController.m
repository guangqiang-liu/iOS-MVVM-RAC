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
