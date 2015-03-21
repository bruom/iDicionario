//
//  EntradaDicionario.m
//  Navigation
//
//  Created by Bruno Omella Mainieri on 3/20/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import "EntradaDicionario.h"

@implementation EntradaDicionario


//por default, as entradas sao criadas com a data atual (isso vai servir para colocar a data da instalacao do app nas paginas nao editadas)
-(instancetype)init{
    self = [super init];
    
    if(self){
        _data = [NSDate date];
    }
    return self;
}

@end
