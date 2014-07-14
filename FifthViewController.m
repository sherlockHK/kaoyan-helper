//
//  FifthViewController.m
//  KaoYan
//
//  Created by sherlock de Mac mini on 14-5-26.
//  Copyright (c) 2014年 CCNU. All rights reserved.
//

#import "FifthViewController.h"
#


@interface FifthViewController ()

@end

@implementation FifthViewController{
    MFMailComposeViewController *picker;
    NSString *strName;
    NSString *strSysVersion;
    NSString *strModel;
    NSString* phoneModel;
    NSString *strAppName;
    NSString *strAppVersion;
}


-(void)viewDidLoad
{

}

#pragma mark - tableview datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"使用帮助";
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"意见反馈";
    }else{
        cell.textLabel.text = @"去Apple Store评价";
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [self performSegueWithIdentifier:@"Help" sender:nil];
    }else if(indexPath.row == 1){
        //[self performSegueWithIdentifier:@"Suggest" sender:nil];
        if ([MFMailComposeViewController canSendMail])
        {
            picker = [[MFMailComposeViewController alloc]init];
            picker.mailComposeDelegate = self;
            
            //设置收件人，可以设置多人
            [picker setToRecipients:[NSArray arrayWithObjects:@"576717731@qq.com",nil]];
            //设置主题
            //设备相关信息的获取
            strName = [[UIDevice currentDevice] name];  //e.g. "My iPhone"
            strSysVersion = [[UIDevice currentDevice] systemVersion];  // e.g. @"4.0"
            strModel = [[UIDevice currentDevice] model];  // e.g. @"iPhone", @"iPod touch"
        
            //app应用相关信息的获取
            NSDictionary *dicInfo = [[NSBundle mainBundle] infoDictionary];
            strAppName = [dicInfo objectForKey:@"CFBundleDisplayName"];  // 当前应用名称
            strAppVersion = [dicInfo objectForKey:@"CFBundleShortVersionString"];
            // 当前应用软件版本  比如：1.0.1
            [picker setSubject: @"客户端意见反馈"];
            [picker setMessageBody:[NSString stringWithFormat:@"意见内容: \n\n\n\n\n设备名称：%@ \n系统版本号：%@\n手机型号：%@\nApp应用名称：%@\nApp应用版本：%@\n",strName,strSysVersion,strModel,strAppName,strAppVersion] isHTML:NO];
            NSLog(@"ok!!");
        }
        
        [self presentViewController:picker animated:YES completion:NULL];
    }else{
        NSString * appstoreUrlString = @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?mt=8&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software&id=895659554";
        
        NSURL * url = [NSURL URLWithString:appstoreUrlString];
        
        if ([[UIApplication sharedApplication] canOpenURL:url])
        {
            [[UIApplication sharedApplication] openURL:url];
            NSLog(@"app store!");
        }else{
            NSLog(@"can't open");
        }
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error
{
    switch (result)
        {
            case MFMailComposeResultCancelled:
                NSLog(@"Mail send canceled...");
                break;
            case MFMailComposeResultSaved:
                 NSLog(@"Mail saved...");
                break;
                case MFMailComposeResultSent:
                NSLog(@"Mail sent...");
                break;
                case MFMailComposeResultFailed:
                NSLog(@"Mail send errored: %@...", [error localizedDescription]);
                break;
                default:
                break;
         }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
