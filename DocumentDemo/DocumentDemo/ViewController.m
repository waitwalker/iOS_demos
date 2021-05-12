//
//  ViewController.m
//  DocumentDemo
//
//  Created by waitwalker on 2021/2/24.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic) UIDocumentPickerViewController *documentPicker;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIViewController *rootVC = [self hl_getRootViewController];
    UIWindow* window = nil;
    
     
            if (@available(iOS 13.0, *))
            {
                for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes)
                {
                    if (windowScene.activationState == UISceneActivationStateForegroundActive)
                    {
                        window = windowScene.windows.firstObject;
     
                        break;
                    }
                }
            }else{
                window = [UIApplication sharedApplication].keyWindow;
            }
    window = [UIApplication sharedApplication].windows.firstObject;
    
    // 项目支持可以选择的文件类型
    NSArray *types = @[
                @"com.microsoft.powerpoint.ppt",
                @"com.microsoft.word.doc",
                @"org.openxmlformats.wordprocessingml.document",
                @"org.openxmlformats.presentationml.presentation",
                @"public.mpeg-4",
                @"com.adobe.pdf",
                @"public.mp3"
            ];
    //初始化
    self.documentPicker = [[UIDocumentPickerViewController alloc]  initWithDocumentTypes:types inMode:UIDocumentPickerModeOpen];
    self.documentPicker.delegate = self;
    //全屏弹出
    //self.documentPicker.modalPresentationStyle = UIModalPresentationFullScreen;
    //设置模态弹出方式
    //self.documentPicker.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:self.documentPicker animated:YES completion:nil];
}

- (UIViewController *)hl_getRootViewController{
    UIWindow* window = nil;
       if (@available(iOS 13.0, *)) {
           for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes)
           {
              if (windowScene.activationState == UISceneActivationStateForegroundActive)
              {
             //实际上这一步是有问题的，应该增加判断 ishidden
                   window = windowScene.windows.firstObject;
        
                   break;
              }
           }
       }else{
           #pragma clang diagnostic push
           #pragma clang diagnostic ignored "-Wdeprecated-declarations"
               // 这部分使用到的过期api
            window = [UIApplication sharedApplication].keyWindow;
           #pragma clang diagnostic pop
       }
    if([window.rootViewController isKindOfClass:NSNull.class]){
        return nil;
    }
    return window.rootViewController;
}

#pragma mark - UIDocumentPickerDelegate
- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray<NSURL *> *)urls {
    //获取授权
    BOOL fileUrlAuthozied = [urls.firstObject startAccessingSecurityScopedResource];
    if (fileUrlAuthozied) {
        NSFileCoordinator *fileCoordinator = [[NSFileCoordinator alloc] init];
        NSError *error;
        [fileCoordinator coordinateReadingItemAtURL:urls.firstObject options:0 error:&error byAccessor:^(NSURL *newURL) {
             
            //读取文件
            NSString *fileName = [newURL lastPathComponent];
            NSError *error = nil;
            NSData *fileData = [NSData dataWithContentsOfURL:newURL options:NSDataReadingMappedIfSafe error:&error];
            // 上传规则
            /*
                走项目数据上传接口就可以了
            */
            [[UIApplication sharedApplication].keyWindow.rootViewController dismissViewControllerAnimated:YES completion:NULL];
        }];
        [urls.firstObject stopAccessingSecurityScopedResource];
    } else {
        //授权失败
        //[LCSCustomToast showWithMessage:@"授权失败，请您去设置页面打开授权" image:@"login_fail_image"];
        return;
    }
}
 

@end
