//
//  TKEditView.m
//  TKBaseModule
//
//  Created by jaki on 2018/3/5.
//  Copyright © 2018年 TicTalk. All rights reserved.
//

#import "YHEditView.h"
#import <Masonry/Masonry.h>
#import <JavaScriptCore/JavaScriptCore.h>
@interface YHEditView()<UIWebViewDelegate>

@property(nonatomic,strong)UIWebView * webView;

@property(nonatomic,strong)NSBundle * bundle;

@property(nonatomic,strong)JSContext * jsContext;

@property(nonatomic,strong)void(^callback)(YHEditTextBlockModel *);

@property(nonatomic,strong)YHEditTextBlockModel * currentModel;

@end

@implementation YHEditView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self installUI];
    }
    return self;
}


-(void)installUI{
    [self addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
}

-(void)setCurrentTextBlockPorpertyChangeCallback:(void (^)(YHEditTextBlockModel *))callback{
    self.callback = callback;
}

-(void)setCurrentBold:(BOOL)isBold{
    [self.jsContext evaluateScript:[NSString stringWithFormat:@"setBold(%@)",isBold?@"true":@"false"]];
    if (isBold) {
        self.currentModel.isBlod = YES;
    }else{
        self.currentModel.isBlod = NO;
    }
    if (self.callback) {
        self.callback(self.currentModel);
    }
}

-(void)setCurrentFontSize:(NSUInteger)size{
    [self.jsContext evaluateScript:[NSString stringWithFormat:@"setFontSize(%lu)",size]];
    self.currentModel.fontSize = size;
    if (self.callback) {
        self.callback(self.currentModel);
    }
}

-(void)setCurrentItatic:(BOOL)isItatic{
    [self.jsContext evaluateScript:[NSString stringWithFormat:@"setItatic(%@)",isItatic?@"true":@"false"]];
    if (isItatic) {
        self.currentModel.isItatic = YES;
    }else{
        self.currentModel.isItatic = NO;
    }
    if (self.callback) {
        self.callback(self.currentModel);
    }
}


-(void)setCurrentColorR:(float)r G:(float)g B:(float)b{
    NSString * colorStr = [NSString stringWithFormat:@"setColor(%f,%f,%f)",r*255,g*255,b*255];
    [self.jsContext evaluateScript:colorStr];
    self.currentModel.colorR = r;
    self.currentModel.colorB = b;
    self.currentModel.colorG = g;
    if (self.callback) {
        self.callback(self.currentModel);
    }
}

-(void)insertImage:(NSString *)imgUrl{
     [self.jsContext evaluateScript:[NSString stringWithFormat:@"addImage('%@')",imgUrl]];
}

#pragma mark - webView delegate
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    void(^block)(NSString * fontWeigth,NSString* fontSize,NSString* fontStyle,NSString *color) = ^(NSString * fontWeigth,NSString * fontSize,NSString* fontStyle,NSString *color){
        NSLog(@"%@,%@,%@,%@",fontWeigth,fontStyle,color,fontSize);
    };
    [self.jsContext setObject:block forKeyedSubscript:@"oc_focus"];
}


#pragma mark - Setter and Getter
-(UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc]init];
        NSData * data = [NSData dataWithContentsOfFile:[self.bundle pathForResource:@"TKEditViewHTML" ofType:@"html"]];
        NSString * string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        [_webView loadHTMLString:string baseURL:nil];
        _webView.scrollView.bounces = NO;
        _webView.delegate = self;
    }
    return _webView;
}

-(NSBundle *)bundle{
    if (!_bundle) {
        _bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"TKBaseModuleBundle" ofType:@"bundle"]];
    }
    return _bundle;
}

-(YHEditTextBlockModel *)currentModel{
    if (!_currentModel) {
        _currentModel = [[YHEditTextBlockModel alloc]init];
    }
    return _currentModel;
}

@end
