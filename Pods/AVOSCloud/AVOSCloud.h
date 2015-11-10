//
//  paas.h
//  paas
//
//  Created by Zhu Zeng on 2/25/13.
//  Copyright (c) 2013 AVOS. All rights reserved.
//

#import <Foundation/Foundation.h>

// Public headers

#import "AVConstants.h"
#import "AVLogger.h"

// Object
#import "AVObject.h"
#import "AVObject+Subclass.h"
#import "AVSubclassing.h"
#import "AVRelation.h"

// Query
#import "AVQuery.h"

// File
#import "AVFile.h"
#import "AVFileQuery.h"

// Geo
#import "AVGeoPoint.h"

// Status
#import "AVStatus.h"

// Push
#import "AVInstallation.h"
#import "AVPush.h"

// User
#import "AVUser.h"
#import "AVAnonymousUtils.h"

// CloudCode
#import "AVCloud.h"
#import "AVCloudQueryResult.h"

// Search
#import "AVSearchQuery.h"
#import "AVSearchSortBuilder.h"

// ACL
#import "AVACL.h"
#import "AVRole.h"

#if AVOS_IOS_ONLY
// IM 1.0
#import "AVSession.h"
#import "AVSignature.h"
#import "AVMessage.h"
#import "AVGroup.h"
#import "AVHistoryMessage.h"
#import "AVHistoryMessageQuery.h"
#endif

#if AVOS_IOS_ONLY
// Analytics
#import "AVAnalytics.h"
#endif

FOUNDATION_EXPORT NSString *const LCDefaultRESTAPIHost;
FOUNDATION_EXPORT NSString *const LCFoundationCertificate;

/**
 *  Storage Type
 */
typedef NS_ENUM(int, AVStorageType) {
    /// Qiniu
    AVStorageTypeQiniu = 0,
    
    /// Parse
    AVStorageTypeParse,
    
    /// AWS S3
    AVStorageTypeS3,

} ;

typedef enum AVLogLevel : NSUInteger {
    AVLogLevelNone      = 0,
    AVLogLevelError     = 1 << 0,
    AVLogLevelWarning   = 1 << 1,
    AVLogLevelInfo      = 1 << 2,
    AVLogLevelVerbose   = 1 << 3,
    AVLogLevelDefault   = AVLogLevelError | AVLogLevelWarning
} AVLogLevel;

#define kAVDefaultNetworkTimeoutInterval 10.0

/**
 *  AVOSCloud is the main Class for AVOSCloud SDK
 */
@interface AVOSCloud : NSObject

/*!
 * Enable logs of all levels and domains.
 */
+ (void)setAllLogsEnabled:(BOOL)enabled;

/**
 *  设置SDK信息显示
 *  @param verbosePolicy SDK信息显示策略，kAVVerboseShow为显示，
 *         kAVVerboseNone为不显示，kAVVerboseAuto在DEBUG时显示
 */
+ (void)setVerbosePolicy:(AVVerbosePolicy)verbosePolicy;

/** @name Connecting to LeanCloud */

/*!
 Sets the applicationId and clientKey of your application.
 @param applicationId The applicaiton id for your LeanCloud application.
 @param clientKey The client key for your LeanCloud application.
 */
+ (void)setApplicationId:(NSString *)applicationId clientKey:(NSString *)clientKey;

/**
 *  get Application Id
 *
 *  @return Application Id
 */
+ (NSString *)getApplicationId;

/**
 *  get Client Key
 *
 *  @return Client Key
 */
+ (NSString *)getClientKey;


/**
 *  开启LastModify支持, 减少流量消耗。默认关闭。
 *
 *  @param enabled 开启
 */
+ (void)setLastModifyEnabled:(BOOL)enabled;

/**
 *  获取是否开启LastModify支持
 */
+ (BOOL)getLastModifyEnabled;

/**
 *  清空LastModify缓存
 */
+(void)clearLastModifyCache;

+ (void)useAVCloud AVDeprecated("2.3.3以后废除");

/**
 *  Set third party file storage service. If uses China server, the default is Qiniu, if uses US server, the default is AWS S3.
 *  @param type Qiniu or AWS S3
 */
+ (void)setStorageType:(AVStorageType)type;

/**
 *  Use LeanCloud US server.
 */
+ (void)useAVCloudUS;

/**
 *  Use LeanCloud China Sever. Default option.
 */
+ (void)useAVCloudCN;

/**
 *  Get the timeout interval for network requests. Default is kAVDefaultNetworkTimeoutInterval (10 seconds)
 *
 *  @return timeout interval
 */
