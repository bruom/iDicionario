//
//  LetraViewController.m
//  Navigation
//
//  Created by Bruno Omella Mainieri on 3/16/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import "LetraViewController.h"
#import "DataSourceSingleton.h"
#import "EditViewController.h"

@interface LetraViewController ()

@end

@implementation LetraViewController

@synthesize imagem;
@synthesize texto;

DataSourceSingleton *dss;

UIToolbar *toolbar;
UIBarButtonItem *toolBarEdit;

-(void) viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Letra load");
    //self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor orangeColor];
    [self.navigationItem setHidesBackButton:YES];
    
    dss = [DataSourceSingleton instance];
    NSLog(@"%d", dss.letra);
    
    self.navigationItem.title = [NSString stringWithFormat:@"%c",[[dss.palavras objectAtIndex:dss.letra] characterAtIndex:0]];
    
    UIBarButtonItem *next = [[UIBarButtonItem alloc]
                             initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(next:)];
    self.navigationItem.rightBarButtonItem=next;
    
    
    UIBarButtonItem *prev  = [[UIBarButtonItem alloc]
                             initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(prev:)];
    self.navigationItem.leftBarButtonItem=prev;
    
    
    imagem = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width/2)-100, 80, 200, 200)];
    imagem.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", [NSString stringWithFormat:@"%c",[[dss.palavras objectAtIndex:dss.letra] characterAtIndex:0]]]];
    imagem.userInteractionEnabled = YES;
    imagem.layer.cornerRadius = 100;
    imagem.layer.masksToBounds = YES;
    
    UILongPressGestureRecognizer *toqueImagem = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(toqueImagemHandler:)];
    [self.imagem addGestureRecognizer:toqueImagem];
    
//    botao = [UIButton
//                       buttonWithType:UIButtonTypeSystem];
//    [botao
//     //setTitle:@"Mostre uma palavra, uma figura e leia a palavra ao apertar um botao"
//     setTitle: [NSString stringWithFormat:@"%@", [dss.palavras objectAtIndex:dss.letra]]
//     forState:UIControlStateNormal];
//    [botao sizeToFit];
//    botao.center = self.view.center;
    
    texto = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 20)];
    texto.text = [NSString stringWithFormat:@"%@", [dss.palavras objectAtIndex:dss.letra]];
    texto.textAlignment = UITextAlignmentCenter;
    texto.center = self.view.center;
    
    toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, (self.view.frame.size.height - 90), self.view.frame.size.width, 40)];
    
    toolBarEdit = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editar:)];
   
    NSArray *toolBarItems = [NSArray arrayWithObjects:toolBarEdit, nil];
    [toolbar setItems:toolBarItems];
    
    
    
    [self.view addSubview:toolbar];
    [self.view addSubview:texto];
    [self.view addSubview:imagem];
    
    
}

-(void) viewWillAppear:(BOOL)animated{
    texto.center = self.view.center;
    [self atualizaConteudo];
    self.navigationItem.leftBarButtonItem.enabled = NO;
    self.navigationItem.rightBarButtonItem.enabled = NO;
    imagem.transform = CGAffineTransformMakeScale(0.5, 0.5);
    
    
}

