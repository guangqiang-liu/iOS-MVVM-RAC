//
//  WLNetHostViewController.m
//  WLNetServer
//
//  Created by 于云飞 on 17/3/30.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "WLNetHostViewController.h"
#import "WLNetServer.h"
#import "WalletBase.h"
#import "WLNetDebug.h"
#import "WLConst.h"

@interface WLNetHostViewController ()

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation WLNetHostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择环境";
    
    [self navSetupRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewHost)]];
    
    self.tableView.rowHeight = 60;
    self.tableView.tableFooterView = [self footerView];
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    
    NSArray *hostInfo = NSUserDefaultsGet(URL_CONFIG_INFO);
    
    if (hostInfo) {
        self.dataArray = hostInfo;
    }else {
        NSDictionary *tmp = [WLConst netHost];
        NSMutableArray *mulArr = [NSMutableArray arrayWithCapacity:4];
        [tmp enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL * _Nonnull stop) {
            [mulArr addObject:@{@"key":SafeString(key),@"value":SafeString(obj)}];
        }];
        self.dataArray = mulArr;
        NSUserDefaultsSet([self.dataArray copy], URL_CONFIG_INFO);
    }
}

- (UIView *)footerView {
    UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __MAIN_WIDTH, 200)];
    bgview.backgroundColor = [UIColor clearColor];
    UILabel *tip = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, __MAIN_WIDTH, 40)];
    tip.text = @"选好了，戳我😂";
    tip.textColor = [UIColor redColor];
    tip.textAlignment = NSTextAlignmentCenter;
    tip.userInteractionEnabled = YES;
    [bgview addSubview:tip];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [tip addGestureRecognizer:tap];
    
    [[UIButton buttonWithFrame:CGRectMake(0, 120, __MAIN_WIDTH, 40) title:@"更新测试版" textColor:[UIColor blueColor] font:nil click:^{
        NSString *url = [WLConst appConfigWithKey:@"app_test_url"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }] setupOnView:bgview];
    
    return bgview;
}

-(void)update{
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:^{} success:YES info:nil];
}

- (void)addNewHost {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请输入host及des" message:@"host格式,如 http://xxxx:xx/" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    [alertView show];
}

- (NSAttributedString *)attributeString:(NSString *)string {
    NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:string attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:1.0 green:129/255.0 blue:83/255.0 alpha:0.8]}];
    return attStr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *reuseIdentifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
        cell.textLabel.font = FONT_SYSTEM_Bold(14);
        cell.detailTextLabel.font = FONT_SYSTEM_Bold(12);
        cell.tintColor = [UIColor orangeColor];
    }
    NSDictionary *dic = self.dataArray[indexPath.row];
    NSString *key = dic[@"key"];
    NSString *value = dic[@"value"];
    cell.textLabel.text = key;
    cell.detailTextLabel.text = value;
    
    if ([value isEqualToString:[WLNetServer wlHost]]) {
        cell.textLabel.textColor = cell.detailTextLabel.textColor = [UIColor orangeColor];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.alpha = 0.5;
    }else {
        cell.detailTextLabel.textColor = [UIColor colorWithWhite:0.4 alpha:1.0];
        cell.textLabel.textColor = [UIColor colorWithWhite:0.2 alpha:1.0];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *host = SafeString([self.dataArray[indexPath.row] objectForKey:@"value"]);
    NSUserDefaultsSet([host copy], URL_HOST_SELECTED);
    [WLNetServer setCustomWLHost:host];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [tableView reloadData];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(editingStyle == UITableViewCellEditingStyleDelete){
        NSMutableArray *mulArr = [NSMutableArray arrayWithArray:self.dataArray];
        [mulArr removeObjectAtIndex:indexPath.row];
        self.dataArray = [mulArr copy];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        NSUserDefaultsSet([self.dataArray copy], URL_CONFIG_INFO);
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        NSString *des = [alertView textFieldAtIndex:0].text;
        NSString *host = [alertView textFieldAtIndex:1].text;
        if (SafeString(host).length && SafeString(des).length) {
            if (buttonIndex == 1) {
                NSMutableArray *mulArr = [NSMutableArray arrayWithArray:self.dataArray];
                [mulArr addObject:@{@"key":des,@"value":host}];
                self.dataArray = [mulArr copy];
                [self.tableView reloadData];
                NSUserDefaultsSet([self.dataArray copy], URL_CONFIG_INFO);
            }
        }
    }
}

- (void)willPresentAlertView:(UIAlertView *)alertView {
    UITextField *des = [alertView textFieldAtIndex:0];
    UITextField *host = [alertView textFieldAtIndex:1];
    des.secureTextEntry = host.secureTextEntry = NO;
    des.attributedPlaceholder = [self attributeString:@"des *必填"];
    host.attributedPlaceholder = [self attributeString:@"host *必填"];
}

@end
