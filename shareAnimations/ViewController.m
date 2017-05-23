//
//  ViewController.m
//  shareAnimations
//
//  Created by neghao on 2017/5/23.
//  Copyright © 2017年 neghao. All rights reserved.
//

#import "ViewController.h"
#import "shareView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet shareView *shareView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)show:(UIButton *)sender {
    [UIView animateWithDuration:0.5
                          delay:0
         usingSpringWithDamping:1
          initialSpringVelocity:8
                        options:UIViewAnimationOptionTransitionFlipFromBottom
                     animations:^{
                         CGRect newRect = CGRectMake(0,self.view.bounds.size.height - _shareView.bounds.size.height, _shareView.bounds.size.width,  _shareView.bounds.size.height);
                         _shareView.frame = newRect;

                     } completion:^(BOOL finished) {
                         [_shareView beganAnimation];
                     }];
}

- (IBAction)hidden:(UIButton *)sender {
    [UIView animateWithDuration:1.2
                          delay:0
         usingSpringWithDamping:1
          initialSpringVelocity:5
                        options:UIViewAnimationOptionTransitionFlipFromTop
                     animations:^{
                         CGRect newRect = CGRectMake(0, self.view.bounds.size.height, _shareView.bounds.size.width,  _shareView.bounds.size.height);
                         _shareView.frame = newRect;

                     } completion:^(BOOL finished) {
                         [_shareView endAnimation];
                     }];
}


@end
