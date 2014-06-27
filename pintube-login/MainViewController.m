//
//  MainViewController.m
//  pintube-login
//
//  Created by Taeho Ko on 6/26/14.
//  Copyright (c) 2014 google. All rights reserved.
//

#import "MainViewController.h"
#import "PostViewController.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *statusButtonView;
- (IBAction)onStatusButtonUp:(id)sender;
- (IBAction)onStatusButtonDown:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *firstFeedView;
@property (weak, nonatomic) IBOutlet UIImageView *secondFeedView;
@property (weak, nonatomic) IBOutlet UIImageView *thirdFeedView;
@property (weak, nonatomic) IBOutlet UIImageView *fourthFeedView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingSpinner;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *secondLoadingSpinner;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *thirdLoadingSpinner;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *fourthLoadingSpinner;

@property (nonatomic) BOOL secondFeedViewShown;
@property (nonatomic) BOOL thirdFeedViewShown;
@property (nonatomic) BOOL fourthFeedViewShown;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pintube_logo_top"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Set left and right buttons in the navigation bar
    UIImage *leftButtonImage = [[UIImage imageNamed:@"icon_search"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:leftButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(doNothing)];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    UIImage *rightButtonImage = [[UIImage imageNamed:@"icon_message"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:rightButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(doNothing)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    // Set the scroll view
    self.scrollView.contentSize = CGSizeMake(320, 2513);
    self.scrollView.delegate = self;
    
    // Set feed view visibility status
    self.secondFeedViewShown = NO;
    self.thirdFeedViewShown = NO;
    self.fourthFeedViewShown = NO;
    
    // Hide feed views
    self.firstFeedView.alpha = 0;
    self.secondFeedView.alpha = 0;
    self.thirdFeedView.alpha = 0;
    self.fourthFeedView.alpha = 0;
    
    // Delay the loading
    [self.loadingSpinner startAnimating];
    [self performSelector:@selector(loadFeedView) withObject:nil afterDelay:1.0];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)doNothing {
    
}

- (IBAction)onStatusButtonUp:(id)sender {
    self.statusButtonView.backgroundColor = [UIColor colorWithRed:(200/255.0) green:(200/255.0) blue:(200/255.0) alpha:0];
    
    PostViewController *vc = [[PostViewController alloc] init];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    
    nvc.navigationBar.barTintColor = [UIColor colorWithRed:(199/255.0) green:(37/255.0) blue:(39/255.0) alpha:1];
    nvc.navigationBar.translucent = NO;
    nvc.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    nvc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:nvc animated:YES completion:nil];
}

- (IBAction)onStatusButtonDown:(id)sender {
    self.statusButtonView.backgroundColor = [UIColor colorWithRed:(200/255.0) green:(200/255.0) blue:(200/255.0) alpha:0.4];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //NSLog(@"%f",self.scrollView.contentOffset.y);
    
    if (self.scrollView.contentOffset.y >= 400) {
        if (self.secondFeedViewShown == NO) {
            self.secondFeedViewShown = YES;
            [self.secondLoadingSpinner startAnimating];
            [self performSelector:@selector(loadSecondFeedView) withObject:nil afterDelay:1.0];
        }
    }
    
    if (self.scrollView.contentOffset.y >= 1000) {
        if (self.thirdFeedViewShown == NO) {
            self.thirdFeedViewShown = YES;
            [self.thirdLoadingSpinner startAnimating];
            [self performSelector:@selector(loadThirdFeedView) withObject:nil afterDelay:1.0];
        }
    }
    
    if (self.scrollView.contentOffset.y >= 1600) {
        if (self.fourthFeedViewShown == NO) {
            self.fourthFeedViewShown = YES;
            [self.fourthLoadingSpinner startAnimating];
            [self performSelector:@selector(loadFourthFeedView) withObject:nil afterDelay:1.0];
        }
    }
}

-(void)loadFeedView {
    [self.loadingSpinner stopAnimating];
    self.firstFeedView.alpha = 1;
    
    self.firstFeedView.center = CGPointMake(self.firstFeedView.center.x, self.firstFeedView.center.y + 300);
    [UIView animateWithDuration:0.2 animations:^{
        self.firstFeedView.center = CGPointMake(self.firstFeedView.center.x, self.firstFeedView.center.y - 300);
    }];
}

- (void)loadSecondFeedView {
    [self.secondLoadingSpinner stopAnimating];
    self.secondFeedView.alpha = 1;
    
    self.secondFeedView.center = CGPointMake(self.secondFeedView.center.x, self.secondFeedView.center.y + 300);
    [UIView animateWithDuration:0.2 animations:^{
        self.secondFeedView.center = CGPointMake(self.secondFeedView.center.x, self.secondFeedView.center.y - 300);
    }];
}

- (void)loadThirdFeedView {
    [self.thirdLoadingSpinner stopAnimating];
    self.thirdFeedView.alpha = 1;
    
    self.thirdFeedView.center = CGPointMake(self.thirdFeedView.center.x, self.thirdFeedView.center.y + 300);
    [UIView animateWithDuration:0.2 animations:^{
        self.thirdFeedView.center = CGPointMake(self.thirdFeedView.center.x, self.thirdFeedView.center.y - 300);
    }];
}

- (void)loadFourthFeedView {
    [self.fourthLoadingSpinner stopAnimating];
    self.fourthFeedView.alpha = 1;
    
    self.fourthFeedView.center = CGPointMake(self.fourthFeedView.center.x, self.fourthFeedView.center.y + 300);
    [UIView animateWithDuration:0.2 animations:^{
        self.fourthFeedView.center = CGPointMake(self.fourthFeedView.center.x, self.fourthFeedView.center.y - 300);
    }];
}

@end
