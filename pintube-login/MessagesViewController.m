//
//  MessagesViewController.m
//  pintube-login
//
//  Created by Taeho Ko on 6/26/14.
//  Copyright (c) 2014 google. All rights reserved.
//

#import "MessagesViewController.h"

@interface MessagesViewController ()
{
    UIRefreshControl *refreshControl;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation MessagesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"Messages";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.scrollView.contentSize = CGSizeMake(320, 1163);
    
    UIView *refreshView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.tableView insertSubview:refreshView atIndex:0]; //the tableView is a IBOutlet
    
    refreshControl = [[UIRefreshControl alloc] init];
    //refreshControl.tintColor = [UIColor redColor];
    [refreshControl addTarget:self action:@selector(reloadDatas) forControlEvents:UIControlEventValueChanged];
    [refreshView addSubview:refreshControl];
}

-(void)reloadDatas
{
    [self performSelector:@selector(endRefresh) withObject:nil afterDelay:1.0];
}

-(void)endRefresh
{
    [refreshControl endRefreshing];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
