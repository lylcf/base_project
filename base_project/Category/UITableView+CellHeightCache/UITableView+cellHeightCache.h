//
//  UITableView+cellHeightCache.h
//  MasoryTest
//
//  Created by 黄梦楚 on 17/6/3.
//  Copyright © 2017年 黄梦楚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (cellHeightCache)

@property (strong, nonatomic) NSMutableDictionary *heightCache;

-(void)HC_cacheHeightForCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
-(void)HC_removeHeightAtIndexPath:(NSIndexPath *)indexPath;

-(CGFloat)HC_cellHeightForIndexPath:(NSIndexPath *)indexPath;

-(void)HC_reloadData;

-(void)HC_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;

-(void)HC_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;

-(void)HC_reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation;

-(void)HC_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;

@end