-(void) viewDidAppear:(BOOL)animated{
    
    NSLog(@"appear %d", dss.letra);
    [UIView animateWithDuration:1.0 animations:^{
        imagem.transform = CGAffineTransformMakeScale(1.0, 1.0);
        texto.transform = CGAffineTransformMakeTranslation(0.0, 20.0);
    }completion:^(BOOL finished) {
        self.navigationItem.leftBarButtonItem.enabled = YES;
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)next:(id)sender {
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.navigationItem.leftBarButtonItem.enabled = NO;
    dss = [DataSourceSingleton instance];
    dss.letra++;
    if(dss.letra>25)
        dss.letra=0;
    
    
    [UIView animateWithDuration:1.0 animations:^{
        imagem.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
        texto.transform = CGAffineTransformMakeTranslation(0.0, 1000.0);
    } completion:^(BOOL finished) {

        LetraViewController *proximo = [[LetraViewController alloc]init];
        if(self.navigationController.viewControllers.count >= 3){
            //[self.navigationController popViewControllerAnimated:YES];
            [self.navigationController pushViewController:proximo animated:YES];
            self.navigationController.viewControllers = [[NSArray alloc ]initWithObjects:[[LetraViewController alloc]init], [self.navigationController.viewControllers objectAtIndex:0], [self.navigationController.viewControllers objectAtIndex:1], nil];
        }
        else{
            self.navigationController.viewControllers = [[NSArray alloc ]initWithObjects:[[LetraViewController alloc]init], [self.navigationController.viewControllers objectAtIndex:1], nil];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    
}

-(void)prev:(id)sender {
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.navigationItem.leftBarButtonItem.enabled = NO;
    dss = [DataSourceSingleton instance];
    dss.letra--;
    if(dss.letra<0)
        dss.letra=25;
    

    [UIView animateWithDuration:1.0 animations:^{
        imagem.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
        texto.transform = CGAffineTransformMakeTranslation(0.0, 1000.0);
    } completion:^(BOOL finished) {
        if(self.navigationController.viewControllers.count >= 3){
            [self.navigationController popViewControllerAnimated:YES];
            self.navigationController.viewControllers = [[NSArray alloc ]initWithObjects:[[LetraViewController alloc]init], [self.navigationController.viewControllers objectAtIndex:0], [self.navigationController.viewControllers objectAtIndex:1], nil];
        }
        else{
            self.navigationController.viewControllers = [[NSArray alloc ]initWithObjects:[[LetraViewController alloc]init], [self.navigationController.viewControllers objectAtIndex:1], nil];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

-(void)toqueImagemHandler:(UILongPressGestureRecognizer *)touch{
    dss = [DataSourceSingleton instance];
    if(touch.state == UIGestureRecognizerStateBegan){
        [UIView animateWithDuration:0.4 animations:^{
            
            AVSpeechSynthesizer *synthesizer = [[AVSpeechSynthesizer alloc]init];
            AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:texto.text];
            [utterance setPitchMultiplier:0.9f];
            utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"pt-BR"];
            [utterance setRate:0.03f];
            [synthesizer speakUtterance:utterance];
            imagem. transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.5, 1.5), CGAffineTransformMakeTranslation(0.0, 50.0));
            texto.transform = CGAffineTransformMakeTranslation(0.0, 110.0);
        }];
    }else if(touch.state == UIGestureRecognizerStateEnded){
        [UIView animateWithDuration:0.4 animations:^{
            imagem. transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.0, 1.0), CGAffineTransformMakeTranslation(0.0, 0.0));
            texto.transform = CGAffineTransformMakeTranslation(0.0, 20.0);
        }];
    }
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    //deve ter um jeito de especificar ja a subview aqui... parece pouco eficiente deste jeito...
    UITouch *toque = [touches anyObject];
    
    //verifica se tocou na imagem... ainda acho que existe jeito melhor
    if([toque.view isEqual:imagem]){
        toque.view.center = [toque locationInView:self.view];
    }
}

-(void)editar:(id)sender{
//    [texto setEnabled:YES];
//    [texto setSelected:YES];
    EditViewController *evc = [[EditViewController alloc]init];
    [self.navigationController pushViewController:evc animated:YES];
}

-(void)atualizaConteudo{
    imagem.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", [NSString stringWithFormat:@"%c",[[dss.palavras objectAtIndex:dss.letra] characterAtIndex:0]]]];
    NSLog(@"%d %@", dss.letra, [dss.palavras objectAtIndex:dss.letra]);
    [texto setText: [dss.palavras objectAtIndex:dss.letra ]];
    
    self.navigationItem.title = [NSString stringWithFormat:@"%c",[[dss.palavras objectAtIndex:dss.letra] characterAtIndex:0]];
}


@end
