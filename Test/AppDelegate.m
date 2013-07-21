//
//  AppDelegate.m
//  Test
//
//  Created by mac on 13-7-11.
//  Copyright (c) 2013年 xiaoran. All rights reserved.
//

#import "AppDelegate.h"
#import "UIImageAdditions.h"

#import "OpenUDID.h"
#import <CommonCrypto/CommonDigest.h> // Need to import for CC_MD5 access

#import <mach/mach_time.h>

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    
    UIImage *image1 = [UIImage imageNamed:@"background"];
    UIImageView *iv1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 100, 80, 80)];
    
    iv1.image = [UIImage imageWithGradient:image1 startColor:[UIColor whiteColor] endColor:[UIColor yellowColor]];
    
    [self.window addSubview:iv1];
    [iv1 release];

    
    
    UIImage *image = [UIImage imageNamed:@"compose-at"];
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(10, 200, 80, 80)];
    
    iv.image = [self blackFilledImageWithWhiteBackgroundUsing:image];
    
    [self.window addSubview:iv];
    [iv release];
    

    
    ///NSLog(@"openuuid = %@",[OpenUDID value]);
    
    NSString *_openUDID=nil;
    
    if (_openUDID==nil) {
        CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
        CFStringRef cfstring = CFUUIDCreateString(kCFAllocatorDefault, uuid);
        const char *cStr = CFStringGetCStringPtr(cfstring,CFStringGetFastestEncoding(cfstring));
        unsigned char result[16];
        CC_MD5( cStr, strlen(cStr), result );
        CFRelease(uuid);
        CFRelease(cfstring);
        
        _openUDID = [NSString stringWithFormat:
                     @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%08x",
                     result[0], result[1], result[2], result[3],
                     result[4], result[5], result[6], result[7],
                     result[8], result[9], result[10], result[11],
                     result[12], result[13], result[14], result[15],
                     (NSUInteger)(arc4random() % NSUIntegerMax)];
    }
    
    
    // NSRunloop
    
    NSLog(@"runloop = %@",[NSRunLoop currentRunLoop]);
    
    
    [NSThread detachNewThreadSelector:@selector(newThread) toTarget:self withObject:nil];
    
    
    // block
    
    
    void (^aBlock)(void)=0;
    aBlock = ^(void) {
        NSLog(@"Hello, World!");
    };
    
    aBlock();
    
    
    // block with funcion
    
    //dispatch_async(<#dispatch_queue_t queue#>, <#^(void)block#>)
    
    // block 崩溃，
    NSArray *array = [[[NSArray alloc] initWithObjects:@"1",@"2", nil] autorelease];
    NSLog(@"A %@",array);
    __block NSArray *bArray = array;
    dispatch_async(dispatch_get_main_queue(), ^{  NSLog(@"B %@",bArray); });
    NSLog(@"C %@",array);
    
    // block readonly  NSDictionary
//    
//     int blockInt = 100;
//    void (^bBlock)(void) = ^{
//        NSLog(@"sum = %d",blockInt);
//        
//    
//    };
//    bBlock();
    
     
    // block  local 变量会拷贝一份，值固定
    
    __block int x = 0;
    int y = 0;
    void(^print)()=^{
        printf("x=%d",x);
        printf("x=%d",y);
    };
    x++;
    y++;
    dispatch_async(dispatch_get_global_queue(0, 0ul), print);/// 这里的local变量都分布在栈上，
    
   
    
    
    
    
    // block copy
    
    /*
     block 定义时分配在stack上，当其作用域结束，就会被自动释放，我们可以对一个Block执行Block_copy()操作，
     block就会被拷贝到heap中，且其所有的引用到的自由变量也将会被拷贝，当然还需要通过Block_release()释放heap
     内存。
     在Block内部如果引用到对象或者对象的成员变量，那么当Block被拷贝Block_copy()之后，这个对象的引用计数会增加。
     在什么情况下，我们需要用到Block_copy()?
     
     
     
     
     BOOL done = NO;
     do{
     [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];    //阻塞当前的线程
     
     } while (!done) ;
     
     
     */
    
    
    // NSOperation
    
    //NSInvocationOperation
    
    
    // gcd
    
    //dispatch_get_main_queue()
    //dispatch_queue_create(<#const char *label#>, <#dispatch_queue_attr_t attr#>)
    
    //dispatch_once_f(<#dispatch_once_t *predicate#>, <#void *context#>, <#dispatch_function_t function#>)
