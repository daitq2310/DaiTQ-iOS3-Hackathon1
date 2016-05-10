//
//  AddWordViewController.m
//  Speedboy
//
//  Created by TaHoangMinh on 2/11/16.
//  Copyright © 2016 TaHoangMinh. All rights reserved.
//

#import "AddWordViewController.h"
#import "TranslateViewController.h"

@interface AddWordViewController () <UIGestureRecognizerDelegate>

@property NSString *str;

@end

@implementation AddWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _str = [[NSString alloc] init];
    self.view.userInteractionEnabled = YES;
    if (self.word == nil) {
        [self.view addGestureRecognizer:[SWRevealViewController shareInstance].panGestureRecognizer];
    } else {
        self.tfWord.text = self.word.word;
        self.tfTranslate.text = self.word.result;
    }
#pragma mark - BUG 10
    self.title = LocalizedString(@"Add Word");
}

- (void)backAction:(id)sender
{
    if (self.word == nil) {
        [[SWRevealViewController shareInstance] revealToggle:self.btnBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
    [self dismissKeyboardWhenClick];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnClearClicked:(id)sender {
    self.tfTranslate.text = @"";
    self.tfWord.text = @"";
    [self dismissKeyboardWhenClick];
}

- (IBAction)btnSaveClicked:(id)sender {
    Words *word = [[Words alloc] init];
    if (self.word != nil) {
        word = self.word;
    }
    word.word = self.tfWord.text;
    
    word.result = self.tfTranslate.text;
    word.isEng2Pa = self.isEng2Pa;
    
    _str = [[DatabaseService shareInstance] getDataByWord:word];
    if ([_str isEqualToString:@"string"]) {
        BOOL result = [[DatabaseService shareInstance] insert:word changeEditTime:YES];
        if (result) {
            self.tfTranslate.text = @"";
            self.tfWord.text = @"";
            [self.view makeToast:LocalizedString(@"Inserted word successfully") duration:2.0 position:nil];
        } else {
            [self.view makeToast:LocalizedString(@"Inserted word failed!") duration:2.0 position:nil];
            
        }
    } else {
        BOOL result = [[DatabaseService shareInstance] update:word changeEditTime:YES];
        if (result) {
            [self.view makeToast:LocalizedString(@"Updated word successfully") duration:2.0 position:nil];
        } else {
            [self.view makeToast:LocalizedString(@"Updated word failed!") duration:2.0 position:nil];
            
        }
        NSLog(@"Updateeeeeeeeeee");
    }
    [self dismissKeyboardWhenClick];
}

#pragma mark - BUG 9
- (void) dismissKeyboardWhenClick {
    [self.view endEditing:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([_tfWord isKindOfClass:[UITextField class]] && [_tfWord isFirstResponder]) {
        [_tfWord resignFirstResponder];
    }
    
    if ([_tfTranslate isKindOfClass:[UITextField class]] && [_tfTranslate isFirstResponder]) {
        [_tfTranslate resignFirstResponder];
    }
}

@end
