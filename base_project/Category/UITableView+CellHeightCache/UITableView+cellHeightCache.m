//
//  UITableView+cellHeightCache.m
//  MasoryTest
//
//  Created by 黄梦楚 on 17/6/3.
//  Copyright © 2017年 黄梦楚. All rights reserved.
//

#import "UITableView+cellHeightCache.h"
#import <objc/runtime.h>

static const NSString *heightCacheKey = @"hckey";

@implementation UITableView (cellHeightCache)

-(void)HC_cacheHeightForCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *rowDict = [self rowDictionaryForSection:indexPath.section];
//    if ([rowDict.allKeys containsObject:@(indexPath.row)]) return;
    [rowDict setObject:@(cell.frame.size.height) forKey:@(indexPath.row)];
}

-(void)HC_removeHeightAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *rowDict = [self rowDictionaryForSection:indexPath.section];
    [rowDict removeObjectForKey:@(indexPath.row)];
}

-(CGFloat)HC_cellHeightForIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *rowDict = [self rowDictionaryForSection:indexPath.section];
    NSNumber *height = [rowDict objectForKey:@(indexPath.row)];
    if (height) {
        NSLog(@"getCache  %.1f",height.floatValue);
        return height.floatValue;
    }else {
        return UITableViewAutomaticDimension;
    }
}

-(void)HC_reloadData
{
    [self.heightCache removeAllObjects];
    [self reloadData];
}

-(void)HC_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath *indexPath, NSUInteger idx, BOOL *stop) {
        NSMutableDictionary *rowDict = [self rowDictionaryForSection:indexPath.section];
        [rowDict removeObjectForKey:@(indexPath.row)];
    }];
    [self reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

-(void)HC_reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation
{
    [sections enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        [self.heightCache removeObjectForKey:@(idx)];
    }];
    [self reloadSections:sections withRowAnimation:animation];
}

-(void)HC_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    for (NSIndexPath *indexPathToInsert in indexPaths) {
        NSMutableDictionary *rowDict = [self rowDictionaryForSection:indexPathToInsert.section];
        long rowOfInsertItem = indexPathToInsert.row;
        NSMutableDictionary *newSectionDict = [NSMutableDictionary new];
        [rowDict enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSNumber *obj, BOOL * _Nonnull stop) {
            long row = [key integerValue];
            if (row >= rowOfInsertItem) {
                [newSectionDict setObject:obj forKey:@(row+1)];
            }else {
                [newSectionDict setObject:obj forKey:key];
            }
        }];
        [self.heightCache setObject:newSectionDict forKey:@(indexPathToInsert.section)];
    }
    [self insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

-(void)HC_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    for (NSIndexPath *indexPathToDelete in indexPaths) {
        NSMutableDictionary *rowDict = [self rowDictionaryForSection:indexPathToDelete.section];
        [rowDict removeObjectForKey:@(indexPathToDelete.row)];
        long rowOfToDeleteItem = indexPathToDelete.row;
        NSMutableDictionary *newSectionDict = [NSMutableDictionary new];
        [rowDict enumerateKeysAndObjectsUsingBlock:^(NSNumber * key, NSNumber * obj, BOOL * _Nonnull stop) {
            long row = [key integerValue];
            if (row > rowOfToDeleteItem) {
                [newSectionDict setObject:obj forKey:@(row-1)];
            }else {
                [newSectionDict setObject:obj forKey:key];
            }
        }];
        [self.heightCache setObject:newSectionDict forKey:@(indexPathToDelete.section)];
        NSLog(@"%@",rowDict);
    }
    [self deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

- (NSMutableDictionary *)rowDictionaryForSection:(NSInteger)section
{
    NSMutableDictionary *rowDict = [self.heightCache objectForKey:@(section)];
    if (!rowDict) {
        rowDict = [NSMutableDictionary dictionary];
        [self.heightCache setObject:rowDict forKey:@(section)];
    }
    return rowDict;
}

#pragma Setter & Getter

-(void)setHeightCache:(NSMutableDictionary *)heightCache
{
    if (heightCache != self.heightCache) {
        objc_setAssociatedObject(self, &heightCacheKey, heightCache, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

-(NSMutableDictionary *)heightCache
{
    if (!objc_getAssociatedObject(self, &heightCacheKey)) {
        objc_setAssociatedObject(self, &heightCacheKey, [NSMutableDictionary dictionary], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return objc_getAssociatedObject(self, &heightCacheKey);
}

@end
