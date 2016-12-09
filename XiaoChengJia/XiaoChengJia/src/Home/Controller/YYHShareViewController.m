//
//  YYHShareViewController.m
//  XiaoChengJia
//
//  Created by yyh2016 on 16/9/30.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "YYHShareViewController.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"
#import "WBaccountTool.h"

@interface YYHShareViewController () <UIActionSheetDelegate>

@end

@implementation YYHShareViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTableBar];
    [self setupShareTextView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self.shareTextView becomeFirstResponder];
}

- (void)setupTableBar
{
    self.title = @"分享至微博";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelToSend)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(confirmToSend)];
}

- (void)cancelToSend
{
    [self.shareTextView resignFirstResponder];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"是否放弃已编辑内容" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"放弃编辑" otherButtonTitles:nil, nil];
    [actionSheet showInView:self.view];
}

- (void)confirmToSend
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [WBaccountTool account].access_token;
    params[@"status"] = self.shareTextView.text;
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    //上传图片需要使用另外一个POST方法
    if ([WBaccountTool account].access_token)
    {
        [manager POST:SEND_WEIBO_WITH_IMAGE_URL parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            NSData * imageData = UIImagePNGRepresentation(self.imageToUpLoad.image);
            [formData appendPartWithFileData:imageData name:@"pic" fileName:@"ss" mimeType:@"image/png"];
        }
        success:^(NSURLSessionDataTask *task, id responseObject)
        {
            [MBProgressHUD showSuccess:@"发送成功"];
        }
        failure:^(NSURLSessionDataTask *task, NSError *error)
        {
            [MBProgressHUD showError:@"发送失败"];
            YLog(@"error:%@",error);
        }];
    }
    else
    {
        [MBProgressHUD showError:@"发送失败"];
    }

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupShareTextView
{
    UITextView * textView = [[UITextView alloc] init];
    textView.frame = self.view.frame;
    textView.font = [UIFont systemFontOfSize:16.0];
    textView.textColor = [UIColor lightGrayColor];
    textView.text = @"我正在使用小城家: ";
    self.shareTextView = textView;
    [self.view addSubview:textView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:self.shareTextView];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.navigationItem.rightBarButtonItem.tintColor = kColor(0xeb, 0xeb, 0xeb);
}

/*
 *如果没有任何输入，就会失能发送按钮
 */
- (void)textChange
{
    if(self.shareTextView.text.length != 0)
    {
        self.shareTextView.textColor = [UIColor blackColor];
        self.navigationItem.rightBarButtonItem.enabled = YES;
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    }
    else
    {
        self.shareTextView.textColor = [UIColor lightGrayColor];
        self.shareTextView.text = nil;
        self.navigationItem.rightBarButtonItem.enabled = NO;
        self.navigationItem.rightBarButtonItem.tintColor = kColor(0xeb, 0xeb, 0xeb);
    }
}

/*
 *移除
 */
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == [actionSheet destructiveButtonIndex])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}





@end
