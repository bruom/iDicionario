//
//  EditViewController.m
//  Navigation
//
//  Created by Bruno Omella Mainieri on 3/19/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import "EditViewController.h"
#import "DataSourceSingleton.h"

@interface EditViewController ()

@end

DataSourceSingleton *dss;
UITextField *texto;
UIImageView *imagem;
UIToolbar *toolbar;

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationItem setHidesBackButton:YES];
    
    dss = [DataSourceSingleton instance];
    
    imagem = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width/2)-100, 80, 200, 200)];
    imagem.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", [NSString stringWithFormat:@"%c",[[dss.palavras objectAtIndex:dss.letra] characterAtIndex:0]]]];
    
    texto = [[UITextField alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 20)];
    texto.text = [NSString stringWithFormat:@"%@", [dss.palavras objectAtIndex:dss.letra]];
    texto.textAlignment = UITextAlignmentCenter;
    [texto setEnabled:YES];
    texto.center = self.view.center;
    
    toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, (self.view.frame.size.height - 90), self.view.frame.size.width, 40)];
    
    UIBarButtonItem *toolBarConfirma = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(confirmar:)];
    
    NSArray *toolBarItems = [NSArray arrayWithObjects:toolBarConfirma, nil];
    [toolbar setItems:toolBarItems];
    
    [self.view addSubview:imagem];
    [self.view addSubview:texto];
    [self.view addSubview:toolbar];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)confirmar:(id)sender{
    NSError *erroRegex=nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[a-z]([a-z]| |\\+|\\(|\\)|'|\\^)*$" options:NSRegularExpressionCaseInsensitive error:&erroRegex];
    
    if(![regex numberOfMatchesInString:texto.text options:0 range:NSMakeRange(0, texto.text.length)]){
        UIAlertView *termoInvalido = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Termo inválido!",nil) message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [termoInvalido show];
        return;
    }
    [dss.palavras replaceObjectAtIndex:dss.letra withObject:texto.text];
    [self.navigationController popViewControllerAnimated:YES];
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
