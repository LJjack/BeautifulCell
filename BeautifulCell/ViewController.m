//
//  ViewController.m
//  BeautifulCell
//
//  Created by zangqilong on 15/3/26.
//  Copyright (c) 2015年 zangqilong. All rights reserved.
//

#import "ViewController.h"
#import "CustomTableViewCell.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger rowCount;
    
}
@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    rowCount = 10;
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"customCell"];
    cell.cellIndex = indexPath;
    cell.cellBlock = ^(BOOL isDelete, NSIndexPath *index){
        if (isDelete) {
            
            [_mTableView beginUpdates];
            rowCount--;
            [_mTableView deleteRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationRight];
            [_mTableView endUpdates];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [_mTableView reloadData];
            });
           
        }
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
