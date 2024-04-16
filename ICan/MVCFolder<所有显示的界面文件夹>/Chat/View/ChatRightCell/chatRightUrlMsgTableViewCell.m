//
//  ChatRightUrlMsgTableViewCell.m
//  ICan
//
//  Created by Manuka Dewanarayana on 2022-12-22.
//  Copyright © 2022 dzl. All rights reserved.
//

#import "ChatRightUrlMsgTableViewCell.h"
#import "DZTextView.h"
#import "XMFaceManager.h"
#import "MenuItem.h"
#import "WCDBManager.h"
#import "WCDBManager+ChatModel.h"
#import "ReactionBar.h"

@interface ChatRightUrlMsgTableViewCell()<UITextViewDelegate>
@property(nonatomic, strong) UIView *textBgView;
@property(nonatomic,strong)  UIImageView * containBgImageView;
@property(nonatomic, strong) UIStackView * textContentVerticalStackView;
@property(nonatomic,strong)  DZTextView * textView;
@property(nonatomic,strong)  UIImageView * urlThumbnailImgView;
@property(nonatomic,strong)  UIView *translateSegmentationView;
@property(nonatomic,strong)  UIView *translateLineView;
@property(strong, nonatomic)  UIView *translateTextBgView;
@property(nonatomic, strong)  UILabel *translateLabel;
@property(strong, nonatomic)  UIView *translateStateBgView;
@property(strong, nonatomic)  UIButton *translateBtn;
@property(nonatomic, strong)  UILabel *statueLabel;
@property(nonatomic, strong)  UIImageView *translateStatueImageView;
@property(nonatomic, strong) NSString *thumbnailImageurl;
@property(nonatomic, strong) NSString *thumbnailTitle;
@property(nonatomic, strong) UIView *thumbnailTitleView;
@property(nonatomic, strong) UIView *urlContainingView;
@property(nonatomic, strong) UILabel *thumbnailLabel;
@property(nonatomic, strong) UILabel *urlLabel;
@property(nonatomic, strong) UIImage *thumbnailPlaceholderIcon;
@property(nonatomic, strong) UIButton *seeMoreBtn;
@property(nonatomic, strong) UIView *seeMoreView;
@property(nonatomic,strong)  UILabel *timeLabelDown;
@property(nonatomic,strong)  UILabel *timeLabel;
@property(nonatomic, strong) ReactionBar *reactionBar;
@property(nonatomic, strong) UIView *reactionView;
@end
@implementation ChatRightUrlMsgTableViewCell

