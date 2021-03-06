//
//  EditViewController.m
//  Navigation
//
//  Created by Bruno Omella Mainieri on 3/19/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import "EditViewController.h"
#import "DataSourceSingleton.h"
#import "EntradaDicionario.h"

@interface EditViewController ()

@end


DataSourceSingleton *dss;
EntradaDicionario *entrada;


@implementation EditViewController

@synthesize texto, imagem, imagePicker, datePicker, toolbar;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationItem setHidesBackButton:YES];
    
    //imagepicker
    imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    
    //objeto date picker - modeDate indica que recebe apenas dia, mes e ano
    datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 300, 0, 0)];
    //o date picker nao aceita redimensionamento via frame, mas funciona com transform
    datePicker.transform = CGAffineTransformMakeScale(0.8, 0.8);
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    //como a data salva contem apenas dia, mes ano, nao é possível inicializar o datePicker a partir deste objeto. seria necessario trata-lo antes
    //[datePicker setDate:entrada.data animated:YES];
    
    dss = [DataSourceSingleton instance];
    entrada = [dss buscarPorIndice:dss.letra];
    
    imagem = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width/2)-100, 80, 200, 200)];
    imagem.image = [UIImage imageNamed: [NSString stringWithFormat:@"%@",[dss buscarPorIndice:dss.letra].img]];
    
    texto = [[UITextField alloc]initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 20)];
    texto.text = [NSString stringWithFormat:@"%@", entrada.palavra];
    texto.textAlignment = NSTextAlignmentCenter;
    [texto setEnabled:YES];
    
    
    
    //toolbar e seus items
    toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, (self.view.frame.size.height - 90), self.view.frame.size.width, 40)];
    
    UIBarButtonItem *toolBarConfirma = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(confirmar:)];
    
    UIBarButtonItem *picturePicker = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(imagePick:)];
    
    //para espaçar igualmente os items
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    NSArray *toolBarItems = [NSArray arrayWithObjects:spacer, toolBarConfirma, spacer, picturePicker, spacer, nil];
    [toolbar setItems:toolBarItems];
    
    //[texto becomeFirstResponder];
    
    //adicionando subviews
    [self.view addSubview:imagem];
    [self.view addSubview:texto];
    [self.view addSubview:toolbar];
    [self.view addSubview:datePicker];
    
    
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
    //Agora feito por Realm! Mudanças persistem!
    [dss trocarEmIndice:dss.letra porPalavra:texto.text];
    [dss trocarEmIndice:dss.letra porData:datePicker.date];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [texto resignFirstResponder];
}

-(void)imagePick:(id)sender{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else{
        UIAlertView *noCamera = [[UIAlertView alloc]initWithTitle:@"Opa!" message:@"Este dispositivo nao tem camera." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [noCamera show];
    }
    [self presentViewController:imagePicker animated:YES completion:nil];
}

//salva a imagem na EntradaDicionario correspondente
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [imagePicker dismissViewControllerAnimated:YES completion:nil];
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    [dss salvarFoto:img comNome:[NSString stringWithFormat:@"nova_%c", dss.letra ] eLetra:dss.letra];
    imagem.image = [UIImage imageNamed: [NSString stringWithFormat:@"%@",[dss buscarPorIndice:dss.letra].img]];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [imagePicker dismissViewControllerAnimated:YES completion:nil];
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
