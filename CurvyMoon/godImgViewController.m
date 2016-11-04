//
//  godImgViewController.m
//  CurvyMoon
//
//  Created by qingyun on 16/5/12.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "godImgViewController.h"
#import "albumModel.h"
#import "ImglistView.h"

#import "imgHView.h"
#import "imgFView.h"
@interface godImgViewController ()
@property (nonatomic , strong) NSMutableArray * array;

@property (nonatomic , strong) ImglistView    * imglist;

@property (nonatomic , strong) imgFView       *  foot;

@property (nonatomic , strong) imgHView       *  head;

@property (nonatomic , assign) BOOL              isHidden;
@end

@implementation godImgViewController

- (NSMutableArray *)array{
    if (!_array) {
        self.array = [NSMutableArray array];
    }
    return _array;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.hidesBottomBarWhenPushed = YES;
    
//    [self leftBackImg];
    [self loadData];
    
    [self addsubViews];
    self.isHidden = NO;
    
    // Do any additional setup after loading the view.
}
- (void)addsubViews{
    
    imgHView *head = [[NSBundle mainBundle] loadNibNamed:@"imgHView" owner:nil options:nil][0];
    self.head = head;
    head.frame = CGRectMake(0, 20, self.view.frame.size.width, 44);
    [head.backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
 
    
    imgFView *foot = [[NSBundle mainBundle] loadNibNamed:@"imgFView" owner:nil options:nil][0];
    self.foot = foot;
    foot.imgtitle.text = self.godtitle;
    foot.imgnumber.text = [NSString stringWithFormat:@"1/%ld",(long)self.godnumber];
    foot.frame = CGRectMake(0, self.view.frame.size.height-120, self.view.frame.size.width, 120);
 
    
    ImglistView *contentView = [ImglistView S2ImglistView];
    self.imglist = contentView;
    
    contentView.CurrentIndex = ^(NSInteger currentIndex){
    foot.imgnumber.text = [NSString stringWithFormat:@"%ld/%ld",(long)currentIndex,(long)self.godnumber];
    };
    [self.view addSubview:self.imglist];
    [self.view addSubview:head];
    [self.view addSubview:foot];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(isHiddening)];
    [self.imglist addGestureRecognizer:tap];
    
}

- (void)back{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)isHiddening{
    if (self.isHidden) {
        [UIView animateWithDuration:0.3 animations:^{
            self.head.frame = CGRectMake(0, -64, self.view.frame.size.width, 44);
            self.foot.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 120);
        }];
        self.isHidden = NO;
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            self.head.frame = CGRectMake(0, 20, self.view.frame.size.width, 44);
            self.foot.frame = CGRectMake(0,self.view.frame.size.height-120 , self.view.frame.size.width, 120);
        }];
        self.isHidden = YES;
    }

}

- (void)backClick
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)loadData{
    
    NSString *url_f = [k5Detail_url stringByAppendingString:self.godImg_aid];
    NSString *url_s = [url_f stringByAppendingString:@"&token="];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/html",@"text/json",@"text/plain",@"text/javascript",@"text/xml",@"image/*"]];
    
    // 设置允许同时最大并发数量，过大容易出问题
    manager.operationQueue.maxConcurrentOperationCount = 3;
    
    [manager GET:url_s parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //判断responseoObject  是不是 字典
        
        NSDictionary *content =responseObject[@"content"];
        
        //判断code  boolvalue
        NSArray *img_list = content[@"imglist"];
        
        NSMutableArray *imgs = [NSMutableArray array];
        
        for (NSDictionary *dict in img_list) {
            NSString *thumb = dict[@"thumb"];
//            NSLog(@"%@",thumb);
            [imgs addObject:thumb];
        }
        self.imglist.imglist = imgs;
        
        
//        NSMutableArray *imgp = [NSMutableArray array];
//        
//        for (NSDictionary *dic in img_list) {
//            NSString * path = dic[@"path"];
////            NSLog(@"%@",path);
//            [imgp addObject:path];
//        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
