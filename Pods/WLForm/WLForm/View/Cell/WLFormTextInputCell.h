//
//  WLFormTextInputCell.h
//  WLForm
//
//  Created by 刘光强 on 2018/4/16.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLFormTextInputCell : UITableViewCell

@property (nonatomic, strong) UILabel *leftlabel;
@property (nonatomic, strong) UITextField *rightField;
@property (nonatomic, copy) void(^textChangeBlock)(NSString *text);
@end
