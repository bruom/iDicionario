//
//  BuscaViewController.m
//  Navigation
//
//  Created by Bruno Omella Mainieri on 3/17/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import "BuscaViewController.h"
#import "DataSourceSingleton.h"
#import "LetraViewController.h"

@interface BuscaViewController ()

@end

@implementation BuscaViewController

DataSourceSingleton *dss;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *botao = [UIButton buttonWithType:UIButtonTypeSystem];
    [botao setTitle:@"A" forState:UIControlStateNormal];
    [botao sizeToFit];
    [botao addTarget:self action:@selector(botaoLetra:) forControlEvents:UIControlEventTouchDown];
    botao.center = self.view.center;
    [self.view addSubview:botao];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)botaoLetra:(id)sender{
    dss = [DataSourceSingleton instance];
    
    LetraViewController *proximo = [[LetraViewController alloc]
                                    initWithNibName:nil
                                    bundle:NULL];
    self.navigationController.viewControllers = [[NSArray alloc]initWithObjects:[[LetraViewController alloc]init], proximo, [[LetraViewController alloc]init], nil];
    [self.navigationController popToViewController:proximo animated:YES];
    
    
    
}


@end
