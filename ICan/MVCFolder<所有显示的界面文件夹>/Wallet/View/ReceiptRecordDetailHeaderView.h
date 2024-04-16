//
//  ReceiptRecordDetailHeaderView.h
//  ICan
//
//  Created by Limaohuyu666 on 2019/11/12.
//  Copyright © 2019 dzl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReceiptRecordDetailHeaderView : UIView
@property (nonatomic,strong)DZIconImageView * iconImageView;
@property (nonatomic,strong)UILabel * namelabel;
@property(nonatomic, strong) ReceiveFlowsInfo *info;
@end

NS_ASSUME_NONNULL_END
