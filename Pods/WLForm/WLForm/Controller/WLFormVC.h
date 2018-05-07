//
//  WLFormVC.h
//  WLForm
//
//  Created by 刘光强 on 2018/4/16.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WLForm;

@interface WLFormVC : UIViewController

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) WLForm *form;
@end
