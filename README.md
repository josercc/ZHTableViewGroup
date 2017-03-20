# Swift 版本请移步[这里](https://github.com/josercc/ZHTableViewGroupSwift)

# ZHTableViewGroup为 UITableView 而生

![](http://olg3v8vew.bkt.clouddn.com/2017-03-16-38.gif)

## 怎么安装

```ruby
pod 'ZHTableViewGroupObjc'
```



### 怎么使用

1. ### 初始化 ZHTableViewDataSource

   ```objc
   @property (nonatomic, strong) ZHTableViewDataSource *dataSource;
   self.dataSource = [[ZHTableViewDataSource alloc] initWithTableView:self.tableView];
   ```

2. ### 初始化 ZHTableViewGroup 

   ```objc
   [self.dataSource addGroupWithCompletionHandle:^(ZHTableViewGroup *group) {
   }
   ```

3. ### 初始化 ZHTableViewCell

   ```objc
   [group addCellWithCompletionHandle:^(ZHTableViewCell *cell) {  
   }
   ```

4. ### 配置 ZHTableViewCell

   ```swift
     cell.anyClass = [UITableViewCell class];
               cell.cellNumber = self.cellTexts.count;
               cell.height = 44;
               cell.identifier = @"UITableViewCellIdentifier";
               [cell setConfigCompletionHandle:^(UITableViewCell *cell, NSIndexPath *indexPath) {
                   NSString *string = self.cellTexts[indexPath.row];
                   cell.textLabel.text = string;
                   if ([self.selectTitles containsObject:string]) {
                       cell.accessoryType = UITableViewCellAccessoryCheckmark;
                   } else {
                       cell.accessoryType = UITableViewCellAccessoryNone;
                   }
               }];
               [cell setDidSelectRowCompletionHandle:^(UITableViewCell *cell, NSIndexPath *indexPath) {
                   NSString *string = self.cellTexts[indexPath.row];
                   if ([self.selectTitles containsObject:string]) {
                       [self.selectTitles removeObject:string];
                   } else {
                       [self.selectTitles addObject:string];
                   }
                   [self.tableView reloadData];
               }];

   ```

5. ### 配置 UITableView的代理

   ```objc
   - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
       return [ZHTableViewDataSource heightForRowAtDataSource:self.dataSource indexPath:indexPath customHeightCompletionHandle:nil];
   }
   - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
       return [ZHTableViewDataSource numberOfRowsInSectionWithDataSource:self.dataSource section:section];
   }
   - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
       return [ZHTableViewDataSource cellForRowAtWithDataSource:self.dataSource indexPath:indexPath];
   }
   - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
       [tableView deselectRowAtIndexPath:indexPath animated:YES];
       [ZHTableViewDataSource didSelectRowAtWithDataSource:self.dataSource indexPath:indexPath];
   }

   ```

### 6 清除配置

```objc
[self.dataSource clearData];
```