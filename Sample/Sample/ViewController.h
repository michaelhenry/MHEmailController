//
//  ViewController.h
//  Sample
//
//  Created by Michael henry Pantaleon on 9/19/12.
//  Copyright (c) 2012 iamkel.net . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHEmailController.h"

@interface ViewController : UIViewController<MFMailComposeViewControllerDelegate>
- (IBAction)didComposeEmail:(id)sender;
@end
