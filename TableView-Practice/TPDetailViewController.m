//
//  DetailViewController.m
//  TableView-Practice
//
//  Created by Shoya Ishimaru on 2014/08/27.
//  Copyright (c) 2014年 shoya140. All rights reserved.
//

#import "TPDetailViewController.h"
#import "TPDataManager.h"

@interface TPDetailViewController (){
    BOOL isObserving;
}

@end

@implementation TPDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Detail";
    self.titleTextField.text = self.item.title;
    self.titleTextField.delegate = self;
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageWasTapped:)];
    self.imageView.image = [UIImage imageWithContentsOfFile:self.item.imagePath];
    [self.imageView addGestureRecognizer:recognizer];
    
    [self registerForKeyboardNotifications];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    self.item.title = textField.text;
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    [textField resignFirstResponder];
    return YES;
}

- (void)imageWasTapped:(UIGestureRecognizer *)recognizer{
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Accessing to photo library is forbidden" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
    UIImagePickerController *imagePickerControlelr = [[UIImagePickerController alloc] init];
    [imagePickerControlelr setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    imagePickerControlelr.delegate = self;
    imagePickerControlelr.allowsEditing = YES;
    [self presentViewController:imagePickerControlelr animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [self.imageView setImage:image];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    NSDateFormatter *forematter = [[NSDateFormatter alloc] init];
    [forematter setDateFormat:@"YYYY-MM-dd_hh-mm-ss"];
    TPDataManager *dataManager = [TPDataManager sharedManager];
    NSString *imageFilePath = [NSString stringWithFormat:@"%@/%@.jpg",[dataManager documentsDirectory], [forematter stringFromDate:[NSDate date]]];
    [UIImageJPEGRepresentation(image, 1.0f) writeToFile:imageFilePath atomically:YES];
    self.item.imagePath = imageFilePath;
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    CGPoint scrollPoint = CGPointMake(0.0,40.0);
    [self.scrollView setContentOffset:scrollPoint animated:YES];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    CGPoint scrollPoint = CGPointMake(0.0,-64.0);
    [self.scrollView setContentOffset:scrollPoint animated:YES];
}

@end
