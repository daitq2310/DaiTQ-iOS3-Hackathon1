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

Next, in ```- (void) viewDidLoad```, insert ```[self fixBug2]```

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
            [self.navigationController popViewControllerAnimated:YES];
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

##Fix Bug 6 + 7:
In ColorChooserViewController.m, change value "#F44336" and "#03A9F4" to "#3F51B5" and "#607DBB" (Line 44 and line 46)

##Fix Bug 8:
In ```- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;``` of ColorChooserViewController.m, insert new code (At line 88)

```[StaticData sharedInstance].mainColor = [Utils colorFromHex:self.arrColorValue[indexPath.row]];```

Next, in ``` - (void) viewDidLoad``` of SplashViewController.m, insert new code (At line 20)

```self.view.backgroundColor = [StaticData sharedInstance].mainColor;```

##Fix Bug 9:
Firstly, In TranslateViewController.m, insert new code (Begin line 111)

```
- (IBAction) dismissKeyBoardWhenTap:(id)sender{
    if ([_tfInput isKindOfClass:[UITextField class]] && [_tfInput isFirstResponder]) {
        [_tfInput resignFirstResponder];
    }
}

- (void) dismissKeyBoardWhenClick {
    [self.view endEditing:YES];
}
```

Next, insert into ```- (void) viewDidLoad``` 

```
UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyBoardWhenTap:)];
    [self.tableView addGestureRecognizer:tap];
    tap.cancelsTouchesInView = NO;
```

Insert ```[self dismissKeyBoardWhenClick];``` to at the end of ```- (IBAction)btnEng2PaClicked:(id)sender```, ```- (IBAction)btnPa2EngClicked:(id)sender```

Secondly, In AddWordViewController.m, insert new code (Begin line 89)

```
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
```

Insert ```[self dismissKeyboardWhenClick];``` to at the end of ```- (void)backAction:(id)sender```, ```- (IBAction)btnClearClicked:(id)sender```, ```- (IBAction)btnSaveClicked:(id)sender```

##Fix Bug 10:
Change "Edit" to "Add Word" of AddWordViewController.m (At line 30)

##Fix Bug 11:
Change "result1" to "result" of DatabaseService.m (At line 97)

##Fix Bug 12:
1. In DatabaseService.h, insert ```- (NSString *)getDataByWord : (Words *)word;```

2. In DatabaseService.m, insert new code (Begin line 62)

```
- (NSString *)getDataByWord : (Words *)word;
{
    NSString *str = [[NSString alloc] init];
    
    [self.database open];
    NSString *strDB = @"table_eng_pa";
    if (!word.isEng2Pa) {
        strDB = @"table_pa_eng";
    }
    
    NSString *strQuery = [NSString stringWithFormat:@"select favorites from %@ where word = ?",strDB];
    FMResultSet *rs = [_database executeQuery:strQuery,word.word];
    if (rs.next) {
        str = [rs stringForColumn:@"favorites"];
    } else {
        return @"string";
    }

    return str;
}
```

3. In ```- (BOOL) update:(Words *)word changeEditTime:(BOOL)changeEditTime;``` of DatabaseService.m </br>
</br>
Change: ```@"UPDATE SET word='%@', result='%@', description='%@', favorites='%@', edited='%@' WHERE _id=%ld"``` </br>
To: ```@"UPDATE '%@' SET result='%@', description='%@', favorites='%@', edited='%@' WHERE word='%@'"``` </br>
And delete ```SAFE_STR(word.word)```
