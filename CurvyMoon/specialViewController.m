//
//  specialViewController.m
//  CurvyMoon
//
//  Created by qingyun on 16/5/16.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "specialViewController.h"
#import "RCModel.h"

#import "type1TableViewCell.h"

#import "DetailViewController.h"
@interface specialViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic , copy) NSMutableArray *array;
@end

@implementation specialViewController

//- (NSMutableArray *)array{
//    if (!_array) {
//        _array = [NSMutableArray array];
//    }
//    return self.array;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"专题";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.backgroundColor = [UIColor redColor];
    
    self.array = [NSMutableArray array];
//    tableview的高度自动计算
//    self.tableView.estimatedRowHeight = 121;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self requestData];
    // Do any additional setup after loading the view.
}


- (void)requestData{
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 120)];
    [imgView sd_setImageWithURL:[NSURL URLWithString:self.headurl] placeholderImage:nil];
    self.tableView.tableHeaderView = imgView;
    
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/html",@"text/json",@"text/plain",@"text/javascript",@"text/xml",@"image/*"]];
    
    // 设置允许同时最大并发数量，过大容易出问题
    manager.operationQueue.maxConcurrentOperationCount = 3;
    NSString *url = [kType2_1url stringByAppendingString:self.type2_1url];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
   
        NSArray *artlist =responseObject[@"content"][@"artlist"];
        
        NSMutableArray *resultArr = [NSMutableArray arrayWithArray:[RCModel RCModelWithArray:artlist]]; //作为新的数据源
        self.array = resultArr;
        
        

        
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


#pragma mark UITableViewDataSoure
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.array.count;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height;
    return height = 121;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
        UITableViewCell *cell = nil;
//    RCModel *model = self.array[indexPath.row];
    type1TableViewCell *type = [tableView dequeueReusableCellWithIdentifier:@"type2_1"];
    if (!type) {
        type = [[NSBundle mainBundle] loadNibNamed:@"type1TableViewCell" owner:self.tableView options:nil][0];
    }
    type.rcmodel = self.array[indexPath.row];
    cell = type;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    RCModel *model = self.array[indexPath.row];
    DetailViewController *detail = [[DetailViewController alloc] init];
    detail.detail_url = model.tid;
    [self.navigationController pushViewController:detail animated:YES];

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
