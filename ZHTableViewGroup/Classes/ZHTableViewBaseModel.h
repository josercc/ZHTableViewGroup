//
//  ZHTableViewBaseModel.h
//  Pods
//
//  Created by 张行 on 2017/3/18.
//
//

@interface ZHTableViewBaseModel : NSObject

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, strong) Class anyClass;
@property (nonatomic, assign) CGFloat height;

@end
