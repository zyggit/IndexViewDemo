//
//  HCChooseCityViewController.m
//  ChooseCityDemo
//
//  Created by Jentle on 15/9/1.
//  Copyright © 2015年 Jentle. All rights reserved.
//

#import "HCChooseCityViewController.h"
#import "HCProvinceModel.h"
#import "HCChooseCityTableViewCell.h"
#import "HCChooseRegionTableViewCell.h"
#import "HCHotCityTableViewCell.h"
#import "HCSideSlipTransmition.h"
#import "MJNIndexView.h"

@interface HCChooseCityViewController ()<UITableViewDelegate, UITableViewDataSource,MJNIndexViewDataSource>
@property (strong, nonatomic) UITableView *provinceTableView; // 省份tableView
@property (strong, nonatomic) UITableView *cityTableView; // 城市tableView
@property (strong, nonatomic) NSMutableArray *indexArray; // 索引
@property (strong, nonatomic) NSMutableArray *titleArray; // 标题
@property (strong, nonatomic) NSDictionary *cityDataDictionary; // 城市列表
@property (strong, nonatomic) NSMutableDictionary *provinceDictionary; // 省份
@property (strong, nonatomic) NSMutableDictionary *cityDictionary; // 二级城市列表
@property (strong, nonatomic) NSMutableArray *hotCityArray; // 热门城市
@property (strong, nonatomic) NSString *provinceID; // 省份ID
@property (strong, nonatomic) HCSideSlipTransmition *sideSlip; // 侧滑
/** 当前定位城市 */
@property(copy, nonatomic) NSString *currentLocateCity;

/** 索引 */
@property(strong, nonatomic) MJNIndexView *indexView;

@end

@implementation HCChooseCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarItem.title = @"选择城市";
    [self analyzeCityList];
    
    [self initialiseMJNIndexView];
}


#pragma mark - 初始化Data
/**
 *  初始化城市数据字典
 */
- (NSDictionary *)cityDataDictionary{
    if (!_cityDataDictionary) {
        _cityDataDictionary = [NSDictionary dictionary];
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"city.plist" ofType:nil];
        _cityDataDictionary = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    }
    return _cityDataDictionary;
}
/**
 *  初始化索引数组
 */
- (NSMutableArray *)indexArray
{
    if (_indexArray == nil) {
        _indexArray = [NSMutableArray array];
    }
    return _indexArray;
}

/**
 *  初始化header标题数组
 */
- (NSMutableArray *)titleArray{
    if (_titleArray == nil) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}

/**
 *  初始化省份数组
 */
- (NSMutableDictionary *)provinceDictionary
{
    if (_provinceDictionary == nil) {
        _provinceDictionary = [NSMutableDictionary dictionary];
    }
    return _provinceDictionary;
}

/**
 *  初始化二级城市数组
 */
- (NSMutableDictionary *)cityDictionary
{
    if (_cityDictionary == nil) {
        _cityDictionary = [NSMutableDictionary dictionary];
    }
    return _cityDictionary;
}

- (NSMutableArray *)hotCityArray
{
    if (_hotCityArray == nil) {
        _hotCityArray = [NSMutableArray array];
    }
    return _hotCityArray;
}


#pragma mark - 初始化页面

/**
 *  初始化省份TableView
 */
- (UITableView *)provinceTableView
{
    if (_provinceTableView== nil) {
        _provinceTableView = [[UITableView alloc] init];
        _provinceTableView.delegate = self;
        _provinceTableView.dataSource = self;
        _provinceTableView.sectionIndexColor = [HCCommonTool colorWithHexColorString:@"#999999"];
        _provinceTableView.sectionIndexBackgroundColor = [UIColor clearColor];
        _provinceTableView.showsVerticalScrollIndicator = NO;
        [_provinceTableView registerClass:[HCChooseCityTableViewCell class] forCellReuseIdentifier:@"Cell"];
        [_provinceTableView registerClass:[HCHotCityTableViewCell class] forCellReuseIdentifier:@"HotCityCell"];
        [self.view addSubview:_provinceTableView];
        [_provinceTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.right.bottom.mas_equalTo(0);
        }];
    }
    return _provinceTableView;
}

