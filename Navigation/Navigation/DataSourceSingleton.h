//
//  DataSourceSingleton.h
//  Navigation
//
//  Created by Bruno Omella Mainieri on 3/16/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "EntradaDicionario.h"

@interface DataSourceSingleton : NSObject

@property NSMutableArray *palavras;
@property NSMutableArray *imagens;
@property int letra;
@property RLMRealm *realm;

+(DataSourceSingleton *)instance;

-(void)trocarEmIndice:(int)i porPalavra:(NSString*)palavra;

-(EntradaDicionario *)buscarPorIndice:(int)i;

@end
