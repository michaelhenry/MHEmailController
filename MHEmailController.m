//
//  MHEmailController.m
//  Description : Override the Send Button of the MFMailComposeViewController then Add Captcha Verification Before sending it 
//
//  Created by Michael Henry Pantaleon on 07/12/12.
//  Copyright (c) 2012 iamkel.net . All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "MHEmailController.h"

@implementation MHEmailController
@synthesize sendButton,captchaString;
- (id) init { 
    self = [super init];
    if(self) { 
        
        self.modalPresentationStyle = UIModalPresentationFormSheet;
        self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        
        sendButton = self.navigationBar.topItem.rightBarButtonItem;
        
        // Hide The Default SEND Button
        self.navigationBar.topItem.rightBarButtonItem.customView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        
        //Add the New SEND Button
        self.navigationBar.topItem.rightBarButtonItem  = [[UIBarButtonItem alloc]initWithTitle:@"Send" style:UIBarButtonItemStyleBordered target:self action:@selector(confirmBeforeSend)];
        
    }
    
    return self;
}

#pragma mark - The New Send Method
- (void) confirmBeforeSend { 
     
    [self generateCaptcha];                                          
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Verify Captcha" message:[NSString stringWithFormat:@"Please enter this number: %@",self.captchaString] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alert show]; 
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex { 
    if(alertView.title==@"Verify Captcha") {
        if(buttonIndex == 1) { 
            UITextField * inputCaptcha = [alertView textFieldAtIndex:0];
            if([inputCaptcha.text isEqualToString:self.captchaString ]) {
                id target = self.sendButton.target;
                [target performSelector:self.sendButton.action withObject:self.sendButton];
            }else { 
                UIAlertView * failedAlert = [[UIAlertView alloc]initWithTitle:@"Verify Captcha" message:@"Invalid captcha. Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [failedAlert show];
                failedAlert = nil;
            }
        }else { 
            
        }
    }
}

#pragma mark - Generate Captcha For verification
- (void) generateCaptcha { 
    int number =(arc4random() % 99999) + 10000;
    self.captchaString = [NSString stringWithFormat:@"%d", number];
}


@end
