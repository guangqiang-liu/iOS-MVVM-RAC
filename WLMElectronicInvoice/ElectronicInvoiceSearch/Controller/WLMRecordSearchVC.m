//
//  WLMRecordSearchVC.m
//  WLMElectronicInvoice
//
//  Created by Saturday on 2018/5/16.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import "WLMRecordSearchVC.h"
#import "ImageTextField.h"

@interface WLMRecordSearchVC () <UITextFieldDelegate>

@property (nonatomic, strong) ImageTextField *textfield;

@end

@implementation WLMRecordSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = bgColor;
    
    [self setupViews];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [self.textfield resignFirstResponder];
}

- (void)setupViews {
    self.navigationItem.titleView = self.textfield;
    [self addRightBtn];
}

- (void)addRightBtn {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelClicked:)];
}

#pragma mark - get set

- (ImageTextField *)textfield {
    if (_textfield == nil) {
        UIImage *image = UIImageName(@"filter_search_icon");
        _textfield = [[ImageTextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 120, 30) leftImage:image imageSize:image.size];
        _textfield.placeholder = @"输入抬头名称、邮箱地址、手机号搜索";
        if (self.searchContent.length > 0) {
            _textfield.text = self.searchContent;
        }
        _textfield.delegate = self;
        [_textfield becomeFirstResponder];
    }
    return _textfield;
}

- (void)cancelClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //判断加上输入的字符，是否超过界限
    NSString *searchString = [NSString stringWithFormat:@"%@%@", textField.text, string];
    if (searchString.length >= 5){
        return NO;
    }
    
    if (self.invoiceRecordSearchBlock) {
        self.invoiceRecordSearchBlock(self.textfield.text);
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
