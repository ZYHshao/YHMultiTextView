//
//  TKEditView.h
//  TKBaseModule
//
//  Created by jaki on 2018/3/5.
//  Copyright © 2018年 TicTalk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHEditTextBlockModel.h"
@interface YHEditView : UIView

-(void)setCurrentTextBlockPorpertyChangeCallback:(void(^)(YHEditTextBlockModel * model))callback;

-(void)setCurrentBold:(BOOL)isBold;

-(void)setCurrentFontSize:(NSUInteger)size;

-(void)setCurrentItatic:(BOOL)isItatic;

-(void)setCurrentColorR:(float)r G:(float)g B:(float)b;

-(void)insertImage:(NSString *)imgUrl;

@end
