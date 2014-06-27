//
//  LoginViewController.m
//  pintube-login
//
//  Created by Taeho Ko on 6/24/14.
//  Copyright (c) 2014 google. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginViewController.h"
#import "MainViewController.h"
#import "SearchViewController.h"
#import "AddViewController.h"
#import "MessagesViewController.h"
#import "MeViewController.h"
#import "MessagesTableViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UIView *linkView;

@property (weak, nonatomic) IBOutlet UIView *textView;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (nonatomic) BOOL elementsUpState;
- (IBAction)onEmailEditingBegin:(id)sender;
- (IBAction)onPasswordEditingBegin:(id)sender;
- (IBAction)onEmailEditingChanged:(id)sender;
- (IBAction)onPasswordEditingChanged:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *loginButtonView;
@property (weak, nonatomic) IBOutlet UILabel *loginButtonLabel;
@property (weak, nonatomic) IBOutlet UIImageView *loginButtonImageView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingSpinner;
- (IBAction)onLoginButtonUp:(id)sender;





@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.navigationController.navigationBar.hidden = YES;
    
    self.loginButtonLabel.textColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.5];
    
    self.elementsUpState = NO;
    self.loginButton.enabled = NO;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onEmailEditingBegin:(id)sender {
    if (self.elementsUpState == NO) {
        [self moveElementsUp];
    }
}

- (IBAction)onPasswordEditingBegin:(id)sender {
    if (self.elementsUpState == NO) {
        [self moveElementsUp];
    }
}

- (IBAction)onEmailEditingChanged:(id)sender {
    [self preCheckLoginInfo];
}

- (IBAction)onPasswordEditingChanged:(id)sender {
    [self preCheckLoginInfo];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    if (self.elementsUpState == YES) {
        [self moveElementsDown];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField) {
        [textField resignFirstResponder];
    }
    return NO;
}

- (void)moveElementsUp {
    self.elementsUpState = YES;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.logoImageView.frame = CGRectMake(self.logoImageView.frame.origin.x + 14, self.logoImageView.frame.origin.y - 40, self.logoImageView.frame.size.width * 0.6, self.logoImageView.frame.size.height * 0.6);
        
        self.textView.center = CGPointMake(self.textView.center.x, self.textView.center.y - 80);
        
        self.loginButtonView.center = CGPointMake(self.loginButtonView.center.x, self.loginButtonView.center.y - 80);
        
        self.linkView.center = CGPointMake(self.linkView.center.x, self.linkView.center.y - 190);
    }];
}

- (void)moveElementsDown {
    self.elementsUpState = NO;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.logoImageView.frame = CGRectMake(124, 110, 71, 72);
        
        self.textView.center = CGPointMake(self.textView.center.x, self.textView.center.y + 80);
        
        self.loginButtonView.center = CGPointMake(self.loginButtonView.center.x, self.loginButtonView.center.y + 80);
        
        self.linkView.center = CGPointMake(self.linkView.center.x, self.linkView.center.y + 190);
    }];
}

- (void)preCheckLoginInfo {
    self.loginButtonImageView.alpha = 1.0;
    
    if (([self.emailTextField.text isEqual:@""]) || ([self.passwordTextField.text isEqual:@""])) {
        self.loginButtonImageView.image = [UIImage imageNamed:@"login_button_disabled"];
        self.loginButtonLabel.textColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.5];
        self.loginButton.enabled = NO;
    } else {
        self.loginButtonImageView.image = [UIImage imageNamed:@"login_button"];
        self.loginButtonLabel.textColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:1.0];
        self.loginButton.enabled = YES;
    }
}


- (IBAction)onLoginButtonUp:(id)sender {
    self.loginButtonLabel.text = @"Loggin in";
    self.loginButtonImageView.alpha = 0.8;
    self.loginButtonLabel.textColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.5];
    self.loginButton.enabled = NO;
    
    [self.loadingSpinner startAnimating];
    [self performSelector:@selector(validateLoginInfo) withObject:nil afterDelay:1.0];
}

- (void)validateLoginInfo {
    [self.loadingSpinner stopAnimating];
    
    if ([self.passwordTextField.text isEqual:(@"password")]) {
        [self launchMainApp];
    } else {
        self.passwordTextField.text = @"";
        self.loginButtonLabel.text = @"Log in";
        [self preCheckLoginInfo];
        self.loginButton.enabled = YES;
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Incorrect Password" message:@"The password you entered is incorrect. Please try again." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
    }

}

- (void)launchMainApp {
    // Set up 5 tab view controllers
    MainViewController *mainVC = [[MainViewController alloc] init];
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    AddViewController *addVC = [[AddViewController alloc] init];
    MessagesViewController *messagesVC = [[MessagesViewController alloc] init];
    MeViewController *meVC = [[MeViewController alloc] init];
    
    UINavigationController *mainNC= [[UINavigationController alloc] initWithRootViewController:mainVC];
    UINavigationController *searchNC = [[UINavigationController alloc] initWithRootViewController:searchVC];
    UINavigationController *messagesNC = [[UINavigationController alloc] initWithRootViewController:messagesVC];
    UINavigationController *meNC = [[UINavigationController alloc] initWithRootViewController:meVC];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[mainNC, searchNC, addVC, messagesNC, meNC];
    
    // Set up tab names and icons
    mainNC.tabBarItem.title = @"Main";
    mainNC.tabBarItem.image = [UIImage imageNamed:@"tab_main"];
    mainNC.navigationBar.barTintColor = [UIColor colorWithRed:(199/255.0) green:(37/255.0) blue:(39/255.0) alpha:1];
    mainNC.navigationBar.translucent = NO;
    mainNC.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    searchNC.tabBarItem.title = @"Search";
    searchNC.tabBarItem.image = [UIImage imageNamed:@"tab_search"];
    searchNC.navigationBar.barTintColor = [UIColor colorWithRed:(199/255.0) green:(37/255.0) blue:(39/255.0) alpha:1];
    searchNC.navigationBar.translucent = NO;
    searchNC.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    addVC.tabBarItem.title = @"Add";
    addVC.tabBarItem.image = [UIImage imageNamed:@"tab_add"];
    
    messagesNC.tabBarItem.title = @"Messages";
    messagesNC.tabBarItem.image = [UIImage imageNamed:@"tab_messages"];
    messagesNC.navigationBar.barTintColor = [UIColor colorWithRed:(199/255.0) green:(37/255.0) blue:(39/255.0) alpha:1];
    messagesNC.navigationBar.translucent = NO;
    messagesNC.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    meNC.tabBarItem.title = @"Taeho";
    meNC.tabBarItem.image = [UIImage imageNamed:@"tab_me"];
    meNC.navigationBar.barTintColor = [UIColor colorWithRed:(199/255.0) green:(37/255.0) blue:(39/255.0) alpha:1];
    meNC.navigationBar.translucent = NO;
    meNC.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    // Set the tab bar appearance
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:(199/255.0) green:(37/255.0) blue:(39/255.0) alpha:1]];
    [[UITabBar appearance] setBarTintColor:[UIColor colorWithRed:(242/255.0) green:(242/255.0) blue:(242/255.0) alpha:1]]; //#f2f2f2
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    tabBarController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:tabBarController animated:YES completion:nil];
}
@end