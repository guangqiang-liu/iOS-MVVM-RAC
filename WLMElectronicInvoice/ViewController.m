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
#import "WLMInvoiceDetailVC.h"
#import "WLCircleProgressView.h"
#import "WLMPackageSelectVC.h"
#import "WLMSelectApplyMerchantVC.h"
#import "WLMInvoiceDetailVC.h"
#import "WLMOpenInvoiceVC.h"

#import "WLMSelectedApplyMerchantVM.h"
#import "WLMSelectApplyMerchantVC.h"
#import "WLBViewModelServiceImp.h"
#import "WLMInvoiceManagerListVC.h"

@interface ViewController ()

@property (nonatomic, strong) WLBViewModelServiceImp *viewModelService;
@property (nonatomic, strong) WLMSelectApplyMerchantVC *VC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.viewModelService = [[WLBViewModelServiceImp alloc] init];
    WLMSelectedApplyMerchantVM *viewModel = [[WLMSelectedApplyMerchantVM alloc] initWithService:self.viewModelService params:nil];
    self.VC = [[WLMSelectApplyMerchantVC alloc] initWithViewModel:viewModel];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 300, 100);
    btn.backgroundColor = [UIColor redColor];
    btn.center = self.view.center;
    [btn setTitle:@"电子发票模块组件" forState: UIControlStateNormal];
    [btn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)push {
    [self.navigationController pushViewController:self.VC animated:YES];
}
@end
