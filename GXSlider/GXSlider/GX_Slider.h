//
//  GX_Slider.h
//  test
//
//  Created by Pro on 2018/8/24.
//  Copyright © 2018年 Pro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GX_Slider : UIControl
{
    CGFloat _pointX;
    NSInteger _sectionIndex;        //当前选中的那个
    CGFloat _sectionLength;         //根据数组分段后一段的长度
    UILabel *_selectLab;
    UILabel *_leftLab;
    UILabel *_rightLab;
}
@property (nonatomic,assign)CGFloat defaultIndx;

@property (nonatomic,strong)NSArray *titleArray;

@property (nonatomic,strong)NSArray *firstAndLastTitles;

@property (nonatomic,strong)UIImage *sliderImage;

@property (strong,nonatomic)UIView *selectView;
@property (strong,nonatomic)UIView *defaultView;
@property (strong,nonatomic)UIImageView *centerImage;

@property (nonatomic, copy) void(^valueChangedBlock)(NSInteger currentIdx);

/**
 初始化gx_slider

 @param frame frame
 @param itemsTitleArray required 分段节点数组
 @param SideTitles      两头title
 @param defaultIndex 初始位置
 @param passedColor 划过的色条
 @param UnPassColor 未划过的色条
 @param sliderImage sliderImg
 @return gx_slider
 */
- (instancetype)initSliderWithFrame:(CGRect)frame
                        itemsTitles:(NSArray *)itemsTitleArray
                         SideTitles:(NSArray *)SideTitles
                       defaultIndex:(CGFloat)defaultIndex
                        passedColor:(UIColor *)passedColor
                        UnPassColor:(UIColor *)UnPassColor
                        sliderImage:(UIImage *)sliderImage;

@end
