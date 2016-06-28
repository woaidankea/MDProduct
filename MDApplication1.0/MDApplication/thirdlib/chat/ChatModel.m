//
//  ChatModel.m
//  UUChatTableView
//
//  Created by shake on 15/1/6.
//  Copyright (c) 2015年 uyiuyao. All rights reserved.
//

#import "ChatModel.h"

#import "UUMessage.h"
#import "UUMessageFrame.h"
#import "TDTicketinfoRequest.h"
#import "AMTools.h"
@implementation ChatModel

- (void)populateRandomDataSource {
    self.dataSource = [NSMutableArray array];
//    [self.dataSource addObjectsFromArray:[self additems:5]];
    
//    TDTicketinfoRequest *request = [[TDTicketinfoRequest alloc]initWithD:0 success:^(AMBaseRequest *request) {
//        NSArray *items = [UUMessage mj_objectArrayWithKeyValuesArray:[request.responseObject objectForKey:@"list"]];
//        
//        
//        NSMutableArray *result = [NSMutableArray array];
//        
//        for (UUMessage *message in items) {
//            
////            NSDictionary *dataDic = [self getDic];
//            UUMessageFrame *messageFrame = [[UUMessageFrame alloc]init];
//       
////            [message setWithDict:dataDic];
//            [message minuteOffSetStart:nil end:message.strTime];
//            messageFrame.showTime = message.showDateLabel;
//            [messageFrame setMessage:message];
//            
//            if (message.showDateLabel) {
////                previousTime = dataDic[@"strTime"];
//            }
//            [result addObject:messageFrame];
//        }
//   
//
//            [self.dataSource addObjectsFromArray:result];
//        
//        
//    } failure:^(AMBaseRequest *request) {
//        
//    }];
//    [request start];
    
    
    
    
    
}

- (void)addRandomItemsToDataSource:(NSInteger)number{
    
    for (int i=0; i<number; i++) {
        [self.dataSource insertObject:[[self additems:1] firstObject] atIndex:0];
    }
}

// 添加自己的item
- (void)addSpecifiedItem:(NSDictionary *)dic
{
    UUMessageFrame *messageFrame = [[UUMessageFrame alloc]init];
    UUMessage *message = [[UUMessage alloc] init];
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    
//    NSString *URLStr = @"http://img0.bdstatic.com/img/image/shouye/xinshouye/mingxing16.jpg";
    [dataDic setObject:@(UUMessageFromMe) forKey:@"from"];
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%f",a];//转为字符型
    NSString *tenTime = [timeString substringWithRange:NSMakeRange(0,10)];
    [dataDic setObject:tenTime forKey:@"strTime"];
    [dataDic setObject:@"Hello,Sister" forKey:@"strName"];
    [dataDic setObject:[dataDic objectForKey:@"strIcon"] forKey:@"strIcon"];
    
    [message setWithDict:dataDic];
    [message minuteOffSetStart:nil end:dataDic[@"strTime"]];
    messageFrame.showTime = message.showDateLabel;
    [messageFrame setMessage:message];
    
//    if (message.showDateLabel) {
//        previousTime = dataDic[@"strTime"];
//    }
    [self.dataSource addObject:messageFrame];
}

// 添加聊天item（一个cell内容）
static NSString *previousTime = nil;
- (NSArray *)additems:(NSInteger)number
{
    NSMutableArray *result = [NSMutableArray array];
    
    for (int i=0; i<number; i++) {
        
        NSDictionary *dataDic = [self getDic];
        UUMessageFrame *messageFrame = [[UUMessageFrame alloc]init];
        UUMessage *message = [[UUMessage alloc] init];
        [message setWithDict:dataDic];
        [message minuteOffSetStart:previousTime end:dataDic[@"strTime"]];
        messageFrame.showTime = message.showDateLabel;
        [messageFrame setMessage:message];
        
        if (message.showDateLabel) {
            previousTime = dataDic[@"strTime"];
        }
        [result addObject:messageFrame];
    }
    return result;
}

// 如下:群聊（groupChat）
static int dateNum = 10;
- (NSDictionary *)getDic
{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    int randomNum = arc4random()%5;
    if (randomNum == UUMessageTypePicture) {
        [dictionary setObject:[UIImage imageNamed:[NSString stringWithFormat:@"%zd.jpeg",arc4random()%2]] forKey:@"picture"];
    }else{
        // 文字出现概率4倍于图片（暂不出现Voice类型）
        randomNum = UUMessageTypeText;
        [dictionary setObject:[self getRandomString] forKey:@"strContent"];
    }
    NSDate *date = [[NSDate date]dateByAddingTimeInterval:arc4random()%1000*(dateNum++) ];
    [dictionary setObject:@(UUMessageFromOther) forKey:@"from"];
    [dictionary setObject:@(randomNum) forKey:@"type"];
    [dictionary setObject:[date description] forKey:@"strTime"];
    // 这里判断是否是私人会话、群会话
    int index = _isGroupChat ? arc4random()%6 : 0;
    [dictionary setObject:[self getName:index] forKey:@"strName"];
    [dictionary setObject:[self getImageStr:index] forKey:@"strIcon"];
    
    return dictionary;
}

- (NSString *)getRandomString {
    
    NSString *lorumIpsum = @"寒蝉凄切，对长亭晚，骤雨初歇。 都门帐饮无绪，留恋处，兰舟催发。 执手相看泪眼，竟无语凝噎。 念去去，千里烟波，暮霭沉沉楚天阔。 多情自古伤离别，更那堪冷落清秋节！ 今宵酒醒何处？ 杨柳岸，晓风残月。 此去经年，应是良辰好景虚设。 便纵有千种风情，更与何人说.";
    
    NSArray *lorumIpsumArray = [lorumIpsum componentsSeparatedByString:@" "];
    
    int r = arc4random() % [lorumIpsumArray count];
    r = MAX(6, r); // no less than 6 words
    NSArray *lorumIpsumRandom = [lorumIpsumArray objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, r)]];
    
    return [NSString stringWithFormat:@"%@!!", [lorumIpsumRandom componentsJoinedByString:@" "]];
}

- (NSString *)getImageStr:(NSInteger)index{
    NSArray *array = @[@"http://www.120ask.com/static/upload/clinic/article/org/201311/201311061651418413.jpg",
                       @"http://p1.qqyou.com/touxiang/uploadpic/2011-3/20113212244659712.jpg",
                       @"http://www.qqzhi.com/uploadpic/2014-09-14/004638238.jpg",
                       @"http://e.hiphotos.baidu.com/image/pic/item/5ab5c9ea15ce36d3b104443639f33a87e950b1b0.jpg",
                       @"http://ts1.mm.bing.net/th?&id=JN.C21iqVw9uSuD2ZyxElpacA&w=300&h=300&c=0&pid=1.9&rs=0&p=0",
                       @"http://ts1.mm.bing.net/th?&id=JN.7g7SEYKd2MTNono6zVirpA&w=300&h=300&c=0&pid=1.9&rs=0&p=0"];
    return array[index];
}

- (NSString *)getName:(NSInteger)index{
    NSArray *array = @[@"Hi,Daniel",@"Hi,Juey",@"Hey,Jobs",@"Hey,Bob",@"Hah,Dane",@"Wow,Boss"];
    return array[index];
}
@end
