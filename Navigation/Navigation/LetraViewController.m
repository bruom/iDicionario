//
//  LetraViewController.m
//  Navigation
//
//  Created by Bruno Omella Mainieri on 3/16/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import "LetraViewController.h"
#import "DataSourceSingleton.h"

@interface LetraViewController ()

@end

@implementation LetraViewController

@synthesize imagem;

DataSourceSingleton *dss;
int thisLetra;
UIButton *botao;

-(void) viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES];
    
    dss = [DataSourceSingleton instance];
    NSLog(@"%d", thisLetra);
    thisLetra = dss.letra;
    
    self.title = [NSString stringWithFormat:@"%c",[[dss.palavras objectAtIndex:thisLetra] characterAtIndex:0]];
    
    if(!(thisLetra>dss.palavras.count-2)){
        UIBarButtonItem *next = [[UIBarButtonItem alloc]
                             initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(next:)];
        self.navigationItem.rightBarButtonItem=next;
    }
    
    if(thisLetra>0){
        UIBarButtonItem *prev  = [[UIBarButtonItem alloc]
                             initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(prev:)];
        self.navigationItem.leftBarButtonItem=prev;
    }
    
    imagem = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width/2)-100, 80, 200, 200)];
    imagem.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", [NSString stringWithFormat:@"%c",[[dss.palavras objectAtIndex:thisLetra] characterAtIndex:0]]]];
    imagem.userInteractionEnabled = YES;
    
    UILongPressGestureRecognizer *toqueImagem = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(toqueImagemHandler:)];
    [self.imagem addGestureRecognizer:toqueImagem];
    
    botao = [UIButton
                       buttonWithType:UIButtonTypeSystem];
    [botao
     //setTitle:@"Mostre uma palavra, uma figura e leia a palavra ao apertar um botao"
     setTitle: [NSString stringWithFormat:@"%@", [dss.palavras objectAtIndex:thisLetra]]
     forState:UIControlStateNormal];
    [botao sizeToFit];
    botao.center = self.view.center;
    
    [self.view addSubview:botao];
    [self.view addSubview:imagem];
    
    
}

-(void) viewWillAppear:(BOOL)animated{
    [UIView animateWithDuration:0.0 animations:^{
        imagem.transform = CGAffineTransformMakeScale(0.5, 0.5);
    }];
}

-(void) viewDidAppear:(BOOL)animated{
    NSLog(@"appear %d", thisLetra);
    [UIView animateWithDuration:1.0 animations:^{
        imagem.transform = CGAffineTransformMakeScale(1.0, 1.0);
        botao.transform = CGAffineTransformMakeTranslation(0.0, 20.0);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)next:(id)sender {
    
    dss = [DataSourceSingleton instance];
    dss.letra = thisLetra + 1;
    
    LetraViewController *proximo = [[LetraViewController alloc]
                                     initWithNibName:nil
                                     bundle:NULL];
    
    [UIView animateWithDuration:1.0 animations:^{
        imagem.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
        botao.transform = CGAffineTransformMakeTranslation(0.0, 1000.0);
    } completion:^(BOOL finished) {
        [self.navigationController pushViewController:proximo
                                             animated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
}

-(void)prev:(id)sender {
    
    dss = [DataSourceSingleton instance];
    dss.letra = thisLetra - 1;
    
    LetraViewController *anterior = [[LetraViewController alloc]
                                    initWithNibName:nil
                                    bundle:NULL];

    [UIView animateWithDuration:1.0 animations:^{
        imagem.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
        botao.transform = CGAffineTransformMakeTranslation(0.0, 2000.0);
    } completion:^(BOOL finished) {
        [self.navigationController pushViewController:anterior
                                             animated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

-(void)toqueImagemHandler:(UILongPressGestureRecognizer *)touch{
    
    if(touch.state == UIGestureRecognizerStateBegan){
        [UIView animateWithDuration:0.4 animations:^{
            imagem. transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.5, 1.5), CGAffineTransformMakeTranslation(0.0, 50.0));
            botao.transform = CGAffineTransformMakeTranslation(0.0, 110.0);
        }];
    }else if(touch.state == UIGestureRecognizerStateEnded){
        [UIView animateWithDuration:0.4 animations:^{
            imagem. transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.0, 1.0), CGAffineTransformMakeTranslation(0.0, 0.0));
            botao.transform = CGAffineTransformMakeTranslation(0.0, 20.0);
        }];
    }
    
}

@end
