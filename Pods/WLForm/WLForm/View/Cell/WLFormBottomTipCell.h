//
//  WLFormBottomTipCell.h
//  WLForm
//
//  Created by 刘光强 on 2018/5/4.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BottomTipBlock)(void);

@interface WLFormBottomTipCell : UITableViewCell

@property (nonatomic, copy) NSString *tipStr;
@property (nonatomic, copy) BottomTipBlock tipBlock;
@end
