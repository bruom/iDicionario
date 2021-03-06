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

@synthesize imagem, texto, data, entrada;

DataSourceSingleton *dss;

UIToolbar *toolbar;
UIBarButtonItem *toolBarEdit;
NSDateFormatter *formatoData;

-(void) viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setHidesBackButton:YES];
    
    dss = [DataSourceSingleton instance];
    entrada = [dss buscarPorIndice:dss.letra];
    
    //self.navigationItem.title = [NSString stringWithFormat:@"%c",[[dss.palavras objectAtIndex:dss.letra] characterAtIndex:0]];
    //TENTANDO COM REALM
    self.navigationItem.title = [NSString stringWithFormat:@"%c",[entrada.palavra characterAtIndex:0]];
    
    
    //botoes do Navigation
    UIBarButtonItem *next = [[UIBarButtonItem alloc]
                             initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(next:)];
    self.navigationItem.rightBarButtonItem=next;
    
    
    UIBarButtonItem *prev  = [[UIBarButtonItem alloc]
                             initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(prev:)];
    self.navigationItem.leftBarButtonItem=prev;
    
    
    //imagem
    imagem = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width/2)-100, 80, 200, 200)];
    imagem.image = [UIImage imageNamed: [NSString stringWithFormat:@"%@",[dss buscarPorIndice:dss.letra].img]];
    imagem.userInteractionEnabled = YES;
    imagem.layer.cornerRadius = 100;
    imagem.layer.masksToBounds = YES;
    
    UILongPressGestureRecognizer *toqueImagem = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(toqueImagemHandler:)];
    [self.imagem addGestureRecognizer:toqueImagem];
    UIPinchGestureRecognizer *pinchImagem = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchHandler:)];
    [self.imagem addGestureRecognizer:pinchImagem];
    
    //labels - palavra e data
    texto = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 20)];
    texto.text = [NSString stringWithFormat:@"%@", entrada.palavra];
    texto.textAlignment = NSTextAlignmentCenter;
    texto.center = self.view.center;
    
    formatoData = [[NSDateFormatter alloc]init];
    formatoData.dateStyle = NSDateIntervalFormatterMediumStyle;
    formatoData.locale = [NSLocale currentLocale];
    
    data = [[UILabel alloc]initWithFrame:CGRectMake(0, 350, self.view.frame.size.width, 20)];
    data.text = [NSString stringWithFormat:@"%@", [formatoData stringFromDate:entrada.data]];
    data.textAlignment = NSTextAlignmentCenter;
    
    //toolbar e items
    toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, (self.view.frame.size.height - 90), self.view.frame.size.width, 40)];
    
    toolBarEdit = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editar:)];
   
    NSArray *toolBarItems = [NSArray arrayWithObjects:toolBarEdit, nil];
    [toolbar setItems:toolBarItems];
    
    
    //add subviews
    [self.view addSubview:toolbar];
    [self.view addSubview:texto];
    [self.view addSubview:data];
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
    
    [UIView animateWithDuration:1.0 animations:^{
        imagem.transform = CGAffineTransformMakeScale(1.0, 1.0);
        texto.transform = CGAffineTransformMakeTranslation(0.0, 20.0);
        data.transform = CGAffineTransformMakeTranslation(0.0, 0.0);
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
        data.transform = CGAffineTransformMakeTranslation(0.0, 1000.0);
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
        data.transform = CGAffineTransformMakeTranslation(0.0, 1000.0);
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


//metodo chamado quando a imagem recebe um longPress
//da "zoom"na imagem, afasta as labels para acompanhar e fala o conteúdo da label "texto"
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
            data.transform = CGAffineTransformMakeTranslation(0.0, 80.0);
        }];
    
    //volta tudo pro lugar
    }else if(touch.state == UIGestureRecognizerStateEnded){
        [UIView animateWithDuration:0.4 animations:^{
            imagem. transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.0, 1.0), CGAffineTransformMakeTranslation(0.0, 0.0));
            texto.transform = CGAffineTransformMakeTranslation(0.0, 20.0);
            data.transform = CGAffineTransformMakeTranslation(0.0, 0.0);
        }];
    }
    
}


//metodo para arrastar a imagem
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    //deve ter um jeito de especificar ja a subview aqui... parece pouco eficiente deste jeito...
    UITouch *toque = [touches anyObject];
    
    //verifica se tocou na imagem... ainda acho que existe jeito melhor
    if([toque.view isEqual:imagem]){
        toque.view.center = [toque locationInView:self.view];
    }
}

//pinch para dar resize
//surpreentemente simples (graças a deus)
- (IBAction)pinchHandler:(UIPinchGestureRecognizer *)pinch {
    pinch.view.transform = CGAffineTransformScale(pinch.view.transform, pinch.scale, pinch.scale);
    pinch.scale = 1;
}

-(void)editar:(id)sender{
    EditViewController *evc = [[EditViewController alloc]init];
    [self.navigationController pushViewController:evc animated:YES];
}

-(void)atualizaConteudo{
    imagem.image = [UIImage imageNamed: [NSString stringWithFormat:@"%@",[dss buscarPorIndice:dss.letra].img]];
    [texto setText: entrada.palavra];
    formatoData = [[NSDateFormatter alloc]init];
    formatoData.dateStyle = NSDateIntervalFormatterMediumStyle;
    formatoData.locale = [NSLocale currentLocale];
    data.text = [NSString stringWithFormat:@"%@", [formatoData stringFromDate:entrada.data]];
    self.navigationItem.title = [NSString stringWithFormat:@"%c",[entrada.palavra characterAtIndex:0]];
}


@end
