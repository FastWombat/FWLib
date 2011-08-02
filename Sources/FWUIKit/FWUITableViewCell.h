@interface FWUITableViewCell : UITableViewCell {
}

+ (NSString*)reuseIdentifier;
+ (id)allocWithNibName:(NSString *)nibName;
+ (id)cell;
+ (id)reusableCellFromTableView:(UITableView *)tableView;
@end
