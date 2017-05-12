//
//  ViewController.m
//  MyAppFrame
//
//  Created by 陈自奎 on 17/4/6.
//  Copyright © 2017年 Chen, ZiKui. All rights reserved.
//

#import "ViewController.h"
#import <CommonCrypto/CommonCrypto.h>
#include <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>
#include <CommonCrypto/CommonKeyDerivation.h>
#include <CommonCrypto/CommonSymmetricKeywrap.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor whiteColor                                                                                                                                              ]];
    
    
    NSMutableDictionary *parma_dic=@{@"app_key":@"23811141",@"format":@"json",@"method":@"taobao.tbk.item.convert",@"partner_id":@"apidoc",@"sign_method":@"md5",@"timestamp":@"2017-05-10 09:43:30",@"v":@"2.0",@"adzone_id":@"123",@"fields":@"num_iid,Cclick_url",@"num_iids":@"11223344",@"platform":@"2",@"unid":@"demo"}.mutableCopy;
    NSString *strdd=[self handelDictionary:parma_dic];
    
    [self md5HexDigest:strdd];
    
//    [self compareDatewithDate:@"2017-05-15 11:49:20"];
    [self compareDatewithDate:@"2017-05-10 09:18:20"];

    
}

-(NSString *)handelDictionary:(NSDictionary *)dic
{
    NSMutableString *parma_str=[[NSMutableString alloc]init];
    
    NSMutableArray * sortArray = [[NSMutableArray alloc]init];
    for (id _obj in [[dic allKeys] sortedArrayUsingSelector:@selector(compare:)]) {
        [sortArray addObject:_obj];
    }
    
    [parma_str appendString:@"3ebdf943d84e085151c1737072ba222b"];
    for (NSString *str_key in sortArray) {
        NSString *str_value=dic[str_key];
        
        [parma_str appendString:str_key];
        [parma_str appendString:str_value];
    }
    [parma_str appendString:@"3ebdf943d84e085151c1737072ba222b"];
    
    return parma_str;
}

- (NSString *)md5HexDigest:(NSString *)str
{
     const char *cstr = [str cStringUsingEncoding:NSUTF8StringEncoding];

    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cstr, (unsigned int)strlen(cstr), result);

     NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];

     for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
         [output appendFormat:@"%02x", result[i]];
    NSLog(@"%@",output);
     return output;
}

//比较两个日期的大小  日期格式为2016-08-14 08：46：20
- (NSInteger)compareDatewithDate:(NSString*)dateStr
{
    NSInteger aa;
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dta = [[NSDate alloc] init];
    dta = [dateformater dateFromString:dateStr];
    
    NSDate *dtb = [NSDate date];
    


    NSComparisonResult result = [dta compare:dtb];
    if (result==NSOrderedSame)
    {
        //相等
        aa=0;
    }else if (result==NSOrderedAscending)
    {
        //bDate比aDate大
        aa=1;
    }else if (result==NSOrderedDescending)
    {
        //bDate比aDate小
        aa=-1;
        
    }
    
    return aa;
}

//比较两个日期的大小  日期格式为2016-08-14 08：46：20
+ (NSInteger)compareDate:(NSString*)aDate withDate:(NSString*)bDate
{
    NSInteger aa;
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dta = [[NSDate alloc] init];
    NSDate *dtb = [[NSDate alloc] init];
    
    dta = [dateformater dateFromString:aDate];
    dtb = [dateformater dateFromString:bDate];
    NSComparisonResult result = [dta compare:dtb];
    if (result==NSOrderedSame)
    {
        //相等
        aa=0;
    }else if (result==NSOrderedAscending)
    {
        //bDate比aDate大
        aa=1;
    }else if (result==NSOrderedDescending)
    {
        //bDate比aDate小
        aa=-1;
        
    }
    
    return aa;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
