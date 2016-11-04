//
//  DCViewController.m
//  CurvyMoon
//
//  Created by qingyun on 16/5/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "DCViewController.h"

#import "DCDViewController.h"
#import "substitute.h"

#import "specialViewController.h"


#import "DspecialViewController.h"
#import "DspecialTableViewCell.h"
#import "YZHQView.h"
@interface DCViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic , copy) NSMutableArray * array;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"caidan"] style:UIBarButtonItemStyleDone target:self action:@selector(leftAction:)];
    self.title = @"一支好签";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self loadData];
    // Do any additional setup after loading the view.
}

//弹出视图执行的方法
- (void) leftAction:(UIBarButtonItem*)button
{
    YZHQView *view = [YZHQView defaultPopuView];
    view.parentVC = self;
    [self lew_presentPopupView:view animation:[LewPopupViewAnimationDrop new] dismissed:^{
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loadData{
  
    
   
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/html",@"text/json",@"text/plain",@"text/javascript",@"text/xml",@"image/*"]];
    
    // 设置允许同时最大并发数量，过大容易出问题
    manager.operationQueue.maxConcurrentOperationCount = 3;
    
    [manager GET:kdiscover parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *artlist =responseObject[@"content"][@"artlist"];
//               NSLog(@"%@",artlist);
        NSMutableArray *resultArr = [NSMutableArray arrayWithArray:[substitute RCModelWithArray:artlist]]; //作为新的数据源
        
        self.array = resultArr;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"点击加载更多" forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor lightGrayColor];
        btn.frame = CGRectMake(0, 0, self.view.frame.size.width, 100);
        [btn addTarget:self action:@selector(detail) forControlEvents:UIControlEventTouchUpInside];
        self.tableView.tableFooterView = btn;
        
        
        [self.tableView reloadData];
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //        NSLog(@"%@",error);

    }];


}

-(void)detail{
    DspecialViewController *special = [[DspecialViewController alloc] init];
    [self.navigationController pushViewController:special animated:YES];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height;
    if (KDevice_Is_Retina || kDevice_Is_iPhone5) {
        height = 125.0;
    }else  if (kDevice_Is_iPhone6) {
        height = 150.0;
    }else if (kDevice_Is_iPhone6Plus) {
        height =  175.0;
    }
    return height;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//
//    return 20;
//
//}
- (IBAction)switchTag:(UIButton *)sender {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DCDViewController *DCD = [story instantiateViewControllerWithIdentifier:@"DCD"];
    switch (sender.tag) {
        case 1:{
        NSString *tag_id =@"http://t.gexiaojie.com/api.php?output=json&a=getArticleByTag&c=column&_app_key=f722d367b8a96655c4f3365739d38d85&size=20&pg=%d&tag_id=568&_app_secret=30248115015ec6c79d3bed2915f9e4cc&m=index";
            DCD.tag_id = tag_id;
            [self.navigationController pushViewController:DCD animated:YES];
        }
            break;
        case 2:{
            NSString *tag_id = @"http://t.gexiaojie.com/api.php?output=json&a=getArticleByTag&c=column&_app_key=f722d367b8a96655c4f3365739d38d85&size=20&pg=1&tag_id=565&_app_secret=30248115015ec6c79d3bed2915f9e4cc&m=index";
            DCD.tag_id = tag_id;
            [self.navigationController pushViewController:DCD animated:YES];
        }
            break;
        case 3:{
            NSString *tag_id = @"http://t.gexiaojie.com/api.php?output=json&a=getArticleByTag&c=column&_app_key=f722d367b8a96655c4f3365739d38d85&size=20&pg=1&tag_id=566&_app_secret=30248115015ec6c79d3bed2915f9e4cc&m=index";
            DCD.tag_id = tag_id;
            [self.navigationController pushViewController:DCD animated:YES];
        }
            break;
        case 4:{
            NSString *tag_id = @"http://t.gexiaojie.com/api.php?output=json&a=getArticleByTag&c=column&_app_key=f722d367b8a96655c4f3365739d38d85&size=20&pg=1&tag_id=567&_app_secret=30248115015ec6c79d3bed2915f9e4cc&m=index";
            DCD.tag_id = tag_id;
            [self.navigationController pushViewController:DCD animated:YES];
        }
            break;
        case 5:{
            NSString *tag_id = @"http://t.gexiaojie.com/api.php?output=json&a=getArticleByTag&c=column&_app_key=f722d367b8a96655c4f3365739d38d85&size=20&pg=1&tag_id=570&_app_secret=30248115015ec6c79d3bed2915f9e4cc&m=index";
            DCD.tag_id = tag_id;
            [self.navigationController pushViewController:DCD animated:YES];
        }
            break;
        case 6:{
            NSString *tag_id = @"http://t.gexiaojie.com/api.php?output=json&a=getArticleByTag&c=column&_app_key=f722d367b8a96655c4f3365739d38d85&size=20&pg=1&tag_id=563&_app_secret=30248115015ec6c79d3bed2915f9e4cc&m=index";
            DCD.tag_id = tag_id;
            [self.navigationController pushViewController:DCD animated:YES];
        }
            break;
        case 7:{
            NSString *tag_id = @"http://t.gexiaojie.com/api.php?output=json&a=getArticleByTag&c=column&_app_key=f722d367b8a96655c4f3365739d38d85&size=20&pg=1&tag_id=569&_app_secret=30248115015ec6c79d3bed2915f9e4cc&m=index";
            DCD.tag_id = tag_id;
            [self.navigationController pushViewController:DCD animated:YES];
        }
            break;
        case 8:{
           NSString *tag_id = @"http://t.gexiaojie.com/api.php?output=json&a=getArticleByTag&c=column&_app_key=f722d367b8a96655c4f3365739d38d85&size=20&pg=1&tag_id=568&_app_secret=30248115015ec6c79d3bed2915f9e4cc&m=index";
            DCD.tag_id = tag_id;
            [self.navigationController pushViewController:DCD animated:YES];
        }
            break;
        
        default:
            break;
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