-(void)setcurrentChatModel:(ChatModel *)currentChatModel isShowName:(BOOL)isShowName isGroup:(BOOL)isGroup isShowTime:(BOOL)isShowTime{
    [super setcurrentChatModel:currentChatModel isShowName:isShowName isGroup:isGroup isShowTime:isShowTime];
    [self setTranslateState];
    [self.textBgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(self.currentChatModel.layoutWidth+10));
    }];
    if((self.currentChatModel.layoutHeight > 56.00) && !((self.currentChatModel.thumbnailTitleofTextUrl == nil) || (self.currentChatModel.thumbnailImageurlofTextUrl == nil) || [self.currentChatModel.thumbnailTitleofTextUrl isEqualToString: @"Undefined"] || [self.currentChatModel.thumbnailImageurlofTextUrl isEqualToString: @"Undefined"] || [self.currentChatModel.thumbnailTitleofTextUrl isEqualToString:@""] || [self.currentChatModel.thumbnailImageurlofTextUrl isEqualToString:@""])){
        [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@56);
        }];
    }else{
        [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(self.currentChatModel.layoutHeight));
        }];
    }
    self.currentChatModel.attrStr = [XMFaceManager emotionStrWithString:self.currentChatModel.showMessage isOutGoing:self.currentChatModel.isOutGoing];
    self.currentChatModel.attrStr = [NSString getUrl:self.currentChatModel.attrStr];
    if (self.searchText&&self.shouldHightShow) {
        NSRange rang=[self.currentChatModel.attrStr.string rangeOfString:self.searchText];
        [self.currentChatModel.attrStr addAttribute:NSBackgroundColorAttributeName value:UIColorMake(99, 174, 252) range:rang];
    }
    [self. textContentVerticalStackView addArrangedSubview:self.urlThumbnailImgView];
    [self.urlThumbnailImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@170);
    }];
    [self. textContentVerticalStackView addArrangedSubview:self.thumbnailTitleView];
    [self.thumbnailTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
    }];
    [self.thumbnailTitleView addSubview:self.thumbnailLabel];
    [self.thumbnailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.thumbnailTitleView.mas_top).offset(0);
        make.right.equalTo(self.thumbnailTitleView.mas_right).offset(-5);
        make.left.equalTo(@10);
    }];
    [self.thumbnailLabel setNumberOfLines:2];
    [self. textContentVerticalStackView addArrangedSubview:self.textView];
    [self. textContentVerticalStackView addArrangedSubview:self.seeMoreView];
    [self.seeMoreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
//        make.top.equalTo(@0);
    }];
    [self.seeMoreView addSubview:self.seeMoreBtn];
    [self.seeMoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.seeMoreView.mas_top).offset(-5);
        make.right.equalTo(@-10);
    }];
    NSDate*date=[GetTime dateConvertFromTimeStamp:currentChatModel.messageTime];
    self.timeLabelDown.text = [GetTime getTime:date];
    self.timeLabel.text = [GetTime getTime:date];
    [self.seeMoreView addSubview:self.timeLabelDown];
    [self.textView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.textContentVerticalStackView.mas_right).offset(-10);
        make.bottom.equalTo(self.textContentVerticalStackView.mas_bottom).offset(-2);
    }];
    [self.timeLabelDown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.textContentVerticalStackView.mas_right).offset(-10);
        make.bottom.equalTo(self.textContentVerticalStackView.mas_bottom).offset(-2);
    }];
    [self setSeeMoreAction];
    [self.textView setAttributedText:self.currentChatModel.attrStr];
    if((self.currentChatModel.thumbnailTitleofTextUrl == nil) || (self.currentChatModel.thumbnailImageurlofTextUrl == nil) || [self.currentChatModel.thumbnailTitleofTextUrl isEqualToString: @"Undefined"] || [self.currentChatModel.thumbnailImageurlofTextUrl isEqualToString: @"Undefined"] || [self.currentChatModel.thumbnailTitleofTextUrl isEqualToString:@""] || [self.currentChatModel.thumbnailImageurlofTextUrl isEqualToString:@""]){
        self.urlThumbnailImgView.image = UIImageMake(@"thumbnail_default_placeholder");
        self.thumbnailLabel.text = @"No preview";
        self.thumbnailTitleView.hidden = YES;
        self.urlThumbnailImgView.hidden = YES;
        self.textView.linkTextAttributes = @{NSForegroundColorAttributeName:[UIColor blueColor]};
    }
    else{
        self.thumbnailTitleView.hidden = NO;
        self.urlThumbnailImgView.hidden = NO;
        NSURL *url = [NSURL URLWithString:self.currentChatModel.thumbnailImageurlofTextUrl];
        self.thumbnailLabel.text = self.currentChatModel.thumbnailTitleofTextUrl;
        [self.urlThumbnailImgView sd_setImageWithURL:url placeholderImage:UIImageMake(@"thumbnail_default_placeholder")];
        self.textView.linkTextAttributes = @{NSForegroundColorAttributeName:[UIColor blueColor]};
    }
    if(![WebSocketManager sharedManager].hasNewWork){
        self.urlThumbnailImgView.image = UIImageMake(@"thumbnail_default_placeholder");
    }
    [self.seeMoreBtn setTitle:@"See More" forState:UIControlStateNormal];
    self.textView.textColor = [UIColor blackColor];
    [self setReactions:self.currentChatModel];
}

