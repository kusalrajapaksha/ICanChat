//
/**
- Copyright © 2019 dzl. All rights reserved.
- Author: Created  by DZL on 3/12/2019
- File name:  BaseTableListViewController.h
- Description: 有分页的查询
- Function List:
*/
        

#import "QDCommonTableViewController.h"
#import <MJRefresh.h>
NS_ASSUME_NONNULL_BEGIN

@interface C2CBaseTableListViewController : QDCommonTableViewController
@property (nonatomic,assign) NSInteger  current;
/** 获取每页多少条数据 */
@property (nonatomic,assign) NSInteger  pageSize;
@property (nonatomic,strong) C2CListInfo * listInfo;
@property (nonatomic,strong) C2CListRequest * listRequest;
@property (nonatomic) Class  listClass;
@property (nonatomic,strong) NSMutableArray * listItems;
/// 当前是否是正在自动加载更多数据
@property (nonatomic,assign) BOOL  isLoadMoreData;
/// 是否是自动加载
@property(nonatomic, assign) BOOL isAutoLoad;
-(void)handleFetchlistSuccess:(C2CListInfo*)response;
-(void)fetchListRequest;
-(void)endingRefresh;
-(void)checkHasFooter;
-(void)loadMore;
-(void)refreshList;
@end

NS_ASSUME_NONNULL_END
