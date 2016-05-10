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

Next, in viewDidLoad, insert ```[self fixBug2]```
