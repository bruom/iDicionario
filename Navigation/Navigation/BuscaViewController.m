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
UITextField *textoBusca;
UIButton *botaoBusca;

- (void)viewDidLoad {
    [super viewDidLoad];
    dss = [DataSourceSingleton instance];
    
    self.navigationItem.title = @"iDicionario";
    
    UILabel *textoInicial = [[UILabel alloc]initWithFrame:CGRectMake(0, 230, self.view.frame.size.width, 20)];
    textoInicial.textAlignment = NSTextAlignmentCenter;
    textoInicial.text = @"Abrir dicionario:";
    
    UIButton *botao = [UIButton buttonWithType:UIButtonTypeSystem];
    [botao setTitle:@"A" forState:UIControlStateNormal];
    [botao sizeToFit];
    [botao addTarget:self action:@selector(botaoLetra:) forControlEvents:UIControlEventTouchDown];
    botao.center = self.view.center;
    
    
    //text field e botao para buscar
    textoBusca = [[UITextField alloc]initWithFrame:CGRectMake(10, 70, self.view.frame.size.width - 100, 40)];
    textoBusca.borderStyle = UITextBorderStyleRoundedRect;
    textoBusca.placeholder = @"Busque aqui!";
    textoBusca.delegate = self;
    
    
    botaoBusca = [UIButton buttonWithType:UIButtonTypeSystem];
    [botaoBusca setTitle:@"Pesquisar" forState:UIControlStateNormal];
    [botaoBusca addTarget:self action:@selector(buscar:) forControlEvents:UIControlEventTouchDown];
    botaoBusca.frame = CGRectMake(self.view.frame.size.width-90, 70, 80, 40);
    
    [self.view addSubview:textoInicial];
    [self.view addSubview:botao];
    [self.view addSubview:textoBusca];
    [self.view addSubview:botaoBusca];
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

//metodo de busca
-(void)buscar:(id)sender{
    dss = [DataSourceSingleton instance];
    NSError *erroRegex=nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[a-z]([a-z]| |\\+|\\(|\\)|'|\\^)*$" options:NSRegularExpressionCaseInsensitive error:&erroRegex];
    
    if(![regex numberOfMatchesInString:textoBusca.text options:0 range:NSMakeRange(0, textoBusca.text.length)]){
        UIAlertView *termoInvalido = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Termo inválido!",nil) message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [termoInvalido show];
        return;
    }
    
    BOOL achou = NO;
    NSString *termo = [textoBusca.text lowercaseString];
    for(int i=0; i<26 &&achou==NO;i++){
        NSString *resultado = [[dss buscarPorIndice:i].palavra lowercaseString];
        NSLog(@"%@",resultado);
        if([termo isEqualToString:resultado]){
            achou = YES;
            dss.letra = i;
            LetraViewController *proximo = [[LetraViewController alloc]init];
            self.navigationController.viewControllers = [[NSArray alloc]initWithObjects:[[LetraViewController alloc]init], proximo, [[LetraViewController alloc]init], nil];
            [self.navigationController pushViewController:proximo animated:YES];
            return;
        }
    }
    [UIView animateWithDuration:0.1 animations:^{
        [UIView setAnimationRepeatCount:3.0];
        textoBusca.transform = CGAffineTransformMakeTranslation(5.0, 0.0);
        botaoBusca.transform = CGAffineTransformMakeTranslation(5.0, 0.0);
        
    }];
}


@end
