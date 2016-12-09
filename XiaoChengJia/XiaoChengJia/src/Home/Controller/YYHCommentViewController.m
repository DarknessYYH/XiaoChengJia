//
//  YYHCommentViewController.m
//  XiaoChengJia
//
//  Created by yyh2016 on 16/9/18.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "YYHCommentViewController.h"
#import "YYHSendComment.h"
#import "HttpTool.h"
#import "MBProgressHUD+MJ.h"
#import "WBaccountTool.h"

@implementation YYHCommentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNavigationBar];
    [self setTextView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.commentTextview becomeFirstResponder];
}

- (void)setupNavigationBar
{
    self.title = @"发送评论";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
}

- (void)cancel
{
    [self.commentTextview resignFirstResponder];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"是否放弃已编辑内容" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"放弃编辑" otherButtonTitles:nil, nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    
    [actionSheet showInView:self.view];
   
}

- (void)send
{

    [self.commentTextview resignFirstResponder];
    NSString * commentPoster = [WBaccountTool account].name;
    
    if (commentPoster)
    {
        NSDictionary *commentDic = @{@"commentPoster":commentPoster,
                                     @"comment":_commentTextview.text,
                                     @"commentClassName":_commentClassName};
        
        NSString *path = [NSString stringWithFormat:@"classes/%@",_commentClassName];

        [HttpTool postWithPath:path params:commentDic success:^(id result)
        {
            [MBProgressHUD showSuccess:@"发送成功"];
        }
        failure:^(NSError *error)
        {
            [MBProgressHUD showError:@"发送失败"];
        }];
    }
    else
    {
        [MBProgressHUD showError:@"发送失败"];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setTextView
{
    YYHSendComment *view = [[YYHSendComment alloc] init];
    view.frame = self.view.bounds;
    view.font = [UIFont systemFontOfSize:16.0];
    self.commentTextview = view;
    [self.view addSubview:view];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textChange)
                                                 name:UITextViewTextDidChangeNotification
                                               object:self.commentTextview];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.navigationItem.rightBarButtonItem.tintColor = kColor(0xeb, 0xeb, 0xeb);
}


- (void)textChange
{
    if(self.commentTextview.text.length != 0)
    {
        self.navigationItem.rightBarButtonItem.enabled = YES;
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    }
    else
    {
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
    if(buttonIndex == [actionSheet destructiveButtonIndex])
    {
         [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == [alertView cancelButtonIndex])
    {
        [self.commentTextview resignFirstResponder];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
