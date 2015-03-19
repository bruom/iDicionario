//
//  LetrasTabBarController.m
//  Navigation
//
//  Created by Bruno Omella Mainieri on 3/18/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import "LetrasTabBarController.h"
#import "BuscaViewController.h"
#import "LetrasTableViewController.h"

@interface LetrasTabBarController ()

@end

@implementation LetrasTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BuscaViewController *viewController = [[BuscaViewController alloc]
                                           initWithNibName:nil
                                           bundle:nil];
    
    
    UINavigationController *navController = [[UINavigationController alloc]
                                 initWithRootViewController:viewController];
    
    LetrasTableViewController *tvc = [[LetrasTableViewController alloc]init];
    
    navController.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Letras" image:nil tag:1];
    tvc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"TableView" image:nil tag:2];
    
    [self setViewControllers:[NSArray arrayWithObjects:navController, tvc, nil]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
