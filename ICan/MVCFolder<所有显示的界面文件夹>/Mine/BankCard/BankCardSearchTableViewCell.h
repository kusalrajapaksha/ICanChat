//
//  BankCardSearchTableViewCell.h
//  ICan
//
//  Created by Limaohuyu666 on 2019/11/13.
//  Copyright © 2019 dzl. All rights reserved.
//

#import "BaseCell.h"

NS_ASSUME_NONNULL_BEGIN
static NSString * const KBankCardSearchTableViewCell =@"BankCardSearchTableViewCell";
static CGFloat const KHeightBankCardSearchTableViewCell = 34.0;
@interface BankCardSearchTableViewCell : BaseCell
@property(nonatomic,strong)CommonBankCardsInfo *commonBankCardsInfo;

@end

NS_ASSUME_NONNULL_END
