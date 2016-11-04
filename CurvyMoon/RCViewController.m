//
//  RCViewController.m
//  CurvyMoon
//
//  Created by qingyun on 16/5/10.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "RCViewController.h"
#import "RCModel.h"

#import "type1TableViewCell.h"
#import "type2TableViewCell.h"
#import "type4TableViewCell.h"
#import "type5TableViewCell.h"

#import "DetailViewController.h"
#import "godImgViewController.h"
#import "specialViewController.h"


typedef enum : NSUInteger{
    kLoadHome,
    kLoadNew,
    kLoadMore,

} LoadType;

@interface RCViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger page;
    BOOL      refreshing;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic , strong) NSMutableArray *array;

@property (nonatomic , strong) MBProgressHUD *progress;

@property (nonatomic , strong) UIRefreshControl *refreshControl;
@end

@implementation RCViewController


/*-------------------------------风火轮-----------------------------*/
- (void)waitTimer{
    self.progress = [[MBProgressHUD alloc] initWithView:self.view];
    self.progress.frame = self.view.frame;
    self.progress.minSize = CGSizeMake(100, 100);
    self.progress.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:self.progress];
    [self.progress show:YES];
    
    //1秒后关闭
    [self performSelector:@selector(doRemoveProgress) withObject:self.tableView afterDelay:1];
    
    
}

- (void)doRemoveProgress{
    
    [self.progress hide:YES];
}


///*-----------------------------------上拉刷新------------------------------*/
//- (void)loadrequestData{
//    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadOnceData方法）
//    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOnceData)];
//}
//// 上拉加载更多数据
//- (void)loadOnceData
//{
//    // 1.添加数据
//    [self getDataWithPage];
//    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
//    [self performSelector:@selector(doShangReloadData) withObject:nil afterDelay:1];
//}
//-(void)getDataWithPage
//{
//    page++;
//    NSString *Moreurl = [NSString stringWithFormat:kMore,(long)page];
//   
//    [self loadData:Moreurl];
//    
//}
//
//-(void)doShangReloadData
//{
//    [self.tableView reloadData];
//    [self.tableView.footer endRefreshing];
//}

- (void)loadData:(UIRefreshControl *)refresh{
    [self loadDataWithLoadType:kLoadNew];
}

- (void)loadDataWithLoadType:(LoadType)type{
    if (type == kLoadHome || type == kLoadNew) {
        page = 1;
        NSString * urlString = [NSString stringWithFormat:kMore,(long)page];
        [self loadData:urlString andType:kLoadNew];
    }else{
        NSString *urlString = [NSString stringWithFormat:kMore,(long)page];
        [self loadData:urlString andType:kLoadMore];
    }


}

- (void)setRefreshControlTitle:(NSString *)title{
    NSAttributedString *attTitle = [[NSAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    self.refreshControl.attributedTitle = attTitle;
    

}
//懒加载
- (NSMutableArray *)array{
    if (!_array) {
        _array = [NSMutableArray array];
        return _array;
    }
    return _array;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.navigationController.navigationBar.backgroundColor = [UIColor redColor];
//    [self requestApp];
    [self loadDataWithLoadType:kLoadNew];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(loadData:) forControlEvents:UIControlEventValueChanged];
    [self setRefreshControlTitle:@"下拉刷新"];
    refreshing = NO;
    //tableview的高度自动计算
//    self.tableView.estimatedRowHeight = 125;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
//    [self loadData:kRCurl];
    [self waitTimer];
    // Do any additional setup after loading the view.
}



#pragma mark - LoadData
- (void)loadData:(NSString *)url andType:(LoadType)type{
    
    if (refreshing) {
        return;
    }
    refreshing = YES;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/html",@"text/json",@"text/plain",@"text/javascript",@"text/xml",@"image/*"]];
    
    // 设置允许同时最大并发数量，过大容易出问题
    manager.operationQueue.maxConcurrentOperationCount = 3;
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSArray *artlist =responseObject[@"content"][@"artlist"];
//        NSLog(@"%@",artlist);
        NSMutableArray *resultArr = [NSMutableArray arrayWithArray:[RCModel RCModelWithArray:artlist]]; //作为新的数据源
        
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
        if (type == kLoadNew) {
            //停止刷新控件
            [self.refreshControl endRefreshing];
            [self setRefreshControlTitle:@"下拉刷新"];
        }
        refreshing = NO;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",error);
        refreshing = NO;
    }];

        
}

#pragma mark - UITableViewDataSoure Delegate


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height;
    RCModel *model = self.array[indexPath.row];
    NSString *type = [NSString stringWithFormat:@"%@",model.type];
    if ([type isEqualToString: @"4"]) {
        height = 208;
    }else if ([type isEqualToString: @"5"]){
    
        height = 180;
    }else{
    
        height = 125;
    }
    return height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    RCModel *model = self.array[indexPath.row];
   
    NSString *type = [NSString stringWithFormat:@"%@",model.type];
    if ([type isEqualToString:@"1"]) {
        type1TableViewCell *type = [tableView dequeueReusableCellWithIdentifier:@"type1"];
        if (!type) {
            type = [[NSBundle mainBundle] loadNibNamed:@"type1TableViewCell" owner:self.tableView options:nil][0];
        }
        type.rcmodel = self.array[indexPath.row];
        cell = type;
    }else if ([type isEqualToString: @"2"]){
        type2TableViewCell *type = [tableView dequeueReusableCellWithIdentifier:@"type2"];
        if (!type) {
            type = [[NSBundle mainBundle] loadNibNamed:@"type2TableViewCell" owner:self.tableView options:nil][0];
        }
        type.rcmodel = self.array[indexPath.row];
        cell = type;
    }else if ([type isEqualToString: @"4"]){
        type4TableViewCell *type = [tableView dequeueReusableCellWithIdentifier:@"type4"];
        if (!type) {
            type = [[NSBundle mainBundle] loadNibNamed:@"type4TableViewCell" owner:self.tableView options:nil][0];
        }
        type.rcmodel = self.array[indexPath.row];
        cell = type;
        
    }else if ([type isEqualToString:@"5"]){
        type5TableViewCell *type = [tableView dequeueReusableCellWithIdentifier:@"type5"];
        if (!type) {
            type = [[NSBundle mainBundle] loadNibNamed:@"type5TableViewCell" owner:self.tableView options:nil][0];
            
        }
        type.rcmodel = self.array[indexPath.row];
        cell = type;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    RCModel *model = self.array[indexPath.row];
    
    NSString *type = [NSString stringWithFormat:@"%@",model.type];
    
    if ([type isEqualToString:@"5"]) {
        godImgViewController *godImg = [[godImgViewController alloc] init];
        godImg.godImg_aid = model.tid;
        godImg.godtitle   = model.title;
        godImg.godnumber  = model.album.count;
        [self.navigationController pushViewController:godImg animated:YES];
    }else if ([type isEqualToString:@"2"]){
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        specialViewController * special = [story instantiateViewControllerWithIdentifier:@"special"];
        special.type2_1url = model.tid;
        special.headurl = model.cover;
        [self.navigationController pushViewController:special animated:YES];
    }else{
        DetailViewController *detail = [[DetailViewController alloc] init];
        detail.detail_url = model.tid;
        [self.navigationController pushViewController:detail animated:YES];
   
    }
    
    
}

//将要展示某个cell
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    判断展示的cell位于倒数第五个或者更靠后的
        if (self.array.count - indexPath.row <= 5) {
            //满足加载更多条件
            page++;
            [self loadDataWithLoadType:kLoadMore];
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
