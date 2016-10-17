//
//  ViewController.m
//  折线图绘制
//
//  Created by AS150701001 on 16/6/27.
//  Copyright © 2016年 lele. All rights reserved.
//

#import "ViewController.h"
#import "YLIneView.h"
#import <SocketRocket/SRWebSocket.h>
@interface ViewController ()<SRWebSocketDelegate>

@property(nonatomic,weak)YLIneView* LineView;

@property (nonatomic,strong)NSMutableArray *yValueArr;
@property (nonatomic,strong)NSMutableArray *xValueArr;
@property (nonatomic,strong)NSMutableArray *yKeduArr;

@end

// 声明一个全局的
SRWebSocket *webSocket;
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    
    [self setSocket];
    
}

// 铺界面
- (void)setUI {
    
    YLIneView* LineView=[[YLIneView alloc] initWithFrame:CGRectMake(10, 100,[UIScreen mainScreen].bounds.size.width - 20, 250)];

    self.yValueArr = [NSMutableArray array];
    self.xValueArr = [NSMutableArray array];
    self.yKeduArr = [NSMutableArray array];

    
    LineView.yValueColor=[UIColor grayColor];
    LineView.xValueColor=[UIColor grayColor];
    
    [self.view addSubview:LineView];
    self.LineView=LineView;
}

// 设置socket 建立连接设置代理
- (void)setSocket {
    
    webSocket.delegate = nil;
    
    [webSocket close];
    
    webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://114.55.57.51:8282"]]];
    
    webSocket.delegate = self;
    
    NSLog(@"Opening Connection...");
    
    [webSocket open];
    
}



#pragma mark - SRWebSocketDelegate 代理方法实现
// 连接上
- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    
    NSLog(@"Websocket Connected");
    
    // 发送数据到服务器
    //    NSError *error;
    //
    //    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:@{@"id":@"chat",@"clientid":@"hxz",@"to":@""} options:NSJSONWritingPrettyPrinted error:&error];
    //
    //    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //
    //    [webSocket send:jsonString];
    
}


// 连接失败
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    
    NSLog(@":( Websocket Failed With Error %@", error);
    
    webSocket = nil;
    // 断开连接后每过1s重新建立一次连接
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setSocket];
    });
    
    
}


// 收到消息
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    
//    NSLog(@"Received \"%@\"", message);
    
    

    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//    NSLog(@"%@",dic);
    
    
    NSString *str = [dic valueForKey:@"value_7"];
    NSLog(@"%@",str);
    
    if (!str) {
        return;
    }
    
    
    
    [_yValueArr addObject:str];
    if (_yValueArr.count >80) {
        [_yValueArr removeObjectAtIndex:0];
    }
    if (_xValueArr.count < 80) {
        
        NSObject *obj = [NSNumber numberWithInteger:(20 + _yValueArr.count * 2)];
        [self.xValueArr addObject:obj];
        
    }
    
    self.LineView.xValues = _xValueArr;
    self.LineView.yValues = _yValueArr;
    
    // 当y值少于2个或者最大值最小值溢出时重新获取Y轴刻度值
    if (self.LineView.yValues.count < 2 || [[self.yValueArr lastObject] floatValue] > [_yKeduArr[5] floatValue] || [[self.yValueArr lastObject] floatValue] < [_yKeduArr[1] floatValue]) {
        
        [self.yKeduArr removeAllObjects];
        // (最大值-最小值)/5
        CGFloat interval = ([self getMaxValue] - [self getMinValue]) / 3;
        // Y轴的刻度值
        for (int i = -1; i < 5; i++) {
            CGFloat kedu = [self getMinValue] + i * interval;
            [self.yKeduArr addObject:[NSNumber numberWithFloat:kedu]];
        }
        self.LineView.yKeDuValus = _yKeduArr;
    }
    
    // 调用drawRect方法画图
    [self.LineView setNeedsDisplay];
    
}

// 获取最大值
- (CGFloat)getMaxValue {
    CGFloat maxValue = 0;
    for (NSString *str in self.yValueArr) {
        if ([str floatValue] > maxValue) {
            maxValue = [str floatValue];
        }
    }
    return maxValue;
}

// 获取最小值
- (CGFloat)getMinValue {
    CGFloat minValue = CGFLOAT_MAX;
    for (NSString *str in self.yValueArr) {
        if ([str floatValue] < minValue) {
            minValue = [str floatValue];
        }
    }
    return minValue;
}

// 连接关闭
- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    
    NSLog(@"WebSocket closed");
    
    webSocket = nil;
    
}



@end
