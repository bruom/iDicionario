//
//  EntradaDicionario.h
//  Navigation
//
//  Created by Bruno Omella Mainieri on 3/20/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface EntradaDicionario : RLMObject

@property int letraIndex;
@property NSString *palavra;
@property NSString *img;

@end