//    
//    dispatch_async(dispatch_get_global_queue(-2, 0),^{
//    
//        // 耗时操作
//       // [self longTimeOper];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            //更新UI
//            [self updateUI];
//        
//        });
//    
//    
//    });
//    
//    
    
    // gcd 同步
    
//    dispatch_group_t group = dispatch_group_create();
//    
//    NSArray * arr = [NSArray arrayWithObjects:@"a",@"b",@"c",@"d",@"e",@"f", nil];
//    for (NSString *item in arr) {
//        
//        dispatch_async(dispatch_get_global_queue(0, 0ul), ^{
//            
//            //[self print:item];
//        
//            dispatch_group_async(group, dispatch_get_global_queue(0, 0ul), ^{
//                [self print:item];
//                
//            });
//        });
//        
//    }
//    
//    
//    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
//    dispatch_release(group);
//    dispatch_group_notify(group, dispatch_get_global_queue(0, 0ul), ^{
//        [self printCount];
//    });
    
    
    //NSLog(@"count == %d",counter);// 这里面有需要上面的异步操作完成后，再来统计数据（也就是同步问题）
    
    
    
#ifdef DEBUG
    NSLog(@"");
#endif
    
    // xcode 4.4 @
    
//    NSNumber *num1 = @'H';
//    NSNumber *num2 = @YES;
//    NSNumber *num3 = @1.2;
//    NSNumber *num4 = @10;
//    NSLog(@"n1=%@,n2=%@,n3=%@,n4=%@,sum=%@",num1,num2,num3,num4,@(10*10));
//    
//    
//    NSArray *arr = @[@"str1",@"2",@"3"];
//    NSLog(@"%@,%@,%@",arr[0],arr[2],arr[1]);
//    
//    
//    NSDictionary *dict = @{@"key1":@"value1",@"key2":@1989};
//    NSLog(@"value(key2)=%@",dict[@"key2"]);
    
    
    
    return YES;
}

static int counter = 0;

- (void)print:(NSString *)c
{
    NSLog(@"print [%@]",c);
    counter ++ ;
}

- (void)printCount{
    NSLog(@"count == %d",counter);

}


-(void)longTimeOper{

    NSLog(@"start working...");
    
    unsigned long start = clock();
    uint64_t sta = mach_absolute_time();
    int max = 1000000000;
    long long int sum=0;
    for (int i=0; i<max; i++) {
        sum += i;
    }
    
    NSLog(@"duration1 = %ld;duration2 = %lld",clock()-start,mach_absolute_time()-sta);
}


-(void)updateUI{
    
    NSLog(@"2");
}



// new thread

-(void)newThread
{
    NSLog(@"runloop2 = %@",[NSRunLoop currentRunLoop]);

}



// Convert the image's fill color to black and background to white
-(UIImage*) blackFilledImageWithWhiteBackgroundUsing:(UIImage*)startImage
{
    // Create the proper sized rect
    CGRect imageRect = CGRectMake(0, 0, CGImageGetWidth(startImage.CGImage), CGImageGetHeight(startImage.CGImage));
    
    // Create a new bitmap context
    CGContextRef context = CGBitmapContextCreate(NULL, imageRect.size.width, imageRect.size.height, 8, 0, CGImageGetColorSpace(startImage.CGImage), kCGImageAlphaPremultipliedLast);
    
    CGContextSetRGBFillColor(context, 1, 1, 1, 1);
    CGContextFillRect(context, imageRect);
    
    // Use the passed in image as a clipping mask
    CGContextClipToMask(context, imageRect, startImage.CGImage);
    // Set the fill color to black: R:0 G:0 B:0 alpha:1
    CGContextSetRGBFillColor(context, 0, 0, 0, 1);
    // Fill with black
    CGContextFillRect(context, imageRect);
    
    // Generate a new image
    CGImageRef newCGImage = CGBitmapContextCreateImage(context);
    UIImage* newImage = [UIImage imageWithCGImage:newCGImage scale:startImage.scale orientation:startImage.imageOrientation];
    
    // Cleanup
    CGContextRelease(context);
    CGImageRelease(newCGImage);
    
    return newImage;
}





















- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
