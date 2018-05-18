//
//  WLMInvoiceManagerListVC.m
//  WLMElectronicInvoice
//
//  Created by 刘光强 on 2018/5/4.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import "WLMInvoiceManagerListVC.h"
#import "HMSegmentedControl.h"
#import "WLMRequirementListVC.h"
#import "WLMRecordListVC.h"
#import "WLMPackageInfoVC.h"

@interface WLMInvoiceManagerListVC () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) HMSegmentedControl *segmentedControl;
@property (nonatomic, strong) NSMutableArray *childControllers;

@end

@implementation WLMInvoiceManagerListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"电子发票管理";
    self.view.backgroundColor = bgColor;
    
    [self segmentLaunch];
}

- (void)segmentLaunch {
    self.segmentedControl = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 44)];
    self.segmentedControl.sectionTitles = @[@"开票请求", @"开票记录", @"套餐情况"];
    self.segmentedControl.selectedSegmentIndex = 1;
    self.segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
    self.segmentedControl.backgroundColor = [UIColor whiteColor];
    self.segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor lightGrayColor]};
    self.segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor]};
    self.segmentedControl.selectionIndicatorColor = [UIColor redColor];
    self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedControl.tag = 3;
    
    __weak typeof(self) weakSelf = self;
    [self.segmentedControl setIndexChangeBlock:^(NSInteger index) {
        [weakSelf.scrollView scrollRectToVisible:CGRectMake(SCREEN_WIDTH *index, 0, SCREEN_WIDTH, 200) animated:YES];
    }];
    
    [self.view addSubview:self.segmentedControl];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 108, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH *3, SCREEN_HEIGHT);
    self.scrollView.delegate = self;
    [self.scrollView scrollRectToVisible:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT) animated:NO];
    [self.view addSubview:self.scrollView];
    
    [self addChildControllers];
}

- (void)addChildControllers {
    self.childControllers = [[NSMutableArray alloc] initWithCapacity:3];
    
    for (int i = 1; i < 4; i ++) {
        if (1 == i) {
            WLMRequirementListVC *vc = [[WLMRequirementListVC alloc] init];
            [self.childControllers addObject:vc];
        } else if (2 == i) {
            WLMRecordListVC *vc = [[WLMRecordListVC alloc] init];
            [self.childControllers addObject:vc];
        } else if (3 == i) {
            WLMPackageInfoVC *vc = [[WLMPackageInfoVC alloc] init];
            [self.childControllers addObject:vc];
        }
    }
    
    [self.childControllers enumerateObjectsUsingBlock:^(UIViewController *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view = obj.view;
        view.frame = CGRectMake(idx*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self.scrollView addSubview:view];
    }];
//    [self.scrollView setContentSize:CGSizeMake(3 * SCREEN_WIDTH, SCREEN_HEIGHT)];
}

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
}

- (void)uisegmentedControlChangedValue:(UISegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld", (long)segmentedControl.selectedSegmentIndex);
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    
    [self.segmentedControl setSelectedSegmentIndex:page animated:YES];
}

//- (UIScrollView *)scrollView {
//    if (_scrollView == nil) {
//
//    }
//    return _scrollView;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
