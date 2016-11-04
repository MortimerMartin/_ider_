//
//  GradienProgressView.m
//  CurvyMoon
//
//  Created by pro on 16/10/7.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "GradienProgressView.h"
#import "UIColor+Hex.h"
@interface GradienProgressView ()

@property (nonatomic) CALayer * layer_d;

@property(nonatomic)CAGradientLayer * gradientlayer1,*gradientlayer2;

@property(nonatomic)NSArray * array1,*array2;

@property(nonatomic)CAShapeLayer * shapelayer;

@end
@implementation GradienProgressView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
//        CAGradientLayer *layer = (id)[self layer];
//        [layer setStartPoint:CGPointMake(0.0, 0.5)];
//        [layer setEndPoint:CGPointMake(1.0, 0.5)];
        
        // Create the gradient colors using hues in 5 degree increments
        
//        NSMutableArray *colors = [NSMutableArray array];
//        for (NSInteger deg = 0; deg <= 360; deg += 5) {
//            
//            UIColor *color;
//            color = [UIColor colorWithHue:1.0 * deg / 360.0//色调
//                               saturation:1.0//饱和度
//                               brightness:1.0//亮度
//                                    alpha:1.0];
//            [colors addObject:(id)[color CGColor]];
//        }
//        [layer setColors:[NSArray arrayWithArray:colors]];
        
//        [layer setColors:[NSArray arrayWithArray:colors]];
        
        // Create another layer to use as a mask. The width of this layer will
        // be modified to reflect the current progress value.
        
//        self.backgroundColor = [UIColor clearColor];
 
//        [self insertColors];
        
        
        //CAGradienLayer 实现渐变
        // 1. colors  简便的颜色
        // 2. locations  渐变颜色的分割线
        // 3. startPoing&endPoint  颜色渐变的方向，范围在（0，0）和（1，0，1，0）之间如（00）（100）代表水平方向渐变 00，010代表竖直方向渐变
        
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor yellowColor].CGColor, (__bridge id)[UIColor blueColor].CGColor];
        gradientLayer.locations = @[@0.3, @0.5, @1.0];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1.0, 0);
        gradientLayer.frame = self.frame;
        self.gradienlayer = gradientLayer;
        [self.layer addSublayer:self.gradienlayer];
        
    }
    return self;
}


- (void)insertColors{

    _gradientlayer1 = [CAGradientLayer layer];
    _gradientlayer2 = [CAGradientLayer layer];
    
    //渐变范围
    _gradientlayer1.startPoint = CGPointMake(0, 0);
    _gradientlayer1.endPoint = CGPointMake(0, 1);
    _gradientlayer2.startPoint = CGPointMake(1, 0);
    _gradientlayer2.endPoint = CGPointMake(1, 1);
    
    
    _array1 = [NSArray arrayWithObjects:(id)[[UIColor colorWithHex:0xabfd49] CGColor],(id)[[UIColor colorWithHex:0xfbfb3b] CGColor],(id)[[UIColor colorWithHex:0xfc683a] CGColor], nil];
    _array2 = [NSArray arrayWithObjects:(id)[[UIColor colorWithHex:0xabfd49]  CGColor],(id)[[UIColor colorWithHex:0x0bb72b] CGColor], nil];
    _gradientlayer1.locations = @[@(0.1),@(0.3),@(0.6)];
    
    //渐变开始
    _gradientlayer1.colors = _array1;
    _gradientlayer2.colors = _array2;
    
    //将渐变层合并一个层，方便控制
    _layer_d = [CALayer layer];
    [_layer_d insertSublayer:_gradientlayer1 atIndex:0];
    [_layer_d insertSublayer:_gradientlayer2 atIndex:0];
    
    
    //设置蒙板
    _shapelayer = [CAShapeLayer layer];
    
    _shapelayer.fillColor = [[UIColor clearColor]CGColor];
    _shapelayer.strokeColor = [[UIColor redColor] CGColor];
    _shapelayer.backgroundColor = [[UIColor clearColor] CGColor];
    _shapelayer.lineJoin = kCALineJoinRound;
    _shapelayer.lineCap = kCALineCapRound;
    _shapelayer.frame = CGRectMake(0, 0, 0, 0);


}


- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    
    _gradientlayer1.frame = self.frame;
    _gradientlayer2.frame = self.frame;
    
    _layer_d.frame = rect;
    
    _shapelayer.lineWidth = 3;
    
    
    
    [_layer_d setMask:_shapelayer];
    
    [self.layer addSublayer:_layer_d];
    
}

@end
