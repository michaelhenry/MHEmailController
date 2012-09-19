//
//  ViewController.m
//  Sample
//
//  Created by Michael henry Pantaleon on 9/19/12.
//  Copyright (c) 2012 iamkel.net . All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (IBAction)didComposeEmail:(id)sender {
    MHEmailController *emailController = [[MHEmailController alloc] init];
    [emailController setMailComposeDelegate: self];
    [emailController setSubject:@"Email With Captcha Verification"];
    [emailController setToRecipients: nil];
    [emailController setMessageBody:@"" isHTML:NO];
    [self presentModalViewController:emailController animated:YES];
}

#pragma mark - Email Delegate
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [self becomeFirstResponder];
    [self dismissModalViewControllerAnimated:YES];
}

@end
