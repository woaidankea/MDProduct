//
//  SelectedView.m
//  MDApplication
//
//  Created by jieku on 16/5/24.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "SelectedView.h"
#import "BaseTableViewCell.h"
@interface selectCell : BaseTableViewCell
//@property (nonatomic,strong)UIImageView *sortImage;
@property (nonatomic,strong)UIImageView *avatorView;
//@property (nonatomic,strong)UILabel *accountLabel;
@property (nonatomic,strong)UILabel *contentLabel;
@property (nonatomic,strong)UIView *bottomLine;
@end


@implementation selectCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //        self.backgroundColor = UIColorFromRGB(0xf9f9f9);
        [self setUpConstriant];
    }
    return self;
}
- (void)setUpConstriant{
    
    WS(weakSelf);
    
    
    [self.avatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.contentView.mas_right).offset(-20);
        make.centerY.equalTo(weakSelf.contentView.mas_centerY);
        make.width.mas_equalTo(12);
        make.height.mas_equalTo(10);
        
    }];
    
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView.mas_left).offset(20);
        make.centerY.equalTo(weakSelf.contentView.mas_centerY);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(100);
        
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.contentView.mas_right).offset(0);
        make.left.equalTo(weakSelf.contentView.mas_left).offset(0);
        make.bottom.equalTo(weakSelf.contentView.mas_bottom);
        
        
        make.height.mas_equalTo(1);
        
        
    }];
    
    
    
    
    
}
- (UILabel *)contentLabel{
    if(!_contentLabel){
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.font = [UIFont systemFontOfSize:13.0];
        _contentLabel.text = @"昨日";
        _contentLabel.textColor = UIColorFromRGB(0x848484);
        _contentLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_contentLabel];
        
    }
    return _contentLabel;
    
}


- (UIImageView *)avatorView{
    if(!_avatorView){
        _avatorView = [[UIImageView alloc]init];
        _avatorView.image = [UIImage imageNamed:@"selected"];
        _avatorView.layer.cornerRadius = 22.5;
        [self.contentView addSubview:_avatorView];
    }
    return _avatorView;
}

- (UIView *)bottomLine{
    if(!_bottomLine){
        _bottomLine = [[UIView alloc]init];
        _bottomLine.backgroundColor = UIColorFromRGB(0xe3e3e3);
        [self.contentView addSubview:_bottomLine];
        
    }
    
    return _bottomLine;
    
}
@end

@implementation SelectedView


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        
        [self setUpConstriant];
           
    }
    return self;
}

- (void)setUpConstriant{
    
    WS(weakSelf);
    
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(weakSelf);
        
    }];
}
- (UITableView *)table{
    if(!_table){
        _table = [[UITableView alloc]init];
        _table.showsVerticalScrollIndicator = NO;
        _table.delegate = self;
        _table.dataSource = self;
        _table.backgroundColor =  UIColorFromRGB(0xf0f0f0);
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _table.separatorColor =  UIColorFromRGB(0xb5b5b5);
        _table.tableFooterView =  [[UIView alloc] initWithFrame:CGRectZero];
           [_table registerClass:[selectCell class] forCellReuseIdentifier:@"selectCell"];
       [self addSubview:_table];
    
        
    }
    return _table;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 35;
}
#pragma mark -UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    selectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selectCell"];
    
    if(!(indexPath.row == _currentSelected)){
        cell.contentLabel.textColor = [UIColor blackColor];
        cell.avatorView.hidden = YES;
    }else {
        cell.contentLabel.textColor = UIColorFromRGB(0xd3494e);
        cell.avatorView.hidden = NO;
    }
    cell.contentLabel.text =[_dataSource objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _currentSelected = indexPath.row;
    [_table reloadData];
    
    if ([_delegate respondsToSelector:@selector(SelectedViewDidSelectedAtIndex:)]) {
        [_delegate SelectedViewDidSelectedAtIndex:indexPath.row];
    }
}

@end