+ (NSTimeInterval)networkTimeoutInterval;

/**
 *  Set the timeout interval for network request.
 *
 *  @param time  timeout interval(seconds)
 */
+ (void)setNetworkTimeoutInterval:(NSTimeInterval)time;

// log
+ (void)setLogLevel:(AVLogLevel)level;
+ (AVLogLevel)logLevel;

#pragma mark Schedule work

/**
 * Register remote notification with types.
 * @param types Notification types.
 * @param categories A set of UIUserNotificationCategory objects that define the groups of actions a notification may include.
 * NOTE: categories only supported by iOS 8 and later. If application run below iOS 8, categories will be ignored.
 */
+ (void)registerForRemoteNotificationTypes:(NSUInteger)types categories:(NSSet *)categories;

/**
 * Register remote notification with all types (badge, alert, sound) and empty categories.
 */
+ (void)registerForRemoteNotification;

/**
 *  get the query cache expired days
 *
 *  @return the query cache expired days
 */
+ (NSInteger)queryCacheExpiredDays;

/**
 *  set Query Cache Expired Days, default is 30 days
 *
 *  @param days the days you want to set
 */
+ (void)setQueryCacheExpiredDays:(NSInteger)days;

/**
 *  get the file cache expired days
 *
 *  @return the file cache expired days
 */
+ (NSInteger)fileCacheExpiredDays;


/**
 *  set File Cache Expired Days, default is 30 days
 *
 *  @param days the days you want to set
 */
+ (void)setFileCacheExpiredDays:(NSInteger)days;

/*!
 *  请求短信验证码，需要开启手机短信验证 API 选项。
 *  发送短信到指定的手机上，发送短信到指定的手机上，获取6位数字验证码。
 *  @param phoneNumber 11位电话号码
 *  @param callback 回调结果
 */
+(void)requestSmsCodeWithPhoneNumber:(NSString *)phoneNumber
                            callback:(AVBooleanResultBlock)callback;
/*!
 *  请求短信验证码，需要开启手机短信验证 API 选项。
 *  发送短信到指定的手机上，获取6位数字验证码。
 *  @param phoneNumber 11位电话号码
 *  @param appName 应用名称，传nil为默认值您的应用名称
 *  @param operation 操作名称，传nil为默认值"短信认证"
 *  @param ttl 短信过期时间，单位分钟，传0为默认值10分钟
 *  @param callback 回调结果
 */
+(void)requestSmsCodeWithPhoneNumber:(NSString *)phoneNumber
                             appName:(NSString *)appName
                           operation:(NSString *)operation
                          timeToLive:(NSUInteger)ttl
                            callback:(AVBooleanResultBlock)callback;

/*!
 *  请求短信验证码，需要开启手机短信验证 API 选项。
 *  发送短信到指定的手机上，获取6位数字验证码。
 *  @param phoneNumber 11位电话号码
 *  @param templateName 模板名称，传nil为默认模板
 *  @param variables 模板中使用的变量
 *  @param callback 回调结果
 */
+(void)requestSmsCodeWithPhoneNumber:(NSString *)phoneNumber
                        templateName:(NSString *)templateName
                           variables:(NSDictionary *)variables
                            callback:(AVBooleanResultBlock)callback;

/*!
 * 请求语音短信验证码，需要开启手机短信验证 API 选项
 * 发送语音短信到指定手机上
 * @param phoneNumber 11 位电话号码
 * @param IDD 号码的所在地国家代码，如果传 nil，默认为 "+86"
 * @param callback 回调结果
 */
+(void)requestVoiceCodeWithPhoneNumber:(NSString *)phoneNumber
                                   IDD:(NSString *)IDD
                              callback:(AVBooleanResultBlock)callback;

/*!
 *  验证短信验证码，需要开启手机短信验证 API 选项。
 *  发送验证码给服务器进行验证。
 *  @param code 6位手机验证码
 *  @param phoneNumber 11位电话号码
 *  @param callback 回调结果
 */
+(void)verifySmsCode:(NSString *)code mobilePhoneNumber:(NSString *)phoneNumber callback:(AVBooleanResultBlock)callback;

/*!
 * 获取服务端时间。
 */
+ (NSDate *)getServerDate:(NSError **)error;

/*!
 * 异步地获取服务端时间。
 * @param block 回调结果。
 */
+ (void)getServerDateWithBlock:(void(^)(NSDate *date, NSError *error))block;

@end
