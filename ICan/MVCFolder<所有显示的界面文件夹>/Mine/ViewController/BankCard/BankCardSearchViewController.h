//
//  BankCardSearchViewController.h
//  ICan
//
//  Created by Limaohuyu666 on 2019/11/13.
//  Copyright © 2019 dzl. All rights reserved.
//

#import "QDCommonTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BankCardSearchViewController : QDCommonTableViewController
@property(nonatomic, copy) void (^searchBankcarBlock)(CommonBankCardsInfo*info);
@end

NS_ASSUME_NONNULL_END
