//
//  DataSourceSingleton.h
//  Navigation
//
//  Created by Bruno Omella Mainieri on 3/16/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataSourceSingleton : NSObject

@property NSArray *palavras;
@property NSArray *imagens;
@property int letra;

+(DataSourceSingleton *)instance;

@end
