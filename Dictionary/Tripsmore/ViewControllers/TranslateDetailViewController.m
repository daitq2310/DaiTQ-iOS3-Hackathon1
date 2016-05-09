//
//  TranslateDetailViewController.m
//  Speedboy
//
//  Created by TaHoangMinh on 2/11/16.
//  Copyright © 2016 TaHoangMinh. All rights reserved.
//

#import "TranslateDetailViewController.h"
#import "AddWordViewController.h"
#import "BasedTableViewController.h"

@interface TranslateDetailViewController ()

@end

@implementation TranslateDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = LocalizedString(@"Translation Detail");
    
    [self refreshWordData];
    
    if ([@"1" isEqualToString:self.word.favorites]) {
        self.btnFavourite.selected = YES;
    } else {
        self.btnFavourite.selected = NO;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshWordData];
}
- (void) refreshWordData
{
    self.lblWord.text = self.word.word;
    self.lblDescription.text = self.word.strDescription;
    self.lblResult.text = self.word.result;
    self.lblEdited.text = self.word.edited;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnFavouriteClicked:(UIButton *)sender {
    if (sender.selected) {
        self.word.favorites = @"1";
    }
    [[DatabaseService shareInstance] update:self.word changeEditTime:NO];
    sender.selected = !sender.selected;
    if (!sender.selected) {
        [self.view makeToast:LocalizedString(@"Removed from favourite") duration:2.0 position:nil];
    } else {
        [self.view makeToast:LocalizedString(@"Added to favourite") duration:2.0 position:nil];
    }
}
- (IBAction)btnShareclicked:(id)sender {
    NSString *str=[NSString stringWithFormat:@"%@\n%@\nTranslate using: http://app_itune_link_here", self.word.word, self.word.result];
    NSArray *postItems=@[str];
    
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:postItems applicationActivities:nil];
    
    //iphone
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self presentViewController:controller animated:YES completion:nil];
    }
    //ipad
    else {
        UIPopoverController *popup = [[UIPopoverController alloc] initWithContentViewController:controller];
        [popup presentPopoverFromRect:CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height/4, 0, 0)inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
}

- (IBAction)btnEditClicked:(id)sender {
    UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:LocalizedString(@"Cancel") destructiveButtonTitle:nil otherButtonTitles:LocalizedString(@"Edit"), LocalizedString(@"Delete"), nil];
    actionsheet.tag = 1001;
    [actionsheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 2) {
        // do nothing
    } else if (buttonIndex == 0) {
        NSLog(@"Edit");
        AddWordViewController *vc = [[Utils mainStoryboard] instantiateViewControllerWithIdentifier:@"AddWordEditViewController"];
        vc.word = self.word;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (buttonIndex == 1) {
        NSLog(@"Delete");
        
#pragma mark - BUG 3
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"DELETE" message:@"Do you want to delete word?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
        [alert show];
    }
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        Words *word = [[Words alloc] init];
        if (self.word != nil) {
            word = self.word;
        }
        word.word = self.lblWord.text;
        word.result = self.lblResult.text;
        
        BOOL result = [[DatabaseService shareInstance] deleteW:word];
        if (result) {
            [self.view makeToast:LocalizedString(@"Deleted word successfully") duration:2.0 position:nil];
        } else {
            [self.view makeToast:LocalizedString(@"Deleted word failed!") duration:2.0 position:nil];
            
        }
        NSLog(@"Deleteeeeeeeeeeeeee");
    }
    
    if (buttonIndex == 1)
    {
        NSLog(@"11111111");
    }
}


//- (void)intializeFetchedResultsController;
//{
//
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Message"];
//    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"createdAt" ascending:NO];
//    request.sortDescriptors = @[sort];
//
//    NSManagedObjectContext *moc = APPDELEGATE.managedObjectContext;
//
//    _fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:moc sectionNameKeyPath:nil cacheName:nil];
//
//    self.fetchedResultsController.delegate = self;
//
//    NSError *error = nil;
//
//    if (![_fetchedResultsController performFetch:&error]) {
//        NSLog(@"%@",error);
//    }
//
//}


@end
