//
//  MeViewController.m
//  pintube-login
//
//  Created by Taeho Ko on 6/26/14.
//  Copyright (c) 2014 google. All rights reserved.
//

#import "MeViewController.h"
#import "LoginViewController.h"

@interface MeViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *logoutButtonView;
- (IBAction)onLogoutUp:(id)sender;
- (IBAction)onLogoutDown:(id)sender;

@end

@implementation MeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"Search";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.scrollView.contentSize = CGSizeMake(320, 2135);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onLogoutUp:(id)sender {
    self.logoutButtonView.backgroundColor = [UIColor colorWithRed:(200/255.0) green:(200/255.0) blue:(200/255.0) alpha:0];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Are you sure you want to log out?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Log out" otherButtonTitles:nil, nil];
    [actionSheet showInView:self.view];
}

- (IBAction)onLogoutDown:(id)sender {
    self.logoutButtonView.backgroundColor = [UIColor colorWithRed:(200/255.0) green:(200/255.0) blue:(200/255.0) alpha:0.4];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        UIViewController *vc = [[LoginViewController alloc] init];
        UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
        vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        [self presentViewController:nvc animated:YES completion:nil];
    }
}
@end
