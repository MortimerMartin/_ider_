//
//  MeTableViewController.m
//  CurvyMoon
//
//  Created by qingyun on 16/5/20.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "MeTableViewController.h"

#import "qiushenwenbu.h"
@interface MeTableViewController ()<qiushenwenbuDelegate>
{
    qiushenwenbu *yuexialaoren;
}
@end

@implementation MeTableViewController

/*-----------------------------添加菜单---------------------*/
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //开启ios右滑返回
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:yuexialaoren.menuButton];
    [yuexialaoren insertMenuViewOnView];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*-----------------菜单控件-------------------*/
    NSArray *imageList = @[[UIImage imageNamed:@"俏佳人"], [UIImage imageNamed:@"居家"], [UIImage imageNamed:@"慧生活"], [UIImage imageNamed:@"领带"],[UIImage imageNamed:@"fashion"],[UIImage imageNamed:@"情商"],[UIImage imageNamed:@"旅游"]];
    yuexialaoren = [[qiushenwenbu alloc] initWithImages:imageList];
    yuexialaoren.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = YES;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
/*----------------菜单代理事件-----------------------------*/
- (void)menuButtonClicked:(int)index
{
    
    switch (index) {
        case 0:{
            self.navigationItem.title = @"美哒哒";
         self.automaticallyAdjustsScrollViewInsets = YES;
        }
            break;
        case 1:{
            //居家
            self.navigationItem.title = @"居家";
            self.automaticallyAdjustsScrollViewInsets = YES;
        }
            break;
        case 2:{
       
            self.navigationItem.title = @"慧生活";
            self.automaticallyAdjustsScrollViewInsets = YES;
            //慧生活
        }
            break;
        case 3:{
            //骨干
            self.navigationItem.title = @"白骨精";
                   }
            break;
        case 4:{
            //时尚
            self.navigationItem.title = @"时尚";
                   }
            break;
        case 5:{
            //情感
            self.navigationItem.title = @"情感";
            
        }
            break;
        case 6:{           
            self.navigationItem.title = @"旅游";
            
        }
            break;
        default:
            break;
    }
    //置顶
    [self.tableView setContentOffset:CGPointMake(0, -64) animated:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