- (void)backButtonClicked:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  初始化城市TableView
 */
- (UITableView *)cityTableView
{
    if (_cityTableView == nil) {
        _cityTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth - ALD(180), kScreenHeight)];
        _cityTableView.delegate = self;
        _cityTableView.dataSource = self;
        [_cityTableView registerClass:[HCChooseRegionTableViewCell class] forCellReuseIdentifier:@"RegionCell"];
        _cityTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _cityTableView;
}

- (HCSideSlipTransmition *)sideSlip{
    if (_sideSlip == nil) {
        _sideSlip = [[HCSideSlipTransmition alloc] initWithframe:CGRectMake(ALD(180), kUpSpare, kScreenWidth - ALD(180), kScreenHeight - kUpSpare) withView:self.cityTableView withParentView:self.view showBlackBottom:NO];
    }
    return _sideSlip;
}

/**
 *  初始化MJNIndexView
 */
- (void)initialiseMJNIndexView{
    self.indexView = [[MJNIndexView alloc]initWithFrame:self.view.bounds];
    self.indexView.dataSource = self;
    self.indexView.fontColor = HEXCOLOR(0x52669b);
    self.indexView.font = HCFontWithPixel(30);
    self.indexView.selectedItemFont = HCBoldFontWithPixel(60);
    self.indexView.itemsAligment = NSTextAlignmentCenter;
    self.indexView.curtainFade = 0.0;
    self.indexView.rightMargin = ALD(10);
    self.indexView.maxItemDeflection = 75;
    self.indexView.rangeOfDeflection = 3;
    self.indexView.darkening = NO;
    [self.view addSubview:self.indexView];
}


#pragma mark - tableView的代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.provinceTableView) {
       return self.indexArray.count;
    }
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.provinceTableView) {
        if (section == 0 || section == 1) {
            return 1;
        }else{
            return ((NSArray *)self.provinceDictionary[self.indexArray[section]]).count;
        }
        
    }
    return ((NSArray *)self.cityDictionary[self.provinceID]).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.provinceTableView) {
        if (indexPath.section == 0) {
            HCChooseCityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
            HCProvinceModel *model = [[HCProvinceModel alloc] init];
            model.title = self.currentLocateCity ? self.currentLocateCity:@"正在定位...";
            cell.model = model;
            return cell;
        }else if (indexPath.section == 1){
            HCHotCityTableViewCell *hotCell = [tableView dequeueReusableCellWithIdentifier:@"HotCityCell" forIndexPath:indexPath];
            hotCell.hotCityArray = self.hotCityArray;
            return hotCell;
        }else{
            HCChooseCityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

            HCProvinceModel *provinceModel = self.provinceDictionary[self.indexArray[indexPath.section]][indexPath.row];
            if (indexPath.row == provinceModel.list.count - 1) {
                cell.bottomSeparatorLine.hidden = YES;
            }else{
                cell.bottomSeparatorLine.hidden = YES;
            }
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            cell.model = provinceModel;
            return cell;

        }
    }
    HCChooseRegionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RegionCell" forIndexPath:indexPath];
    HCCityListModel *model = self.cityDictionary[self.provinceID][indexPath.row];
    cell.model = model;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.provinceTableView) {
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, ALD(64))];
        bottomView.backgroundColor = [HCCommonTool colorWithHexColorString:@"#f0f0f0"];
        UILabel *indexLabel = [[UILabel alloc] init];
        indexLabel.textColor = [HCCommonTool colorWithHexColorString:@"#999999"];
        indexLabel.font = [UIFont systemFontOfSize:12];
        indexLabel.text = self.titleArray[section];
        [bottomView addSubview:indexLabel];
        [indexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(ALD(30));
            make.right.mas_equalTo(-ALD(30));
            make.top.bottom.mas_equalTo(0);
        }];
        return bottomView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.provinceTableView) {
       return ALD(64);
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        NSInteger number = (self.hotCityArray.count - 1) / 5;
        CGFloat height = 0.f;
        if (number == 0) {
            height = 2*ALD(30) + (number + 1)*ALDHeight(30);
        }else{
            height = 2*ALD(30) + (number + 1)*ALDHeight(30)+number*ALD(30);
        }
        return height;
    }
    return ALD(90);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.provinceTableView) {
        if (indexPath.section == 0 || indexPath.section == 1) {
            if (indexPath.section == 0) {
                HCChooseCityTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                HCProvinceModel *model = cell.model;
                if (self.chooseLocateCityBlock) {
                    self.chooseLocateCityBlock(model);
                }
                
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }else{
            self.provinceID = ((HCProvinceModel *)self.provinceDictionary[self.indexArray[indexPath.section]][indexPath.row]).provinceID;
            [self.sideSlip show];
            [self.cityTableView reloadData];
        }
    }
}

