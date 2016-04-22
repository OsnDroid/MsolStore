//
//  Account.m
//  MsolStore
//
//  Created by IoCan on 16/4/20.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "Account.h"

@implementation Account

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.username forKey:pch_username];
    [aCoder encodeObject:self.name forKey:pch_name];
    [aCoder encodeObject:self.city forKey:pch_city];
    [aCoder encodeObject:self.area forKey:pch_area];
    [aCoder encodeObject:self.area2 forKey:pch_area2];
    [aCoder encodeObject:self.channel_id forKey:pch_channelId];
    [aCoder encodeObject:self.sell_name forKey:pch_sellName];
    [aCoder encodeObject:self.dz_flag forKey:pch_dzFlag];
    [aCoder encodeObject:self.threeG forKey:pch_threeG];
    [aCoder encodeObject:self.fourG forKey:pch_fourG];
    [aCoder encodeObject:self.card forKey:pch_card];
    [aCoder encodeObject:self.phone forKey:pch_phone];
    [aCoder encodeObject:self.password forKey:pch_password];
    [aCoder encodeObject:self.address forKey:pch_address];
    [aCoder encodeInt:self.level forKey:pch_level];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self == [self init]) {
        self.username = [aDecoder decodeObjectForKey:pch_username];
        self.name = [aDecoder decodeObjectForKey:pch_name];
        self.city = [aDecoder decodeObjectForKey:pch_city];
        self.area = [aDecoder decodeObjectForKey:pch_area];
        self.area2 = [aDecoder decodeObjectForKey:pch_area2];
        self.channel_id = [aDecoder decodeObjectForKey:pch_channelId];
        self.sell_name = [aDecoder decodeObjectForKey:pch_sellName];
        self.dz_flag = [aDecoder decodeObjectForKey:pch_dzFlag];
        self.threeG = [aDecoder decodeObjectForKey:pch_threeG];
        self.fourG = [aDecoder decodeObjectForKey:pch_fourG];
        self.card = [aDecoder decodeObjectForKey:pch_card];
        self.phone = [aDecoder decodeObjectForKey:pch_phone];
        self.password = [aDecoder decodeObjectForKey:pch_password];
        self.address = [aDecoder decodeObjectForKey:pch_address];
        self.level = [aDecoder decodeIntForKey:pch_level];
    }
    return self;
}
 
@end
