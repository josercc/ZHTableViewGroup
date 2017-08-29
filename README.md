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
     // 可以注册Header Footer 各种各样的Cell
   }
   ```

3. ### 初始化 ZHTableViewCell

   ```objc
   [group addCellWithCompletionHandle:^(ZHTableViewCell *cell) {  
     // 可以配置一种cell 可以是多个一样的必须是连续的
   }
   ```

4. ### 配置 ZHTableViewCell

   ```swift
     cell.anyClass = [UITableViewCell class];
               cell.cellNumber = self.cellTexts.count; //设置cell的个数
               cell.height = 44; // 设置cell的高度
               cell.identifier = @"UITableViewCellIdentifier"; // 设置标识符
               [cell setConfigCompletionHandle:^(UITableViewCell *cell, NSIndexPath *indexPath) { 
                 // 配置我们的cell
                   NSString *string = self.cellTexts[indexPath.row];
                   cell.textLabel.text = string;
                   if ([self.selectTitles containsObject:string]) {
                       cell.accessoryType = UITableViewCellAccessoryCheckmark;
                   } else {
                       cell.accessoryType = UITableViewCellAccessoryNone;
                   }
               }];
               [cell setDidSelectRowCompletionHandle:^(UITableViewCell *cell, NSIndexPath *indexPath) {
                 // 点击cell的对应回调
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

   > 现在可以自动设置代理 下面的方法默认是不需要设置的 如果有特殊的代码判断 需要自己实现 如果代码和下面一直  则不需要给UITableView设置代理即可

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