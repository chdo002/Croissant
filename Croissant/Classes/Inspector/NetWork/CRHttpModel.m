//
//  CRHttpModel.m
//  AFNetworking
//
//  Created by chdo on 2019/10/13.
//

#import "CRHttpModel.h"

@implementation CRHttpModel

- (NSMutableData *)responseData
{
    if (!_responseData) {
        _responseData = NSMutableData.data;
    }
    return _responseData;
}

@end