-(void)setReactions:(ChatModel *)model{
    if(model.reactions.count == 0){
        self.reactionBar.hidden = YES;
    }else{
        self.reactionBar.hidden = NO;
        [self.reactionBar setReactions:model];
    }
}

- (void)setTranslateState {
    switch (self.currentChatModel.translateStatus) {
        case 0:{
            self.translateStateBgView.hidden = YES;
            self.translateTextBgView.hidden = YES;
            self.translateSegmentationView.hidden=YES;
        }
            break;
        case 1:{
            self.translateStateBgView.hidden = NO;
            self.translateTextBgView.hidden=NO;
            self.translateSegmentationView.hidden=NO;
            self.statueLabel.textColor=UIColor.whiteColor;
            self.statueLabel.text=NSLocalizedString(@"Translation successful", 翻译成功);
            self.translateLabel.text=self.currentChatModel.translateMsg;
            self.translateStatueImageView.image=UIImageMake(@"translate_success_right");
        }
            break;
        case 2:{
            self.translateStateBgView.hidden = YES;
            self.translateTextBgView.hidden = NO;
            self.translateSegmentationView.hidden=NO;
            self.translateLabel.text=@"";
            self.statueLabel.text=NSLocalizedString(@"Retranslate", 重新翻译);
            self.statueLabel.textColor=UIColor244RedColor;
            self.translateStatueImageView.image=UIImageMake(@"chat_sendfailure_btn");
        }
            break;
    }
}

- (void)longPress:(UILongPressGestureRecognizer *)longPressGes {
    if(self.longpressStatus){
        self.convertRectView = self.containBgImageView;
        self.textView.selectedRange=NSMakeRange(0, [self.currentChatModel.attrStr string].length);
        [self.textView becomeFirstResponder];
        [super longPress:longPressGes];
    }
}

- (void)handleSingleTap:(UITapGestureRecognizer *)singleFingerTap{
    self.textView.selectedRange=NSMakeRange(0, [self.currentChatModel.attrStr string].length);
    [self.textView becomeFirstResponder];
    self.resetBlock();
}

- (void)clickMessageMunuView:(MenuItem *)item {
    if (item.selectMessageType ==SelectMessageTypeCopy) {
        UIPasteboard * pasterBoard = [UIPasteboard generalPasteboard];
        pasterBoard.string = [self.currentChatModel.showMessage substringWithRange:self.textView.selectedRange];
    }else if (item.selectMessageType==SelectMessageTypeTranslateHide){
        [self translateHideAction];
    }else if (item.selectMessageType==SelectMessageTypeTranslate){
        [self translateAction];
    }else if (item.selectMessageType==SelectMessageTypeAll){
        [self allChoseAction];
    }
}

- (void)translateAction {
    [[NetworkRequestManager shareManager]translateGeogleLanguageWithText:self.currentChatModel.attrStr.string success:^(NSString *translateText) {
        CGFloat tipsWidth=[NSString widthForString:NSLocalizedString(@"Translation successful", 翻译成功) withFontSize:13 height:20]+36;
        //1：判断原来的长度和原文字的长度 如果都小于最短长度 那么以最小长度为准
        //2:如果原来的文字长度是最大长度，那么翻译的label就以最大长度为准
        //3:如果翻译的长度是最大长度 但是那么需要重新计算原来的文字的高度
        //4:16+15+5+50 翻译之后的最小宽度就是80 最大的宽度就是KTextMaxWidth
        CGFloat translateWidth = [NSString widthForString:translateText withFontSize:16 height:20];
        translateWidth = translateWidth+16 > KTextMaxWidth ? KTextMaxWidth : translateWidth+16;
        translateWidth=translateWidth>tipsWidth?translateWidth:tipsWidth;
        //确保最小为宽度为80
        if (translateWidth>self.currentChatModel.layoutWidth||translateWidth==self.currentChatModel.layoutWidth) {
            self.currentChatModel.layoutWidth=translateWidth;
        }
        self.currentChatModel.translateStatus=1;
        self.currentChatModel.translateMsg=translateText;
        
        DDLogInfo(@"翻译成功=%@",translateText);
        QMUITableView*tableView=(QMUITableView*)self.superview;
        [tableView reloadData];
        [[WCDBManager sharedManager]updateTranslateWithChatmodel:self.currentChatModel];
    } failure:^(NSError *error) {
        self.currentChatModel.translateStatus=2;
        CGFloat tipsWidth=[NSString widthForString: NSLocalizedString(@"Translation failure", 翻译失败) withFontSize:13 height:20];
        if (self.currentChatModel.layoutWidth<=tipsWidth) {
            self.currentChatModel.layoutWidth=tipsWidth;
        }
        
        [[WCDBManager sharedManager]updateTranslateWithChatmodel:self.currentChatModel];
        QMUITableView*tableView=(QMUITableView*)self.superview;
        [tableView reloadData];
    }];
}

