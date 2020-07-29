//
//  UIViewController+Error.m
//  DiscountDiscover
//
//  Created by Kaitlyn Gunadhi on 7/29/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import "UIViewController+Error.h"

@implementation UIViewController (Error)

- (void)showErrorAlert:(NSString *)title message:(NSString *)message {
    UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:title
                                                                        message:message
    preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
      style:UIAlertActionStyleDefault
    handler:^(UIAlertAction * _Nonnull action) {}];
    [errorAlert addAction:okAction];
    [self presentViewController:errorAlert animated:YES completion:nil];
}

@end
