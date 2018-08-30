//
//  GX_Slider.m
//  test
//
//  Created by Pro on 2018/8/24.
//  Copyright © 2018年 Pro. All rights reserved.
//

#define CenterImage_W   26.0
#define SLiderLine_H    1.0
#define SlideWidth      (self.bounds.size.width)
#define SliderHight     (self.bounds.size.height)
#define SliderTitle_H   (SliderHight * .7)
#define SliderLine_W    (SlideWidth - CenterImage_W)
#define SliderLine_Y    (SliderHight - SliderTitle_H)
#define CenterImage_Y   (SliderLine_Y + (SLiderLine_H/2))

#import "GX_Slider.h"

@implementation GX_Slider

//MARK: - System Life Cycle
- (instancetype)initSliderWithFrame:(CGRect)frame itemsTitles:(NSArray *)itemsTitleArray SideTitles:(NSArray *)SideTitles defaultIndex:(CGFloat)defaultIndex passedColor:(UIColor *)passedColor UnPassColor:(UIColor *)UnPassColor sliderImage:(UIImage *)sliderImage
{
    if (self = [super initWithFrame:frame]) {
        _pointX = 0;
        _sectionIndex = 0;
        
        _defaultView = [[UIView alloc] initWithFrame:CGRectMake(CenterImage_W/2, SliderLine_Y, SlideWidth-CenterImage_W, SLiderLine_H)];
        _defaultView.backgroundColor = UnPassColor;
        _defaultView.layer.cornerRadius = SLiderLine_H/2;
        _defaultView.userInteractionEnabled = NO;
        [self addSubview:_defaultView];
        
        _selectView = [[UIView alloc] initWithFrame:CGRectMake(CenterImage_W/2, SliderLine_Y, SlideWidth-CenterImage_W, SLiderLine_H)];
        _selectView.layer.cornerRadius = SLiderLine_H/2;
        _selectView.userInteractionEnabled = NO;
        [self addSubview:_selectView];
        
        _centerImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CenterImage_W, CenterImage_W)];
        _centerImage.center = CGPointMake(0, CenterImage_Y);
        _centerImage.userInteractionEnabled = NO;
        _centerImage.alpha = .5;
        [self addSubview:_centerImage];
        
        _selectLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 80, 20)];
        _selectLab.textColor = passedColor;
        _selectLab.font = [UIFont systemFontOfSize:12];
        _selectLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_selectLab];
        
        CGFloat itemHeight = _centerImage.bounds.size.height*.5;
        for (int i = 0; i < 11; i++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i*(SlideWidth - CenterImage_W)/10 + CenterImage_W/2, _defaultView.frame.origin.y/2, 1, itemHeight)];
            label.backgroundColor = passedColor;
            [self addSubview:label];
        }
        
        self.titleArray = itemsTitleArray;
        self.defaultIndx = defaultIndex;
        self.firstAndLastTitles = SideTitles;
        self.sliderImage = sliderImage;
    }
    return self;
}

//设置默认位置
- (void)setDefaultIndx:(CGFloat)defaultIndx
{
    CGFloat withPress = defaultIndx/(_titleArray.count - 1);    //初始占比
    CGRect rect = [_selectView frame];
    rect.size.width = withPress * SliderLine_W;
    _selectView.frame = rect;
    _pointX = withPress * SliderLine_W;
    _sectionIndex = defaultIndx;
}

- (void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
    _sectionLength = (SliderLine_W/(titleArray.count - 1));     //每个块的长度
}

- (void)setFirstAndLastTitles:(NSArray *)firstAndLastTitles
{
    _leftLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 80, SliderTitle_H)];
    _leftLab.font = [UIFont systemFontOfSize:12];
    _leftLab.textColor = [UIColor orangeColor];
    _leftLab.text = [firstAndLastTitles firstObject];
    [self addSubview:_leftLab];
    
    _rightLab = [[UILabel alloc] initWithFrame:CGRectMake(SlideWidth - 80, 15, 80, SliderTitle_H)];
    _rightLab.font = [UIFont systemFontOfSize:12];
    _rightLab.textColor = [UIColor orangeColor];
    _rightLab.text = [firstAndLastTitles lastObject];
    _rightLab.textAlignment = 2;
    [self addSubview:_rightLab];
}

- (void)setSliderImage:(UIImage *)sliderImage
{
    _centerImage.image = sliderImage;
    [self refreshSlider];
}
#pragma mark ---UIColor Touchu
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self changePointX:touch];
    _pointX = _sectionIndex * (_sectionLength);
    [self refreshSlider];
    return YES;
}
- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self changePointX:touch];
    [self refreshSlider];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    return YES;
}
- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [self changePointX:touch];
    _pointX = _sectionIndex * (_sectionLength);
    !self.valueChangedBlock ?: self.valueChangedBlock(_sectionIndex);
    [self refreshSlider];
}

- (void)changePointX:(UITouch *)touch
{
    CGPoint point = [touch locationInView:self];
    _pointX = point.x;
    if (point.x < 0) {
        _pointX = CenterImage_W/2;
    }else if (point.x > SliderLine_W){
        _pointX = SliderLine_W + CenterImage_W/2;
    }
    _sectionIndex = (int)roundf(_pointX/_sectionLength);        //roundf计算节点
}

- (void)refreshSlider
{
    _pointX = _pointX + CenterImage_W/2;
    _centerImage.center = CGPointMake(_pointX, CenterImage_Y);
    CGRect rect = [_selectView frame];
    rect.size.width = _pointX - CenterImage_W/2;
    _selectView.frame = rect;
    
    _selectLab.text = [NSString stringWithFormat:@"%@",_titleArray[_sectionIndex]];
    if (_sectionIndex == 0 || _sectionIndex == _titleArray.count-1) {
        _selectLab.center = CGPointMake(_pointX, 55);
    }
    _selectLab.center = CGPointMake(_pointX, 37);
}
@end
