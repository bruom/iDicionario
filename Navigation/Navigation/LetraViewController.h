//
//  LetraViewController.h
//  Navigation
//
//  Created by Bruno Omella Mainieri on 3/16/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "EntradaDicionario.h"

@interface LetraViewController : UIViewController

@property UIImageView *imagem;
@property (strong) UILabel *texto;
@property (strong) EntradaDicionario *entrada;

@end
