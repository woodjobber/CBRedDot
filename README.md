# CBRedDot
小红点 - RedDot

# 非常简单的使用 -- 一句代码搞定

```

 	UIView *view = [[UIView alloc]init];
    
    view.frame = CGRectMake(100, 200, 100, 100);
    view.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:view];
    
    //像这样只需要 添加到要显示的视图上面
  
    [view addSubview:[[CBRedDot alloc]init]];

```
