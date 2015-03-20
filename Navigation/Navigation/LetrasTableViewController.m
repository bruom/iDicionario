//
//  LetrasTableViewController.m
//  Navigation
//
//  Created by Bruno Omella Mainieri on 3/18/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import "LetrasTableViewController.h"
#import "DataSourceSingleton.h"
#import "LetraViewController.h"
#import "EntradaDicionario.h"

@interface LetrasTableViewController ()

@end

DataSourceSingleton *dss;
EntradaDicionario *entrada;

@implementation LetrasTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dss = [DataSourceSingleton instance];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    //seria bacana conseguir este valor a partir do result set do realm, vou ver se da depois
    return 26;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"letraCell"];
    
    long row = [indexPath row];
    entrada = [dss buscarPorIndice:(int)row];
    cell.textLabel.text = [NSString stringWithFormat:@"%c",[entrada.palavra characterAtIndex:0]];
    cell.detailTextLabel.text = entrada.palavra;
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", [NSString stringWithFormat:@"%c",[entrada.palavra characterAtIndex:0]]]];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //LetraViewController *viewLetra = [[LetraViewController alloc]init];
    dss.letra = (int)[indexPath row];
    
    //pega a navigation do view controller na outra tab, para evitar
    UINavigationController *navOriginal = [self.tabBarController.viewControllers objectAtIndex:0];
    
    [navOriginal pushViewController:[[LetraViewController alloc]init] animated:YES];
    
    self.tabBarController.selectedIndex = 0;
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
