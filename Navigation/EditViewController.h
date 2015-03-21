//
//  EditViewController.h
//  Navigation
//
//  Created by Bruno Omella Mainieri on 3/19/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditViewController : UITabBarController <UIImagePickerControllerDelegate>

@property UITextField *texto;
@property UIImageView *imagem;
@property UIToolbar *toolbar;
@property UIImagePickerController *imagePicker;
@property UIDatePicker *datePicker;

@end
