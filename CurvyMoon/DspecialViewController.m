//
//  DspecialViewController.m
//  CurvyMoon
//
//  Created by qingyun on 16/5/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "DspecialViewController.h"
#import "specialViewController.h"
#import "substitute.h"
#import "DspecialTableViewCell.h"

#define k_special @"http://t.gexiaojie.com/api.php?output=json&a=topiclist&c=column&_app_key=f722d367b8a96655c4f3365739d38d85&size=20&pg=%ld&_app_secret=30248115015ec6c79d3bed2915f9e4cc"

typedef enum : NSUInteger{
    kLoadHome,
    kLoadNew,
    kLoadMore,
    
} LoadType;
@interface DspecialViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger page;
    BOOL      refreshing;
}
@property (nonatomic , strong) UITableView * tableView;

@property (nonatomic , copy)   NSMutableArray * array;

@end

@implementation DspecialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView =[[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self loadData:k_special WithLoadType:kLoadNew];
    refreshing = NO;

    // Do any additional setup after loading the view.
}


- (void)loadData:(NSString *)tag_id WithLoadType:(LoadType)type{
    if (type == kLoadHome || type == kLoadNew) {
        page = 1;
        NSString * urlString = [NSString stringWithFormat:k_special,page];
        [self loadData:urlString AndType:kLoadNew];
    }else{
        NSString *urlString = [NSString stringWithFormat:k_special,page];
        [self loadData:urlString AndType:kLoadMore];
    }
    
    
}
- (void)loadData:(NSString *)url AndType:(LoadType)type{
    if (refreshing) {
        return;
    }
    refreshing = YES;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/html",@"text/json",@"text/plain",@"text/javascript",@"text/xml",@"image/*"]];
    
    // 设置允许同时最大并发数量，过大容易出问题
    manager.operationQueue.maxConcurrentOperationCount = 3;
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *artlist =responseObject[@"content"][@"artlist"];
        //                NSLog(@"%@",artlist);
        NSMutableArray *resultArr = [NSMutableArray arrayWithArray:[substitute RCModelWithArray:artlist]]; //作为新的数据源
        
        if (type == kLoadNew) {
            if (self.array.count != 0) {
                if ([resultArr[0] tid] != [self.array[0] tid]) {
                    [resultArr addObjectsFromArray:self.array];
                }
            }
        }else if (type == kLoadMore){
            [resultArr insertObjects:self.array atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.array.count)]];
            
        }
        self.array = resultArr;
        
        [self.tableView reloadData];
        
        refreshing = NO;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //        NSLog(@"%@",error);
        refreshing = NO;
    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height;
    if (KDevice_Is_Retina || kDevice_Is_iPhone5) {
        height = 125;
    }else  if (kDevice_Is_iPhone6) {
        height = 150;
    }else if (kDevice_Is_iPhone6Plus) {
        height = 175;
    }
    return height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = nil;
    DspecialTableViewCell *imgcell = [tableView dequeueReusableCellWithIdentifier:@"Dspecial"];
    if (!imgcell) {
        imgcell = [[NSBundle mainBundle] loadNibNamed:@"DspecialTableViewCell" owner:self.tableView options:nil][0];
    }
    imgcell.sub = self.array[indexPath.row];
    cell = imgcell;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    substitute *model = self.array[indexPath.row];
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    specialViewController * special = [story instantiateViewControllerWithIdentifier:@"special"];
    special.type2_1url = model.tid;
    special.headurl = model.cover;
    [self.navigationController pushViewController:special animated:YES];
    
    
}


//将要展示某个cell
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    //    判断展示的cell位于倒数第五个或者更靠后的
    if (self.array.count - indexPath.row <= 5) {
        //满足加载更多条件
        page++;
        [self loadData:k_special WithLoadType:kLoadMore];
    }
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
