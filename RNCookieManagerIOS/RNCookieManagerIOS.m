#import "RNCookieManagerIOS.h"
#if __has_include("RCTConvert.h")
#import "RCTConvert.h"
#else
#import <React/RCTConvert.h>
#endif

@implementation RNCookieManagerIOS

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(set:(NSDictionary *)props callback:(RCTResponseSenderBlock)callback) {
    NSString *name = [RCTConvert NSString:props[@"name"]];
    NSString *value = [RCTConvert NSString:props[@"value"]];
    NSString *domain = [RCTConvert NSString:props[@"domain"]];
    NSString *origin = [RCTConvert NSString:props[@"origin"]];
    NSString *path = [RCTConvert NSString:props[@"path"]];
    NSString *version = [RCTConvert NSString:props[@"version"]];
    NSDate *expiration = [RCTConvert NSDate:props[@"expiration"]];

    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    [cookieProperties setObject:name forKey:NSHTTPCookieName];
    [cookieProperties setObject:value forKey:NSHTTPCookieValue];
    [cookieProperties setObject:domain forKey:NSHTTPCookieDomain];
    [cookieProperties setObject:origin forKey:NSHTTPCookieOriginURL];
    [cookieProperties setObject:path forKey:NSHTTPCookiePath];
    [cookieProperties setObject:version forKey:NSHTTPCookieVersion];
//    [cookieProperties setObject:2629743 forKey:NSHTTPCookieExpires];

    NSLog(@"SETTING COOKIE");
    NSLog(@"%@", cookieProperties);

    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];

    callback(@[[NSNull null]]);
    
//    NSLog(@"SET COOKIE");
//    // set cookies
//    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
//    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
//    [cookieProperties setObject:@"laapp" forKey:NSHTTPCookieName];
//    
//    // PUT HERE VALID COOKIE FROM WEB
//    [cookieProperties setObject:@"tER6IDWVli1BhGSULFPBIuxeTVvDQcFZnBXue96smw0%3D--G%2BrrgsHlxP%2BWptCO0qGx2OFxRZtERMIZEdyUQtzTeb0SFah6Jw8DWadCg3yQKMhs2fNbBtG3N%2BCX5I6GLNKOJdp5ndQuzxDxXTVur6Ghdh7JE%2FxeSwPG%2Bv%2F8Zw13OUcDAkp9KmKSn%2FdMNvuxT%2Bt0HFzSszOLffcej6KSCeez8675yYXFmBwq5O3pLVtQ8GcTID2AP1S2BH3vClJcc4hlAj%2FjtnTP%2FOXVPZaly1hVGHp8oM9dhF%2BvZvKQTmhXieOIGQXyYQdMCZyPzlcn5%2FGQVnk7gDhMN04Mat9LvV3MSv9yN2UrZ1h7uTHADz1vcXIA7qOAM%2BGDW%2FnOOKYr4yFN7T%2FfD11SY2XvpKcfyuOgxSkxNSgFAYfnS0wv2Qp0aJJo9MpJPoxJXq89lckSNzEREOQqKvKF4R4DXpZHu%2Fu2I2XnFSV7PA2aZgFnky6EzdeFvul9lCBLpb7d5dhMBRQ3Yy4cLiYJWRmQIINPw47flZK6J8ADnO99Ik5BxLB4hls93OIPJdZfPw0P8IoFEBqwyg3frwVzhAE7gea28OqwOEu%2FX514LCy1xt26B6Yk67zQu4j26%2BzUY2NU5TWpvLqwKeJ8knkWaujBKPPzSKbPWSdB9gUH8s2qMCMre2aQswMMK7Xcd96DB%2BZ8JR2cU6a3ry4DonU%3D" forKey:NSHTTPCookieValue];
//    [cookieProperties setObject:@"qatest.labarchives.com" forKey:NSHTTPCookieDomain];
//    [cookieProperties setObject:@"qatest.labarchives.com" forKey:NSHTTPCookieOriginURL];
//    [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
//    [cookieProperties setObject:@"0" forKey:NSHTTPCookieVersion];
//    
//    //[cookieProperties setObject:[[NSDate date] dateByAddingTimeInterval:2629743] forKey:NSHTTPCookieExpires];
//    
//    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
//    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
}

RCT_EXPORT_METHOD(setFromResponse:(NSURL *)url value:(NSDictionary *)value callback:(RCTResponseSenderBlock)callback) {
  NSArray *cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:value forURL:url];
  [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookies:cookies forURL:url mainDocumentURL:NULL];
    callback(@[[NSNull null]]);
}


RCT_EXPORT_METHOD(get:(NSURL *)url callback:(RCTResponseSenderBlock)callback) {
    NSMutableDictionary *cookies = [NSMutableDictionary dictionary];
    for (NSHTTPCookie *c in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:url]) {
        [cookies setObject:c.value forKey:c.name];
    }
    callback(@[[NSNull null], cookies]);
}

RCT_EXPORT_METHOD(clearAll:(RCTResponseSenderBlock)callback) {
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *c in cookieStorage.cookies) {
        [cookieStorage deleteCookie:c];
    }
    callback(@[[NSNull null]]);
}

RCT_EXPORT_METHOD(clearByName:(NSString *)name callback:(RCTResponseSenderBlock)callback) {
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *c in cookieStorage.cookies) {
      if ([[c name] isEqualToString:name]) {
        [cookieStorage deleteCookie:c];
      }
    }
    callback(@[[NSNull null]]);
}

// TODO: return a better formatted list of cookies per domain
RCT_EXPORT_METHOD(getAll:(RCTResponseSenderBlock)callback) {
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSMutableDictionary *cookies = [NSMutableDictionary dictionary];
    for (NSHTTPCookie *c in cookieStorage.cookies) {
        NSMutableDictionary *d = [NSMutableDictionary dictionary];
        [d setObject:c.value forKey:@"value"];
        [d setObject:c.name forKey:@"name"];
        [d setObject:c.domain forKey:@"domain"];
        [d setObject:c.path forKey:@"path"];
        [cookies setObject:d forKey:c.name];
    }
    callback(@[[NSNull null], cookies]);
}

@end
