//
//  MPImageUploadProgressCell.m
//  MobileProject
//
//  Created by wujunyang on 16/7/22.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "MPImageUploadProgressCell.h"

@interface MPImageUploadProgressCell()
@property (strong, nonatomic) UICollectionView *myImagesCollectionView;
@property (strong, nonatomic) NSMutableArray *imageViewsDict;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *titleLabel;
@end


@implementation MPImageUploadProgressCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 初始化代码
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        if (!self.myImagesCollectionView) {
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            self.myImagesCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(80, 10, kMMWidth-80 - 20, 80) collectionViewLayout:layout];
            self.myImagesCollectionView.scrollEnabled = NO;
            [self.myImagesCollectionView setBackgroundView:nil];
            [self.myImagesCollectionView setBackgroundColor:[UIColor clearColor]];
            [self.myImagesCollectionView registerClass:[MPImageProgressCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([MPImageProgressCollectionCell class])];
            self.myImagesCollectionView.dataSource = self;
            self.myImagesCollectionView.delegate = self;
            [self.contentView addSubview:self.bgView];
            [self.bgView addSubview:self.titleLabel];
            [self.bgView addSubview:self.myImagesCollectionView];
        }
        if (!_imageViewsDict) {
            _imageViewsDict = [[NSMutableArray alloc] init];
        }
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

//更新列表高度
-(void)setCurUploadImageHelper:(MPUploadImageHelper *)curUploadImageHelper
{
    if (_curUploadImageHelper!=curUploadImageHelper) {
        _curUploadImageHelper=curUploadImageHelper;
    }
    //更新列表高度
    [self.myImagesCollectionView setHeight:[MPImageUploadProgressCell cellHeightWithObj:_curUploadImageHelper]];
    [self.myImagesCollectionView reloadData];
    
    //把为浏览大图做准备
    if (_imageViewsDict) {
        [_imageViewsDict removeAllObjects];
        for (MPImageItemModel *model in curUploadImageHelper.imagesArray) {
            // 当编辑是无法获得selectedAssetURLs,这时把图片直接传给MWPhoto
            if (!model.isUpload) {
                MWPhoto *mwphoto=[MWPhoto photoWithImage:model.image];
                mwphoto.caption=nil;
                [_imageViewsDict addObject:mwphoto];

            }else{
                
                // 原始只有这一种情况,
                for (NSURL *itemUrl in curUploadImageHelper.selectedAssetURLs) {
                    MWPhoto *mwphoto=[MWPhoto photoWithURL:itemUrl];
                    mwphoto.caption=nil;
                    [_imageViewsDict addObject:mwphoto];
                }
 
            }
        }
        
            }
}



+ (CGFloat)cellHeightWithObj:(id)obj
{
    CGFloat cellHeight = 30;
    if ([obj isKindOfClass:[MPUploadImageHelper class]]) {
        MPUploadImageHelper *curUploadImage = (MPUploadImageHelper *)obj;
        NSInteger row = 0;
        if (curUploadImage.imagesArray.count <= 0) {
            row = 0;
            cellHeight+=kImageCollectionCell_Width;
        }else{
            NSInteger curRowImageCount=curUploadImage.imagesArray.count<kupdateMaximumNumberOfImage?curUploadImage.imagesArray.count +1:kupdateMaximumNumberOfImage;
            row = ceilf((float)(curRowImageCount)/3.0);
            cellHeight += ([MPImageProgressCollectionCell ccellSize].height +5) *row;
        }
    }
    else
    {
        cellHeight+=kImageCollectionCell_Width;
    }
    return cellHeight;
}


#pragma mark UICollectionViewDataSource, UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger num = self.curUploadImageHelper.imagesArray.count;
    //如果没有大于最大上传数 则显示增加图标
    if (num<kupdateMaximumNumberOfImage) {
        return num+ 1;
    }
    return num;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) weakSelf = self;
    MPImageProgressCollectionCell *ccell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MPImageProgressCollectionCell class]) forIndexPath:indexPath];
    if (indexPath.row < self.curUploadImageHelper.imagesArray.count) {
        MPImageItemModel *curImage = [weakSelf.curUploadImageHelper.imagesArray objectAtIndex:indexPath.row];
        ccell.curImageItem = curImage;
    }else{
        ccell.curImageItem = nil;
    }
    
    ccell.deleteImageBlock = ^(MPImageItemModel *toDelete){
        if (weakSelf.deleteImageBlock) {
            weakSelf.deleteImageBlock(toDelete);
        }
    };
    ccell.imgIndex = indexPath.row + 900;
    return ccell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [MPImageProgressCollectionCell ccellSize];
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsZero;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //区分是增加图片事件还是点浏览大图
    if (indexPath.row == self.curUploadImageHelper.imagesArray.count) {
        if (_addPicturesBlock) {
            _addPicturesBlock();
        }
    }
    else
    {
        MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
        browser.displayActionButton = NO;
        browser.displayNavArrows = YES;
        browser.displaySelectionButtons = NO;
        browser.alwaysShowControls = NO;
        browser.zoomPhotosToFill = YES;
        browser.enableGrid = NO;
        browser.startOnGrid = NO;
        browser.enableSwipeToDismiss = YES;
//        browser.autoPlayOnAppear = NO;
        [browser setCurrentPhotoIndex:indexPath.row];
        
        [self.viewController.navigationController pushViewController:browser animated:YES];
    }
}


#pragma mark--MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.imageViewsDict.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.imageViewsDict.count) {
        return [self.imageViewsDict objectAtIndex:index];
    }
    return nil;
}

- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, kMMWidth - 20, 60)];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 16)];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.text = @"附件";
    }
    return _titleLabel;
}


@end
