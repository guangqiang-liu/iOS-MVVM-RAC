//
//  WLMEInvoiceProtocolVC.m
//  WLMElectronicInvoice
//
//  Created by 刘光强 on 2018/5/16.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import "WLMEInvoiceProtocolVC.h"

@interface WLMEInvoiceProtocolVC ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *content;
@end

@implementation WLMEInvoiceProtocolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"电子发票合作协议";
}

- (void)renderViews {
    [super renderViews];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.content];
    CGSize contentSize = [UILabel calculateLableSizeWithLableText:self.content.text font:[UIFont systemFontOfSize:14] lineSpace:5 maxWidth:SCREEN_WIDTH];
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, contentSize.height);
}

- (UILabel *)content {
    if (!_content) {
        _content = [[UILabel alloc] init];
        _content.frame = CGRectMake(10, 0, SCREEN_WIDTH - 20, SCREEN_HEIGHT);
        _content.text = @"钱包生活电子发票服务合同 甲方： 乙方: 钱包生活(平潭)科技有限公司 甲乙双方根据《中华人民共和国合同法》及其他有关法律规定，遵循自愿、公平、诚实信用的原则，就一体化电子发票开发、应用、服务事宜订立本合同： 一、合作内容 1、乙方为甲方提供一体化电子发票产品开发、应用及服务。 2、甲方需自备航信金税盘或百望税控盘，并完成电子发票的票种核定及发行。 二、费用支付 1、甲方应向乙方支付电子发票服务套餐年费，套餐费用及套餐内容以甲方在乙方钱包商家APP后台系统（以下简称\"系统\"）中选择的结果为准，甲方须在选择后10个工作日内付清套餐年费给乙方。一经选择，该套餐年度内不得再做修改。 2、套餐到期，甲方可在乙方系统内再次选择套餐费用及套餐内容，并在选择后10个工作日内付清款项给乙方，以此类推。 3、每个套餐期内，如甲方使用电子发票张数超过套餐容量的，超出部分按0.1元/张计费，先付后用，甲方每次预付1000元给乙方，如甲方未预付费用，则乙方可暂停提供电子发票服务。套餐到期，预付费用仍有剩余的，乙方在结算款项完毕后10个工作日内退还余款给甲方。 4、甲方款项支付至乙方如下收款账户： 开户名：钱包生活(平潭)科技有限公司 开户银行：中国银行股份有限公司福建自贸试验区平潭片区分行 银行账号：4299 7078 4295 5、乙方收取套餐费用后10个工作日内，提供6%的增值税普通发票给甲方，预付费用的发票至套餐到期结算完毕款项后10个工作日内提供给甲方。 三、质量保证 1、电子发票标准接口功能以乙方提供的说明书定义为准，并且符合税务机关规定的电子发票接口规范。 2、乙方已经集成短信及邮件发送电子发票下载地址服务。甲方已知晓前述事宜、且确认：为了保障甲方的收票客户正常接收电子发票，甲方应将此服务告知收票客户。 四、知识产权与保密 1、合同中各自的软件、文档、设计等分别属于各自的知识产权。 2、甲、乙双方应保守通过磋商、签订和履行本合同中而获取的对方商业秘密，包括合同文本、技术文件、图表数据以及商业模式、收费标准等相关信息，不得向第三方泄露。 3、保密期限不受本合同期限的限制，合同履行完毕后保密信息接受方仍应承担保密义务。 五、责任约定 1、如甲方有违反法律法规的行为，乙方有权停止服务、终止本合同，并没收甲方全部已付款项，且由甲方负责赔偿因此给乙方造成的损失。 2、如甲方逾期支付费用累计超过10日的，本合同自动解除。如因此给乙方造成损失的，甲方负责赔偿给乙方。 3、如有不可抗力事件，或政策调整，或因乙方发生分立、合并、业务变更，或因法律法规及合同约定的其他情形，乙方可进行变更或终止本合同且不承担违约责任。如变更的，双方另行签署书面的补充合同。补充合同与本合同具有同等的法律效力。如终止的，自乙方告知甲方的终止之日，本合同自动终止，乙方退还甲方未发生的已付款项。 六、廉洁条款 甲方不得向乙方及乙方关联方之员工、代理人提供任何形式的不正当利益。如有，则视为甲方根本性违约，乙方有权提前部分或全部终止本合同，且甲方应按本合同总价款的30％或提供任何形式的不正当利益的总金额或乙方遭受的全部损失，三者中最高的一项向乙方进行赔偿，并且乙方将有权追究甲方的法律责任。如任何人员有违反本廉洁条款的，均可举报至乙方稽核部（邮箱：jihebu-sh@qianbaocard.com 电话：021-64851360-8074）。 七、其他 1、因本合同产生的争议，甲乙双方应当协商解决，协商不成由本合同签订地上海市闵行区人民法院管辖。 2、本合同期限自甲方不再选择套餐、且最后一次选择的套餐到期之日结束。 3、本合同壹式贰份，甲、乙双方各执壹份，自双方签字盖章后生效。 甲方（盖章）： 乙方（盖章）： 法人代表或授权代表（签字）： 法人代表或授权代表（签字）： 联系人： 联系方式： 联系人： 联系方式： 通讯地址： 通讯地址： 日期： 年 月 日 日期： 年 月 日";
        _content.font = H14;
        _content.textColor = textBlackColor;
        _content.numberOfLines = 0;
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        CGFloat emptylen = _content.font.pointSize * 2;
        paraStyle.firstLineHeadIndent = emptylen;
        paraStyle.lineSpacing = 5.0f;
        NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:_content.text attributes:@{NSParagraphStyleAttributeName:paraStyle}];
        _content.attributedText = attrText;
    }
    return _content;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = self.view.bounds;
    }
    return _scrollView;
}

@end
