//
//  WLFormBottomButtonCell.h
//  WLForm
//
//  Created by 刘光强 on 2018/5/4.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BottomButtonBlock)(void);

@interface WLFormBottomButtonCell : UITableViewCell

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) BottomButtonBlock bottomButtonBlock;
@end
