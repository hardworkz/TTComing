//
//  NSDictionary+Convert.m
//  BaseProject
//
//  Created by 泡果 on 2018/5/28.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "NSDictionary+Convert.h"

@implementation NSDictionary (Convert)

#pragma mark - NSDictionary -> JSON

+ (NSString *)convertToJson:(NSDictionary *)dict
{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}

- (NSString *)convertToJson
{
    return [self.class  convertToJson:self];
}

#pragma mark - NSDictionary -> NSData

+ (NSData *)returnDataWithDictionary:(NSDictionary *)dict
{
    NSMutableData * data = [[NSMutableData alloc] init];
    NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:dict forKey:NSStringFromSelector(_cmd)];
    [archiver finishEncoding];
    //使用ARC和不使用ARC
#if __has_feature(objc_arc)
#else
    [data autorelease];
    [archiver autorelease];
#endif
    return data;
}

- (NSData *)dictionaryData
{
    return [self.class returnDataWithDictionary:self];
}
@end
