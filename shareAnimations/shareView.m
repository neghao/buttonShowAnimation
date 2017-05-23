//
//  shareView.m
//  shareAnimations
//
//  Created by neghao on 2017/5/23.
//  Copyright © 2017年 neghao. All rights reserved.
//

#import "shareView.h"

@interface shareView ()<CAAnimationDelegate>
@property(weak, nonatomic)IBOutlet UIButton *oneBtn;
@property(weak, nonatomic)IBOutlet UIButton *twoBtn;
@property(weak, nonatomic)IBOutlet UIButton *threeBtn;
@property(weak, nonatomic)IBOutlet UIButton *fourBtn;
@property(weak, nonatomic)IBOutlet UIButton *cancelBtn;
@property(strong, nonatomic)NSMutableArray *positions;
//动画是否完成，防止显示后再次点击时还重复执行动画
@property(assign, nonatomic)BOOL completeAnimation;
@end

@implementation shareView
- (NSMutableArray *)positions {
    if (!_positions) {
        _positions = [[NSMutableArray alloc] init];
    }
    return _positions;
}

- (instancetype)loadShareView {
   return [[NSBundle mainBundle] loadNibNamed:@"shareView" owner:nil options:nil].firstObject;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self endAnimation];
    [self.positions addObject:[self createKeyAnimation:_oneBtn.center obj:_oneBtn]];
    [self.positions addObject:[self createKeyAnimation:_twoBtn.center obj:_twoBtn]];
    [self.positions addObject:[self createKeyAnimation:_threeBtn.center obj:_threeBtn]];
    [self.positions addObject:[self createKeyAnimation:_fourBtn.center obj:_fourBtn]];
}

- (CGPoint)nh_point:(NSInteger)tag {
    int     count = 4;
    CGFloat tw = self.bounds.size.width;
    CGFloat wh = _oneBtn.bounds.size.width;
    CGFloat x = 20;
    CGFloat y = (tw - (count * wh)) / (count+1) * tag;
    CGFloat radius = wh / 2;
    CGPoint point = CGPointMake(x + radius, y + radius);
    return point;
}

- (CAKeyframeAnimation *)createKeyAnimation:(CGPoint)point obj:(UIButton *)obj{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _cancelBtn.frame.origin.x, _cancelBtn.frame.origin.y);
    CGPathAddLineToPoint(path, NULL, point.x, point.y);
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animation];
    keyAnimation.keyPath = @"position";
    [keyAnimation setPath:path];
    keyAnimation.duration = 0.3;
    keyAnimation.speed = 5;
    keyAnimation.fillMode = kCAFillModeForwards;
    keyAnimation.removedOnCompletion = NO;
    keyAnimation.delegate = self;
    [keyAnimation setValue:obj forKey:@"obj"];
    CGPathRelease(path);
    return keyAnimation;
}

- (void)beganAnimation {
    if (_completeAnimation) return;
    
    _oneBtn.hidden = NO;
    _twoBtn.hidden = NO;
    _threeBtn.hidden = NO;
    _fourBtn.hidden = NO;
    [self setHidden:NO];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    CAKeyframeAnimation *keyAnimation = (CAKeyframeAnimation *)anim;
    UIButton *obj = [keyAnimation valueForKey:@"obj"];

    if (obj == _oneBtn) {
        [_oneBtn.layer removeAllAnimations];
        [_twoBtn.layer addAnimation:[_positions objectAtIndex:_twoBtn.tag -1] forKey:@"move2"];

    } else if (obj == _twoBtn) {
        [_twoBtn.layer removeAllAnimations];
        [_threeBtn.layer addAnimation:[_positions objectAtIndex:_threeBtn.tag -1] forKey:@"move3"];

    }  else if (obj == _threeBtn) {
        [_threeBtn.layer removeAllAnimations];
        [_fourBtn.layer addAnimation:[_positions objectAtIndex:_fourBtn.tag -1] forKey:@"move4"];

    } else if (obj == _fourBtn) {
        [_fourBtn.layer removeAllAnimations];
        _completeAnimation = YES;
        
    }
}


- (void)endAnimation {
    [_oneBtn.layer addAnimation:[self createKeyAnimation:_cancelBtn.center obj:_cancelBtn] forKey:@"1"];
    [_twoBtn.layer addAnimation:[self createKeyAnimation:_cancelBtn.center obj:_cancelBtn] forKey:@"2"];
    [_threeBtn.layer addAnimation:[self createKeyAnimation:_cancelBtn.center obj:_cancelBtn] forKey:@"3"];
    [_fourBtn.layer addAnimation:[self createKeyAnimation:_cancelBtn.center obj:_cancelBtn] forKey:@"4"];
    _oneBtn.hidden = YES;
    _twoBtn.hidden = YES;
    _threeBtn.hidden = YES;
    _fourBtn.hidden = YES;
    _completeAnimation = NO;

}

- (void)setHidden:(BOOL)hidden {
    [super setHidden:hidden];

    if (hidden) {
        [self endAnimation];

    } else {
        [_oneBtn.layer addAnimation:[_positions objectAtIndex:_oneBtn.tag -1] forKey:@"move1"];
    }
}



- (IBAction)selectorBtn:(UIButton *)sender {
    NSLog(@"%ld",sender.tag);
    
    if (sender.tag == 5) {
        [self setHidden:YES];
    }
    //    [_oneBtn.layer addAnimation:[self createKeyAnimation:[self nh_point:_oneBtn.tag] obj:_oneBtn] forKey:@""];
    //    [_twoBtn.layer addAnimation:[self createKeyAnimation:[self nh_point:_twoBtn.tag] obj:_twoBtn] forKey:@""];
    //    [_threeBtn.layer addAnimation:[self createKeyAnimation:[self nh_point:_threeBtn.tag] obj:_threeBtn] forKey:@""];
    //    [_fourBtn.layer addAnimation:[self createKeyAnimation:[self nh_point:_fourBtn.tag] obj:_fourBtn] forKey:@""];
}
@end
