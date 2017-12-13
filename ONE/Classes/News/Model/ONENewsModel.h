//
//  ONENewsModel.h
//  ONE
//
//  Created by 崔一鸣 on 2017/12/7.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol ONENewsItemModel
@end
@protocol ONENewsDataModel
@end
@protocol ONENewsDataListModel
@end


@interface ONENewsItemModel : JSONModel

@property (nonatomic, copy) NSArray *imageurls;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *pubDate;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *havePic;

@end

@interface ONENewsDataModel : JSONModel

@property (nonatomic, copy)NSArray<ONENewsItemModel> *contentlist;

@end

@interface ONENewsDataListModel : JSONModel

@property (nonatomic, copy) ONENewsDataModel<Optional>*pagebean;

@end

@interface ONENewsModel : JSONModel

@property (nonatomic, copy)ONENewsDataListModel<Optional> *showapi_res_body;

@end


