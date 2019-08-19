//
//  Croissant.h
//  Croissant
//
//  Created by chdo on 2019/8/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Croissant : NSObject

@property (class, nonatomic, strong) Croissant *shareInstance;

@property (nonatomic, assign) BOOL enabled;


- (void)shareServeURL;

@end

NS_ASSUME_NONNULL_END
