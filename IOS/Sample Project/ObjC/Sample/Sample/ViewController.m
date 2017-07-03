//
//  ViewController.m
//  Sample
//
//  Created by Hari Shankar on 28/06/17.
//  Copyright © 2017 Hari Shankar. All rights reserved.
//

#import "ViewController.h"
#import "Trova.h"
@interface ViewController (){
    Trova *trova;
}
@end

@implementation ViewController



- (void)viewDidLoad{
    [super viewDidLoad];
    
    trova = [[Trova alloc]init];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"viewControllerIdentifier"];
    
    [trova updateTrovaCurrentViewController:self fromViewController:viewController];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}


- (IBAction)audioBtnTapped:(id)sender {
     [trova makeTrovaAudioCall:@"agentKey"];
}
- (IBAction)videoBtnTapped:(id)sender {
     [trova makeTrovaVideoCall:@"agentKey"];
}
- (IBAction)chatBtnTapped:(id)sender {
     [trova makeTrovaChat:@"agentKey"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
