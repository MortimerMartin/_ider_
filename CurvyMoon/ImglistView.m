//
//  ImglistView.m
//  CurvyMoon
//
//  Created by qingyun on 16/5/12.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ImglistView.h"


@interface ImglistView ()<UIScrollViewDelegate>

@property (nonatomic , strong) UIScrollView *scrollView;

@end
@implementation ImglistView

+ (id)S2ImglistView
{
    return [[self alloc] initWithFrame:CGRectZero];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self createSubViews];
    }
    
    return self;
}

- (void)createSubViews{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    self.scrollView=scrollView;
    
//    imgHView *head = [[NSBundle mainBundle] loadNibNamed:@"imgHView" owner:nil options:nil][0];
//    head.frame = CGRectMake(0, 20, self.frame.size.width, 44);
//    [head.backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    [self.scrollView addSubview:head];
//    self.scrollView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.scrollView];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled=YES;
    self.scrollView.showsHorizontalScrollIndicator=NO;
    self.scrollView.backgroundColor = [UIColor blackColor];
    self.currentindex = 1;


    
    
}


-(void)setImglist:(NSArray *)imglist{
    _imglist = imglist;
    
    for(int i=0;i<imglist.count;i++){
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imglist[i]] placeholderImage:nil];
//        imageView.backgroundColor = [UIColor whiteColor];
        imageView.contentMode=UIViewContentModeScaleAspectFit;
        
        [self.scrollView addSubview:imageView];
    }
    
    
    [self setNeedsLayout];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.scrollView.frame = self.bounds;
//    self.scrollView.frame=CGRectMake(0, 20, self.frame.size.width, self.frame.size.height-20);
    
    NSArray *images = self.scrollView.subviews;
    
    self.scrollView.contentSize=CGSizeMake(self.frame.size.width*images.count, self.frame.size.height);
    self.scrollView.contentOffset=CGPointMake(self.frame.size.width, 0);
    
    for(int i=0;i<images.count;i++){
        UIImageView *view = images[i];
        
        CGFloat imageW = self.scrollView.frame.size.width;
        CGFloat imageH = self.scrollView.frame.size.height;
        
        view.frame=CGRectMake(imageW*i , 0, imageW, imageH);
    }
    
    
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    self.frame=newSuperview.bounds;
}


#pragma mark UI ScrollView delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (self.scrollView.contentOffset.x < self.frame.size.width) {
        
        self.scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
 
            self.currentindex = 2;
        
        
    }
    if(self.scrollView.contentOffset.x > self.frame.size.width * (self.currentindex ) ){
        self.currentindex++;
        
    }else if(self.scrollView.contentOffset.x < self.frame.size.width * (self.currentindex ) ){
        self.currentindex--;
        
        
    }
    
    if (self.CurrentIndex) {
        
        _CurrentIndex(self.currentindex);
    }
}
@end
