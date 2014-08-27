//
//  DetailViewController.h
//  TableView-Practice
//
//  Created by Shoya Ishimaru on 2014/08/27.
//  Copyright (c) 2014年 shoya140. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPItem.h"

@interface TPDetailViewController : UIViewController<UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property TPItem *item;

@end
