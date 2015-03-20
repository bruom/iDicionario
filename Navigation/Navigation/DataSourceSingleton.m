//
//  DataSourceSingleton.m
//  Navigation
//
//  Created by Bruno Omella Mainieri on 3/16/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import "DataSourceSingleton.h"

@implementation DataSourceSingleton

@synthesize palavras, imagens, realm;

NSUserDefaults *useDef;


static DataSourceSingleton *instance;

-(instancetype)init{
    self = [super init];
    if(self){
        realm = [RLMRealm defaultRealm];
        useDef = [NSUserDefaults standardUserDefaults];
        if([useDef objectForKey:@"primeiraExecucao"]==nil){
            [self preencherRealm];
            [useDef setObject:@"NAO" forKey:@"primeiraExecucao"];
        }
        _letra = 0;
    }
    return self;
}

+(DataSourceSingleton *)instance{
    if(instance == nil){
        instance = [[DataSourceSingleton alloc]init];
    }
    return instance;
}

-(void)preencherRealm{
    palavras = [NSMutableArray arrayWithObjects: @"Andorra", @"Bruxelas", @"Creta", @"Dublin", @"Edinburgo", @"Freetown", @"Gibraltar", @"Helsinki", @"Islamabad", @"Jerusalem", @"Kiev", @"Londres", @"Monaco", @"Nuuk", @"Oslo", @"Praga", @"Quito", @"Roma", @"Seul", @"Toquio", @"Ulan Bator", @"Viena", @"Warsaw", @"Xangri-la", @"Yerevan", @"Zagreb", nil];
    for(int i=0; i<palavras.count;i++){
        EntradaDicionario *entrada = [[EntradaDicionario alloc]init];
        entrada.palavra = [palavras objectAtIndex:i];
        entrada.letraIndex = i;
        entrada.img = [NSString stringWithFormat:@"%@.jpg", [NSString stringWithFormat:@"%c",[[palavras objectAtIndex:i] characterAtIndex:0]]];
        [realm beginWriteTransaction];
        [realm addObject:entrada];
        [realm commitWriteTransaction];
    }
}

-(EntradaDicionario *)buscarPorIndice:(int)i{
    RLMResults *resultados = [EntradaDicionario objectsWhere:[NSString stringWithFormat:@"letraIndex=%d",i]];
    for(EntradaDicionario *resultado in resultados){
        if(resultado.letraIndex == i){
            return resultado;
        }
    }
    return nil;
}

-(void)trocarEmIndice:(int)i porPalavra:(NSString *)palavra{
    RLMResults *resultados = [EntradaDicionario objectsWhere:[NSString stringWithFormat:@"letraIndex=%d",i]];
    for(EntradaDicionario *resultado in resultados){
        if(resultado.letraIndex == i){
            [realm beginWriteTransaction];
            resultado.palavra = palavra;
            [realm commitWriteTransaction];
        }
    }
}

@end
