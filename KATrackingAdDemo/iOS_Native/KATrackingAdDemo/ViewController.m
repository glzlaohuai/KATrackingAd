//
//  ViewController.m
//  AppicSDKSample
//
//  Created by Jason Y Liu on 15/11/2017.
//  Copyright © 2017 AppicPlay. All rights reserved.
//

#import "ViewController.h"
#import "NativeAdController.h"
#import "AdCell.h"

@interface ViewController ()

@property (nonatomic, strong) KAAdSplash *splash;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.slot_dic = [NSDictionary dictionaryWithObjectsAndKeys:
                     @"Video",
                     @"Incentivized",
                     @"DlGdpoGq",
                     @"Interstitial",
                     @"naArbAbz",
                     @"Native",
                     @"bPmPrQGq",
                     @"Splash",
                     nil];
    
//    self.splash = [[KAAdSplash alloc] initWithSlot:@"XqmJPMGw" delegate:self];
//    [self.splash loadAndPresentWithViewController:self];
}

- (BOOL) prefersStatusBarHidden{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.slot_dic count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"ka_ad_test_cell";
    AdCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    NSString *slot = [[self.slot_dic allValues] objectAtIndex:indexPath.row];
    NSString *name = [[self.slot_dic allKeys] objectAtIndex:indexPath.row];
    if(!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AdCellView" owner:nil options:nil] objectAtIndex:0];
        cell.frame = CGRectMake(0,0,tableView.frame.size.width,cell.frame.size.height);
        [cell setupWithSlot:slot andName:name];
    }else{
        [cell setupWithSlot:slot andName:name];
    }
    return cell;
}

- (void) splashAdSuccessPresentScreen:(nonnull KAAdSplash *)splashAd{
    NSLog(@"Splash present success");
}

/**
 * Splash ad request failed with slot and error describing the reason
 */
- (void) splashAdFailToPresent:(nonnull NSString *)splashAdSlot
                     withError:(nonnull NSError *)error{
    NSLog(@"Splash present fail, error = %@", error);
}

/**
 * Splash ad has been clicked
 */
- (void) splashDidClick:(KAAdSplash *)splashAd{
    NSLog(@"Splash clicked");
}

/**
 * Splash ad has been dismissed
 */
- (void) splashDidDismiss:(KAAdSplash *)splashAd;{
    NSLog(@"Splash dismissed");
}
@end
