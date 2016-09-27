//
//  QYUserModel.m
//  青云微博
//
//  Created by qingyun on 16/7/14.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "QYUserModel.h"

@implementation QYUserModel

+ (instancetype)userModelWithDictionary:(NSDictionary *)dicData {
    // 判断传进来的字典是否合, 如果不合法, 直接返回空
    if (dicData == nil || [dicData isKindOfClass:[NSNull class]]) return nil;
    QYUserModel *user = [self new];
    
    /** idstr	string	字符串型的用户UserId */
    user.strIdstr = dicData[@"idstr"];
    
    /** screen_name	string	用户昵称, NickName */
    user.strScreenName = dicData[@"screen_name"];
    
    /** name	string	友好显示名称 */
    user.strName = dicData[@"name"];
    
    /** description	string	用户个人描述 */
    user.strUserDescription = dicData[@"description"];
    
    /** profile_image_url	string	用户头像地址（中图），50×50像素 */
    user.strProfileImageUrl = dicData[@"profile_image_url"];
    
    /** followers_count	int	粉丝数 */
    user.followersCount = [dicData[@"followers_count"] integerValue];
    
    /** friends_count	int	关注数 */
    user.friendsCount = [dicData[@"friends_count"] integerValue];
    
    /** statuses_count	int	微博数 */
    user.statusesCount = [dicData[@"statuses_count"] integerValue];
    
    /** favourites_count	int	收藏数 */
    user.favourites_count = [dicData[@"favourites_count"] integerValue];
    
    /** avatar_large	string	用户头像地址（大图），180×180像素 */
    user.strAvatarLarge = dicData[@"avatar_large"];
    
    /** avatar_hd	string	用户头像地址（高清），高清头像原图 */
    user.strAvatarHd = dicData[@"avatar_hd"];
    
    // 用下面这个方法的前提: key值必须和属性的名字一模一样
    //[user setValuesForKeysWithDictionary:<#(nonnull NSDictionary<NSString *,id> *)#>];
    // 利用循环解决
    //[user setValue:<#(nullable id)#> forKey:<#(nonnull NSString *)#>];
    
    return user;
}
//在sqlite数据库中微博主页表插入记录
//归档的方法 实体=>NSData
-(void) encodeWithCoder:(NSCoder *) aCoder{
    [aCoder encodeObject:self.strIdstr forKey:@"idstr"];
    [aCoder encodeObject:self.strScreenName forKey:@"screen_name"];
    [aCoder encodeObject:self.strName forKey:@"name"];
    [aCoder encodeObject:self.strUserDescription forKey:@"description"];
    [aCoder encodeObject:self.strProfileImageUrl forKey:@"profile_image_url"];
    [aCoder encodeInteger:self.followersCount forKey:@"followers_count"];
    [aCoder encodeInteger:self.friendsCount forKey:@"friends_count"];
    [aCoder encodeInteger:self.statusesCount forKey:@"statuses_count"];
    [aCoder encodeInteger:self.favourites_count forKey:@"favourites_count"];
    [aCoder encodeObject:self.strAvatarLarge forKey:@"avatar_large"];
    [aCoder encodeObject:self.strAvatarHd forKey:@"avatar_hd"];
}
//在sqlite数据库中查询微博主页表中的记录
//解档 nsdata=>实体
-(id) initWithCoder:(NSCoder *) aDecoder{
    if (self=[super init]) {
        self.strIdstr=[aDecoder decodeObjectForKey:@"idstr"];
        self.strScreenName=[aDecoder decodeObjectForKey:@"screen_name"];
        self.strName=[aDecoder decodeObjectForKey:@"name"];
        self.strUserDescription=[aDecoder decodeObjectForKey:@"description"];
        self.strProfileImageUrl=[aDecoder decodeObjectForKey:@"profile_image_url"];
        self.followersCount=[aDecoder decodeIntegerForKey:@"followers_count"];
        self.friendsCount=[aDecoder decodeIntegerForKey:@"friends_count"];
        self.statusesCount=[aDecoder decodeIntegerForKey:@"statuses_count"];
        self.favourites_count=[aDecoder decodeIntegerForKey:@"favourites_count"];
        self.strAvatarLarge=[aDecoder decodeObjectForKey:@"avatar_large"];
        self.strAvatarHd=[aDecoder decodeObjectForKey:@"avatar_hd"];
    }
    return self;

}
@end
