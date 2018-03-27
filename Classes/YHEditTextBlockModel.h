//
//  TKBaseEditTextBlockModel.h
//  TKBaseModule
//
//  Created by jaki on 2018/3/5.
//  Copyright © 2018年 TicTalk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol YHEditTextBlockModel<JSExport>
@property(nonatomic,assign)NSInteger fontSize;

@property(nonatomic,assign)BOOL isItatic;

@property(nonatomic,assign)float colorR;

@property(nonatomic,assign)float colorG;

@property(nonatomic,assign)float colorB;
@end

@interface YHEditTextBlockModel : NSObject<YHEditTextBlockModel>


@property(nonatomic,assign)BOOL isBlod;

@property(nonatomic,assign)NSInteger fontSize;

@property(nonatomic,assign)BOOL isItatic;

@property(nonatomic,assign)float colorR;

@property(nonatomic,assign)float colorG;

@property(nonatomic,assign)float colorB;

@end
