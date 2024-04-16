//
/**
- Copyright © 2020 dzl. All rights reserved.
- AUthor: Created  by DZL on 2020/2/24
- ICan
- File name:  DZUploadVideoProgressCircleView.m
- Description:
- Function List:
*/
        

#import "DZUploadVideoProgressCircleView.h"
@interface DZUploadVideoProgressCircleView()
@property (nonatomic, weak) UILabel *cLabel;
@end
@implementation DZUploadVideoProgressCircleView
-(void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    //百分比标签
    UILabel *cLabel = [[UILabel alloc] initWithFrame:self.bounds];
    cLabel.font = [UIFont systemFontOfSize:14];
    cLabel.textColor = UIColorThemeMainColor;
    cLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:cLabel];
    self.cLabel = cLabel;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        //百分比标签
        UILabel *cLabel = [[UILabel alloc] initWithFrame:self.bounds];
        cLabel.font = [UIFont systemFontOfSize:14];
        cLabel.textColor = UIColorThemeMainColor;
        cLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:cLabel];
        self.cLabel = cLabel;
    }
    
    return self;
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    
    _cLabel.text = [NSString stringWithFormat:@"%d%%", (int)floor(progress * 100)];
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    //路径
    UIBezierPath *path = [[UIBezierPath alloc] init];
    //线宽
    path.lineWidth = 2;
    //颜色
    [UIColorThemeMainColor set];
    //拐角
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    //半径
    CGFloat radius = (MIN(rect.size.width, rect.size.height) - 2) * 0.5;
    //画弧（参数：中心、半径、起始角度(3点钟方向为0)、结束角度、是否顺时针）
    [path addArcWithCenter:(CGPoint){rect.size.width * 0.5, rect.size.height * 0.5} radius:radius startAngle:M_PI * 1.5 endAngle:M_PI * 1.5 + M_PI * 2 * _progress clockwise:YES];
    //连线
    [path stroke];
}

@end
