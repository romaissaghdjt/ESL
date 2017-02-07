//
//  ESLEvaluateCell.m
//  ESL
//
//  Created by 徐恒 on 12/11/16.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLEvaluateCell.h"

@interface ESLEvaluateCell()<UITextViewDelegate>

@end

@implementation ESLEvaluateCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)layoutSubviews
{
    self.summeryTV.delegate = self;

    //NSLog(@"走这里%ld",(long)self.indexPath.section);
   // self.cellindexPathBlock(self.indexPath);
   

}
- (void)setSmodle:(MyOrederSubModel *)smodle
{
    if ([smodle.IsEvaluate isEqualToString:@"已评价"]) {
        self.sumbitBnt.enabled = NO;
        self.sumbitBnt.layer.borderColor = [UIColor grayColor].CGColor;
        [self.sumbitBnt setTitle:@"已评价" forState:(UIControlStateNormal)];
        [self.sumbitBnt setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    }
    [self.Img sd_setImageWithURL:[NSURL URLWithString:smodle.ImageUrl]];
    self.NameLabel.text = smodle.Name;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.summeryTV = textView;
    
    if ([self.summeryTV.text isEqualToString:@"请填写您的心得和购买建议,方便和大家分享"]) {
        self.summeryTV.text = @"";
        self.summeryTV.textColor = [UIColor blackColor];
    }else
    {
//        self.summeryTV.textColor = [UIColor blackColorv];

    }

    
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([self.delegate respondsToSelector:@selector(getcell:)]) {
        NSLog(@"%ld",self.tag);
        [_delegate getcell:self];
    }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
    self.summeryTV = textView;

     self.cellTextViewTxBlock(self.summeryTV.text);
   /// NSLog(@"%@",self.summeryTV.text);
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{

   
    if ([@"\n" isEqualToString:text] == YES)
    {
        if ([self.delegate respondsToSelector:@selector(recovercell:)]) {
           
            [_delegate recovercell:self];
        }
        [textView resignFirstResponder];
        [self.summeryTV resignFirstResponder];

        return NO;
    }
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    

            [self.summeryTV resignFirstResponder];

}
@end
