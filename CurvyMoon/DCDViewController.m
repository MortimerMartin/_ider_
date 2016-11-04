//
//  DCDViewController.m
//  CurvyMoon
//
//  Created by qingyun on 16/5/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "DCDViewController.h"


#import "substitute.h"
#import "type1TableViewCell.h"
#import "type2TableViewCell.h"
#import "type4TableViewCell.h"
#import "DetailViewController.h"
#import "specialViewController.h"
typedef enum : NSUInteger{
    kLoadHome,
    kLoadNew,
    kLoadMore,
    
} LoadType;
@interface DCDViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger page;
    BOOL      refreshing;
}
@property (nonatomic , copy) NSMutableArray * array;

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation DCDViewController

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
    
    
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self loadData:self.tag_id WithLoadType:kLoadNew];
    refreshing = NO;
    //tableview的高度自动计算
//    self.tableView.estimatedRowHeight = 125;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData:(UIRefreshControl *)refresh{
    [self loadData:self.tag_id WithLoadType:kLoadNew];
}

- (void)loadData:(NSString *)tag_id WithLoadType:(LoadType)type{
    if (type == kLoadHome || type == kLoadNew) {
        page = 1;
        NSString * urlString = [NSString stringWithFormat:tag_id,(long)page];
        [self loadData:urlString AndType:kLoadNew];
    }else{
        NSString *urlString = [NSString stringWithFormat:tag_id,(long)page];
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height;
    substitute *model = self.array[indexPath.row];
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
    substitute *model = self.array[indexPath.row];
    
    NSString *type = [NSString stringWithFormat:@"%@",model.type];
    if ([type isEqualToString:@"1"]) {
        type1TableViewCell *type1 = [tableView dequeueReusableCellWithIdentifier:@"tag_id"];
        if (!type1) {
            type1 = [[NSBundle mainBundle] loadNibNamed:@"type1TableViewCell" owner:self.tableView options:nil][0];
        }
        type1.rcmodel = self.array[indexPath.row];
        
        cell = type1;
    }else if ([type isEqualToString: @"2"]){
        type2TableViewCell *type2 = [tableView dequeueReusableCellWithIdentifier:@"tag_id2"];
        if (!type2) {
            type2 = [[NSBundle mainBundle] loadNibNamed:@"type2TableViewCell" owner:self.tableView options:nil][0];
        }
        type2.rcmodel = self.array[indexPath.row];
        cell = type2;
    }else if ([type isEqualToString: @"4"]){
        type4TableViewCell *type = [tableView dequeueReusableCellWithIdentifier:@"tag_id4"];
        if (!type) {
            type = [[NSBundle mainBundle] loadNibNamed:@"type4TableViewCell" owner:self.tableView options:nil][0];
        }
        type.rcmodel = self.array[indexPath.row];
        cell = type;
        
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    substitute *model = self.array[indexPath.row];
    
    NSString *type = [NSString stringWithFormat:@"%@",model.type];
    
    if ([type isEqualToString:@"2"]) {
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
        [self loadData:self.tag_id WithLoadType:kLoadMore];
    }
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
