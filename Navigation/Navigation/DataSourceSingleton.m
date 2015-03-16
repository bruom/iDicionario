//
//  DataSourceSingleton.m
//  Navigation
//
//  Created by Bruno Omella Mainieri on 3/16/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import "DataSourceSingleton.h"

@implementation DataSourceSingleton

@synthesize palavras;
@synthesize imagens;


static DataSourceSingleton *instance;

-(instancetype)init{
    self = [super init];
    if(self){
        palavras = [NSArray arrayWithObjects: @"Andorra", @"Bruxelas", @"Creta", @"Dublin", @"Edinburgo", @"Freetown", @"Gibraltar", @"Helsinki", @"Islamabad", @"Jerusalem", @"Kiev", @"Londres", @"Monaco", @"Nuuk", @"Oslo", @"Praga", @"Quito", @"Roma", @"Seul", @"Toquio", @"Ulan Bator", @"Viena", @"Warsaw", @"Xangri-la", @"Yerevan", @"Zagreb", nil];
//        imagens = [NSArray arrayWithObjects: @"a.jpg", @"b.jpg", @"c.jpg", @"d.jpg", @"e.jpg", @"f.jpg", @"g.jpg", @"h.jpg", @"i.jpg", @"j.jpg", @"k.jpg", @"l.jpg", @"m.jpg", @"n.jpg", @"o.jpg", @"p.jpg", @"q.jpg", @"r.jpg", @"s.jpg", @"t.jpg", @"u.jpg", @"v.jpg", @"w.jpg", @"x.jpg", @"y.jpg", @"z.jpg", nil];
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


@end
