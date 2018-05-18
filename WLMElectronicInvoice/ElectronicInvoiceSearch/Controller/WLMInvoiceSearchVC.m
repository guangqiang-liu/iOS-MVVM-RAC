//
//  WLMInvoiceSearchVC.m
//  WLMElectronicInvoice
//
//  Created by 刘光强 on 2018/5/4.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import "WLMInvoiceSearchVC.h"
#import "WLMRecordFiltrVC.h"

@interface WLMInvoiceSearchVC ()

@end

@implementation WLMInvoiceSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = white_color;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 100);
    btn.backgroundColor = red_color;
    [btn whenTapped:^{
        WLMRecordFiltrVC *vc = [[WLMRecordFiltrVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [self.view addSubview:btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
