//
//  SettingGroupManagerViewController.h
//  ICan
//
//  Created by Limaohuyu666 on 2020/1/11.
//  Copyright © 2020 dzl. All rights reserved.
//

#import "QDCommonTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SettingGroupManagerViewController : QDCommonTableViewController
@property(nonatomic, strong) NSArray<GroupMemberInfo*> *allMemberItems;
@property(nonatomic, strong) GroupListInfo *groupDetailInfo;
@property (nonatomic,assign) BOOL isMuteUserView;
@end

NS_ASSUME_NONNULL_END
