//
//  TableViewController.m
//  TableView-Practice
//
//  Created by Shoya Ishimaru on 2014/08/27.
//  Copyright (c) 2014年 shoya140. All rights reserved.
//

#import "TPTableViewController.h"
#import "TPDetailViewController.h"

#import "TPItem.h"
#import "TPDataManager.h"

@interface TPTableViewController (){
    NSArray *items;
}


@end

@implementation TPTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    TPDataManager *dataManager = [TPDataManager sharedManager];
    if (!dataManager.launched) {
        dataManager.launched = YES;
        TPDataManager *dataManager = [TPDataManager sharedManager];
        [dataManager resetData];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    items = [TPItem MR_findAll];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    TPItem *item = [items objectAtIndex:indexPath.row];
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:1];
    imageView.image = [UIImage imageWithContentsOfFile:item.imagePath];
    UILabel *label = (UILabel *)[cell viewWithTag:2];
    label.text = item.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TPItem *item = [items objectAtIndex:indexPath.row];
    TPDetailViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TPDetailViewController"];
    detailVC.item = item;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (IBAction)resetButtonWasPushed:(id)sender {
    TPDataManager *dataManager = [TPDataManager sharedManager];
    [dataManager resetData];
    items = [TPItem MR_findAll];
    [self.tableView reloadData];
}

- (IBAction)addButtonWasPushed:(id)sender {
    TPItem *item =[TPItem MR_createEntity];
    TPDataManager *dataManager = [TPDataManager sharedManager];
    item.imagePath = [NSString stringWithFormat:@"%@/sample.jpg",[dataManager documentsDirectory]];
    TPDetailViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TPDetailViewController"];
    detailVC.item = item;
    [self.navigationController pushViewController:detailVC animated:YES];
}
@end
