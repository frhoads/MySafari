//
//  ViewController.m
//  MySafari
//
//  Created by Apple on 09/01/14.
//  Copyright (c) 2014 Tablified Solutions. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate, UIScrollViewDelegate>
{
    
    __weak IBOutlet UIWebView *myWebView;
    __weak IBOutlet UITextField *myURLTextField;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    myWebView.scrollView.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSURL *url;
    
    if ([myURLTextField.text hasPrefix:@"http://"]) {
        url = [NSURL URLWithString:myURLTextField.text];
    } else {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", myURLTextField.text]];
    }

    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [myWebView loadRequest:request];
    [myURLTextField resignFirstResponder];

    return YES;
}

- (IBAction)onBackButtonPressed:(id)sender {
    [myWebView goBack];
}

- (IBAction)onForwardButtonPressed:(id)sender {
    [myWebView goForward];
}

- (IBAction)onStopLoadingButtonPressed:(id)sender {
    [myWebView stopLoading];
}

- (IBAction)onReloadButtonPressed:(id)sender {
    [myWebView reload];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
    
    if(translation.y > 0)
    {
        NSLog(@"Scrolling Down");
        myURLTextField.alpha += 0.05;
        myURLTextField.frame = CGRectMake(myURLTextField.frame.origin.x, 30, myURLTextField.frame.size.width, myURLTextField.frame.size.height);
        
    } else
    {
        NSLog(@"Scrolling Up");
        myURLTextField.alpha -= 0.05;
        myURLTextField.frame = CGRectMake(myURLTextField.frame.origin.x, (myURLTextField.frame.origin.y + 10), myURLTextField.frame.size.width, myURLTextField.frame.size.height);

    }
}

- (IBAction)onTeaserButtonPressed:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Coming Soon" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    
    [alert show];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