- (void)translateHideAction {
    self.currentChatModel.translateStatus=0;
    [[WCDBManager sharedManager]updateTranslateWithChatmodel:self.currentChatModel];
    QMUITableView*tableView=(QMUITableView*)self.superview;
    [tableView reloadData];
}

- (void)setSeeMoreAction {
    if(self.seeMoreBtnFlag){
        self.seeMoreView.hidden=NO;
        self.timeLabel.hidden = YES;
    }
    else{
        self.seeMoreView.hidden=YES;
        self.timeLabel.hidden = NO;
    }
}
- (void)seeMoreAction {
    if(self.textView.bounds.size.height <= 56.00){
        [self.seeMoreBtn setTitle:@"See Less" forState:UIControlStateNormal];
        [self.textView mas_updateConstraints:^(MASConstraintMaker *make){
            make.height.equalTo(@(self.currentChatModel.layoutHeight));
        }];
    } else{
        [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@56);
        }];
        [self.seeMoreBtn setTitle:@"See More" forState:UIControlStateNormal];
    }
}

- (void)allChoseAction {
    self.textView.selectedRange = NSMakeRange(0, self.textView.text.length);
}

- (void)addItmes {
    if(self.longpressStatus){
        [self.menuView showMessageMenuView:self.contentView convertRectView:self.containBgImageView ChatModel:self.currentChatModel showTime:self.isShowTime];
    }
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    if (textView.selectedRange.location>0 && textView.selectedRange.location <textView.text.length) {
        self.textView.selectedRange = textView.selectedRange;
    }
    if (textView.selectedRange.location==0 && textView.selectedRange.length==textView.text.length) {
        self.currentChatModel.isSelectAll = YES;
    }else{
        self.currentChatModel.isSelectAll = NO;
    }
    NSRange range=NSMakeRange(self.currentChatModel.attrStr.length, 0);
    if (textView.selectedRange.length!=0) {
        if (![[NSValue valueWithRange:range]isEqualToValue:[NSValue valueWithRange:textView.selectedRange]]) {
//            [self addItmes]; --> No need of message menu for double tab gestures.
        }
    }
}

