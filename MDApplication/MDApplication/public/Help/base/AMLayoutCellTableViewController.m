//
//  LBLayoutCellTableViewController.m
//  AMen
//
//  Created by libo on 15/10/14.
//

#import "AMLayoutCellTableViewController.h"

@implementation AMLayoutCellTableViewController

// UITableViewCell 改成自定义cell
// identifier 改成自定义identifier
// 显示错误 应为自动布局的问题

// cell 的 awakeFromNib 会被调用两次，只做和cell高度有关的工作

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"viewCell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {

}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 不缓存
    return [tableView fd_heightForCellWithIdentifier:@"viewCell" configuration:^(UITableViewCell *cell) {
        [self configureCell:cell atIndexPath:indexPath];
    }];
    // 按indexpath缓存
    return [tableView fd_heightForCellWithIdentifier:@"FDFeedCell" cacheByIndexPath:indexPath configuration:^(UITableViewCell *cell) {
        [self configureCell:cell atIndexPath:indexPath];
    }];
//    // 按model的标记缓存
//    return [tableView fd_heightForCellWithIdentifier:@"FDFeedCell" cacheByKey:@"" configuration:^(UITableViewCell *cell) {
//        [self configureCell:cell atIndexPath:indexPath];
//    }];
}

@end
