//
//  SYYoukuUrlFetcher.m
//  Pods
//
//  Created by Sherlock on 9/2/14.
//
//

#import "SYYoukuUrlFetcher.h"
#import "AFNetworking.h"

@interface SYYoukuUrlFetcher ()

@property (nonatomic, strong) NSOperationQueue *requestQueue;

@end

@implementation SYYoukuUrlFetcher

- (id)init {
  if (self = [super init]) {
    _requestQueue = [[NSOperationQueue alloc] init];
  }
  return self;
}

- (void)urlOfId:(NSString *)videoId {
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://v.youku.com/player/getPlayList/VideoIDS/XNTU0NDIzNjM2"]];
  AFHTTPRequestOperation *requestOp = [[AFHTTPRequestOperation alloc] initWithRequest:request];
  requestOp.responseSerializer = [AFJSONResponseSerializer serializer];
  requestOp.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
  [requestOp setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
    [self finishRequestWithData:responseObject];
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //TODO: failed
  }];
  [self.requestQueue addOperation:requestOp];
}

- (void)finishRequestWithData:(NSDictionary *)data {
  //TODO: parse error handle, check nulls
  NSDictionary *videoData = [data valueForKey:@"data"][0];
  NSInteger seed = [[videoData valueForKey:@"seed"] integerValue];
  NSString *fileId = [[videoData valueForKey:@"streamfileids"] valueForKey:@"mp4"];
  NSString *realId = [self getFileId:fileId seed:seed];
  NSString *leftId = [realId substringToIndex:8];
  NSString *rightId = [realId substringFromIndex:10];
  NSArray *segs = [[videoData valueForKeyPath:@"segs"] valueForKey:@"mp4"];
  NSMutableString *videoUrl = [NSMutableString string];
  NSString *sid = [self getSid];
  for (int i = 0; i < [segs count]; i++) {
    NSDictionary *seg = segs[i];
    NSString *k = [seg valueForKey:@"k"];
    NSString *index = [NSString stringWithFormat:@"%02x", i];
    NSString *url = [NSString stringWithFormat:@"http://f.youku.com/player/getFlvPath/sid/%@_%@/st/%@/fileid/%@%@%@?K=%@", sid, index, @"mp4", leftId, index, rightId, k];
    [videoUrl appendString:url];
    [videoUrl appendString:@"#"];
  }
  NSLog(@"===========================> URL:\n%@", videoUrl);
  //TODO: report the videoUrl to delegate
}


- (NSString *)getFileId:(NSString *)fileId seed:(NSInteger)seed {
  NSString *mixed = [self getFileIdMixString:seed];
  NSArray *ids = [fileId componentsSeparatedByString:@"*"];
  NSMutableString *result = [NSMutableString string];
  for (int i = 0; i < [ids count]; i++) {
    NSInteger index = [ids[i] integerValue];
    NSRange range = NSMakeRange(index, 1);
    [result appendString:[mixed substringWithRange:range]];
  }
  return [NSString stringWithString:result];
}

- (NSString *)getSid {
  long i1 = (long) (1000 + floor(arc4random() * 999));
  long i2 = (long) (1000 + floor(arc4random() * 9000));
  long t = [[NSDate date] timeIntervalSince1970] * 1000;
  return [NSString stringWithFormat:@"%lu%lu%lu", t, i1, i2];
}

- (NSString *)getFileIdMixString:(NSInteger)seed {
  NSMutableString *source = [NSMutableString stringWithString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ/\\:._-1234567890"];
  NSMutableString *mixed = [NSMutableString string];
  NSInteger length = source.length;
  for (int i = 0; i < length; i++) {
    seed = (seed * 211 + 30031) % 65536;
    NSInteger index = floor(seed / 65536 * source.length);
    NSRange range = NSMakeRange(index, 1);
    [mixed appendString:[source substringWithRange:range]];
    [source deleteCharactersInRange:range];
  }
  return [NSString stringWithString:mixed];
}

@end