- (void)setUpUI {
    [super setUpUI];
    [self.bodyContentView addSubview:self.textBgView];
    [self.textBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.bottom.right.top.equalTo(@0);
    }];
    [self.textBgView addSubview:self.containBgImageView];
    [self.containBgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [self.textBgView addSubview:self. textContentVerticalStackView];
    [self.textBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@200);
    }];
    [self.textContentVerticalStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [self. textContentVerticalStackView addArrangedSubview:self.translateSegmentationView];
    [self.translateSegmentationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@1);
    }];
    [self.translateSegmentationView addSubview:self.translateLineView];
    [self.translateLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(@0);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
    }];
    [self. textContentVerticalStackView addArrangedSubview:self.translateTextBgView];
    [self.translateTextBgView addSubview:self.translateLabel];
    [self.translateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@8);
        make.bottom.right.equalTo(@-8);
    }];
    [self. textContentVerticalStackView addArrangedSubview:self.translateStateBgView];
    [self.translateStateBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
    }];
    [self.translateStateBgView addSubview:self.translateBtn];
    [self.translateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [self.translateStateBgView addSubview:self.translateStatueImageView];
    [self.translateStatueImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.width.height.equalTo(@15);
        make.centerY.equalTo(_translateStateBgView.mas_centerY);
    }];
    [self.translateStateBgView addSubview:self.statueLabel];
    [self.statueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.translateStatueImageView.mas_right).offset(10);
        make.centerY.equalTo(_translateStateBgView.mas_centerY);
    }];
    UILongPressGestureRecognizer *textViewLongGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    self.containBgImageView.userInteractionEnabled = YES;
    textViewLongGesture.minimumPressDuration = 0.3;
    [self.containBgImageView addGestureRecognizer:textViewLongGesture];
    [self.textBgView addGestureRecognizer:textViewLongGesture];
    UITapGestureRecognizer *singleFingerTapForStack =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    UITapGestureRecognizer *singleFingerTapForTextView =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.textContentVerticalStackView addGestureRecognizer:singleFingerTapForStack];
    [self.textView addGestureRecognizer:singleFingerTapForTextView];
    [self.textBgView addSubview:self.reactionBar];
    [self.reactionBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@28);
        make.right.equalTo(@-10);
        make.width.greaterThanOrEqualTo(@52);
        make.bottom.equalTo(self.bodyContentView.mas_bottom).offset(22);
    }];
}

- (UIView *)textBgView {
    if (!_textBgView) {
        _textBgView = [[UIView alloc]init];
    }
    return _textBgView;
}

- (UIImageView *)containBgImageView {
    if (!_containBgImageView) {
        _containBgImageView = [[UIImageView alloc]initWithImage:UIImageMake(@"chat_message_content_mine_bg")];
        _containBgImageView.layer.cornerRadius = 10;
        _containBgImageView.layer.masksToBounds = YES;
    }
    return _containBgImageView;
}

- (UIStackView *)textContentVerticalStackView {
    if (!_textContentVerticalStackView) {
        _textContentVerticalStackView = [[UIStackView alloc]init];
        _textContentVerticalStackView.axis = UILayoutConstraintAxisVertical;
    }
    return _textContentVerticalStackView;
}

- (DZTextView *)textView {
    if (!_textView) {
        _textView = [[DZTextView alloc]init];
        _textView.delegate=self;
        _textView.textContainerInset=UIEdgeInsetsMake(8, 5, 8, 5);
        _textView.backgroundColor = UIColor.clearColor;
        _textView.editable = NO;
        _textView.scrollEnabled = NO;
        _textView.userInteractionEnabled = YES;
    }
    return _textView;
}
- (UIImageView *)urlThumbnailImgView {
    if (!_urlThumbnailImgView) {
        _urlThumbnailImgView = [[UIImageView alloc]init];
        _urlThumbnailImgView.contentMode = UIViewContentModeScaleToFill;
        _urlThumbnailImgView.backgroundColor = UIColorBg243Color;
        _urlThumbnailImgView.userInteractionEnabled = YES;
        [_urlThumbnailImgView layerWithCornerRadius:5 borderWidth:0 borderColor:nil];
    }
    return _urlThumbnailImgView;
}
- (UIView *)thumbnailTitleView {
    if (!_thumbnailTitleView) {
        _thumbnailTitleView = [[UIView alloc]init];
    }
    return _thumbnailTitleView;
}

- (UIView *)urlContainingView {
    if (!_urlContainingView) {
        _urlContainingView = [[UIView alloc]init];
    }
    return _urlContainingView;
}

- (UIView *)seeMoreView {
    if (!_seeMoreView) {
        _seeMoreView = [[UIView alloc]init];
        _seeMoreView.backgroundColor = UIColor.clearColor;
        [_seeMoreView layerWithCornerRadius:5 borderWidth:0 borderColor:nil];
    }
    return _seeMoreView;
}

- (UIImage *)thumbnailPlaceholderIcon {
    if(!_thumbnailPlaceholderIcon){
        _thumbnailPlaceholderIcon = [[UIImage alloc]init];
    }
    return _thumbnailPlaceholderIcon;
}

