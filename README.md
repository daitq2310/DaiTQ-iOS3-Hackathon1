# DaiTQ-iOS3-Hackathon1

##Fix Bug 1:
In LeftMenuViewController.m, insert new code (Begin line 53)

```
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
```

##Fix Bug 2:
In LeftMenuViewController.m, insert new code (Begin line 37)

```
- (void) fixBug2 {
    self.lblTitle.text = @"Left Menu";
}
```

Next, in ```viewDidLoad```, insert ```[self fixBug2]```

##Fix Bug 3:
In ```- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex``` of TranslateDetailViewController.m, insert new code to create ```UIAlertView``` for popup (Begin line 98)

```
UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"DELETE" message:@"Do you want to delete word?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
        [alert show];
```

Next, write new function (Begin line 105)

```
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
        NSLog(@"Do nothing");
    }
}
```

##Fix Bug 4:
In ```- (IBAction)btnResetDataClicked:(id)sender;``` of SettingViewController.m, insert new code (Begin line 48). Use tag for alert if in file have many ```UIAlertView```

```
UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Do you want to reset all data?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    alert.tag = 101;
[alert show];
```

Next, write new function to call event of ```UIAlertView```

```
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 101) {
        if (buttonIndex == 0) {
            [[DatabaseService shareInstance] resetDB];
            NSLog(@"Resettttttttt");
        }
    }
}
```

##Fix Bug 5:
In ```- (IBAction)btnAboutClicked:(id)sender;``` of SettingViewController.m, insert new code (Begin line 64)

```
UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"This is Pashto dictionary application for iOS."     delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
[alert show];
```