#pragma mark - scrollView代理方法

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollView == self.provinceTableView) {
        [self.sideSlip dismiss:YES];
    }
}

/**
 *  解析城市列表
 */
- (void)analyzeCityList
{
    NSArray *allArray = self.cityDataDictionary[@"all"];
    NSArray *hotArray = self.cityDataDictionary[@"hot"];
    for (NSDictionary *dic in hotArray) {
        HCCityListModel *model = [[HCCityListModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [self.hotCityArray addObject:model];
    }

    for (NSDictionary *dic in allArray) {
        HCProvinceModel *model = [[HCProvinceModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        if ([self.provinceDictionary.allKeys containsObject:model.firstname]) {
            NSMutableArray *provinceArray = [NSMutableArray arrayWithArray:self.provinceDictionary[model.firstname]];
            [provinceArray addObject:model];
            [self.provinceDictionary setObject:provinceArray forKey:model.firstname];
        }else{
            NSMutableArray *provinceArray = [NSMutableArray array];
            [provinceArray addObject:model];
            [self.provinceDictionary setObject:provinceArray forKey:model.firstname];
        }
        if ([self.indexArray containsObject:model.firstname] == NO) {
            [self.indexArray addObject:model.firstname];
            [self.titleArray addObject:model.firstname];
        }
        NSMutableArray *cityArray = [NSMutableArray array];
        for (NSDictionary *cityDic in model.list) {
            HCCityListModel *cityModel = [[HCCityListModel alloc] init];
            [cityModel setValuesForKeysWithDictionary:cityDic];
            [cityArray addObject:cityModel];
        }
        [self.cityDictionary setValue:cityArray forKey:model.provinceID];
    }
    [self.indexArray sortUsingSelector:@selector(compare:)];
    [self.titleArray sortUsingSelector:@selector(compare:)];
    [self.indexArray insertObject:@"#" atIndex:0];
    [self.indexArray insertObject:@"➣" atIndex:0];
    [self.titleArray insertObject:@"热门城市" atIndex:0];
    [self.titleArray insertObject:@"定位城市" atIndex:0];
    self.provinceTableView.backgroundColor = [HCCommonTool colorWithHexColorString:@"#f0f0f0"];
}

#pragma mark - <MJNIndexViewDataSource>

- (NSArray *)sectionIndexTitlesForMJNIndexView:(MJNIndexView *)indexView
{
    return self.indexArray;
}

- (void)sectionForSectionMJNIndexTitle:(NSString *)title atIndex:(NSInteger)index;
{
    [self.provinceTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0
                                                                       inSection:index] atScrollPosition: UITableViewScrollPositionTop     animated:YES];
}



@end