- (UILabel *)thumbnailLabel {
    if(!_thumbnailLabel){
        _thumbnailLabel = [[UILabel alloc]init];
        _thumbnailLabel.font = [UIFont boldSystemFontOfSize:17.0];
        _thumbnailLabel.userInteractionEnabled = YES;
        _thumbnailLabel.textColor = UIColor.blackColor;
    }
    return _thumbnailLabel;
}

- (UILabel *)urlLabel {
    if(!_urlLabel){
        _urlLabel = [[UILabel alloc]init];
        _urlLabel.font = [UIFont boldSystemFontOfSize:13.0];
        _urlLabel.userInteractionEnabled = YES;
        _urlLabel.textColor = UIColor.blackColor;
    }
    return _urlLabel;
}

- (UIButton *)seeMoreBtn {
    if (!_seeMoreBtn) {
        _seeMoreBtn = [UIButton dzButtonWithTitle:nil image:nil backgroundColor:UIColor.clearColor titleFont:0 titleColor:UIColor.blackColor target:self action:@selector(seeMoreAction)];
    }
    return _seeMoreBtn;
}

- (UIView *)translateSegmentationView {
    if (!_translateSegmentationView) {
        _translateSegmentationView = [[UIView alloc]init];
        _translateSegmentationView.backgroundColor = UIColor.clearColor;
        
    }
    return _translateSegmentationView;
}

- (UIView *)translateLineView {
    if (!_translateLineView) {
        _translateLineView = [[UIView alloc]init];
        _translateLineView.backgroundColor = UIColor.whiteColor;
    }
    return _translateLineView;
}

- (UIView *)translateTextBgView {
    if (!_translateTextBgView) {
        _translateTextBgView = [[UIView alloc]init];
        _translateTextBgView.backgroundColor = UIColor.clearColor;
        
    }
    return _translateTextBgView;
}

- (UILabel *)translateLabel {
    if (!_translateLabel) {
        _translateLabel = [UILabel leftLabelWithTitle:nil font:16 color:UIColor.whiteColor];
        _translateLabel.numberOfLines = 0;
    }
    return _translateLabel;
}

- (UIView *)translateStateBgView {
    if (!_translateStateBgView) {
        _translateStateBgView = [[UIView alloc]init];
        _translateStateBgView.backgroundColor  = UIColor.clearColor;
        
    }
    return _translateStateBgView;
}

- (UIButton *)translateBtn {
    if (!_translateBtn) {
        _translateBtn = [UIButton dzButtonWithTitle:nil image:nil backgroundColor:UIColor.clearColor titleFont:0 titleColor:nil target:self action:@selector(translateAction)];
    }
    return _translateBtn;
}

- (void)translateBtnAction {
    if (self.currentChatModel.translateStatus==2) {
        [self translateAction];
    }
}

- (UIImageView *)translateStatueImageView {
    if (!_translateStatueImageView) {
        _translateStatueImageView = [[UIImageView alloc]init];
    }
    return _translateStatueImageView;
}

- (UILabel *)statueLabel {
    if (!_statueLabel) {
        _statueLabel = [UILabel leftLabelWithTitle:nil font:13 color:UIColor.whiteColor];
    }
    return _statueLabel;
}
-(UILabel *)timeLabelDown{
    if (!_timeLabelDown) {
        _timeLabelDown = [UILabel leftLabelWithTitle:nil font:10 color:UIColor.blackColor];
    }
    return _timeLabelDown;
}
-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [UILabel leftLabelWithTitle:nil font:10 color:UIColor.blackColor];
    }
    return _timeLabel;
}

- (UIView *)reactionView{
    if (!_reactionView) {
        _reactionView = [[UIView alloc]init];
    }
    return _reactionView;
}

-(ReactionBar *)reactionBar{
    if(!_reactionBar){
        _reactionBar = [[ReactionBar alloc] init];
        _reactionBar.backgroundColor = UIColorMake(243, 243, 243);
    }
    return _reactionBar;
}
@end

