//
//  SYYoukuUrlFetcher.h
//  Pods
//
//  Created by Sherlock on 9/2/14.
//
//

#import <Foundation/Foundation.h>

/**
 * The response data of GET http://v.youku.com/player/getPlayList/VideoIDS/{video id} looks like:
 *{
   "data": [
     {
       "ct": "t",
       "cs": "250",
       "logo": "http://g3.ykimg.com/1100641F46518B6D265F7C089F1EFF1C66DB2E-E71A-BE2D-89DE-FBADB880F58D",
       "seed": 7292,
       "tags": [
         "留学",
         "美国留学",
         "申请",
         "考试辅导",
         "语言学习",
         "英国留学",
         "ChaseFuture",
         "剑桥",
         "个人陈述",
         "Workshop"
       ],
       "categories": "87",
       "videoid": "138605909",
       "vidEncoded": "XNTU0NDIzNjM2",
       "username": "Chase_Future",
       "userid": "144645887",
       "title": "ChaseFuture留学指导Workshop第五课：留学申请与志愿者经历",
       "up": 0,
       "down": 0,
       "ts": "nCjSCTEwA*E50ToFAT-qG60",
       "tsup": "nCjWHzIwA*E50ToFAinuG60",
       "preview": {
         "thumbs": [
           "05210001518B6D546A0737503402AC37"
         ],
         "sectiontime": "6000",
         "host": "http://g2.ykimg.com/"
       },
     "key1": "b3477a1c",
     "key2": "363569b1e407509c",
     "tt": "0",
     "videoSource": "1",
     "seconds": "537.20",
     "streamfileids": {
       "flv": "64*51*64*64*64*11*64*11*64*64*62*1*30*38*0*31*62*11*62*42*38*1*64*30*27*24*1*42*24*24*62*31*51*37*31*64*1*60*22*64*38*30*51*22*24*62*64*23*22*60*37*24*60*22*1*60*38*27*0*27*5*11*64*60*42*23*",
       "mp4": "64*51*64*64*64*30*64*11*64*64*62*1*30*38*0*60*11*51*62*42*38*1*64*30*27*24*1*42*24*24*62*31*51*37*31*64*1*60*22*64*38*30*51*22*24*62*64*23*22*60*37*24*60*22*1*60*38*27*0*27*5*11*64*60*42*23*"
     },
     "segs": {
       "flv": [
         {
           "no": "0",
           "size": "8871647",
           "seconds": 253,
           "k": "c00d335ae78dcc242411eca2",
           "k2": "122476ee2d10f69dd"
         },
         {
           "no": "1",
           "size": "10420822",
           "seconds": 284,
           "k": "1c769df6012b02622829d2d1",
           "k2": "1c39129ad70a4ed6f"
         }
       ],
       "mp4": [
         {
           "no": "0",
           "size": "18246602",
           "seconds": 274,
           "k": "0bf928c1d330fc152829d2d1",
           "k2": "1fbe8e221bfda68c6"
         },
         {
           "no": "1",
           "size": "18715326",
           "seconds": 263,
           "k": "59eab2059b3315f42411eca2",
           "k2": "1ae89985b7c6bc358"
         }
       ]
     },
     "streamsizes": {
       "flv": "19292469",
       "mp4": "36961928"
     },
     "stream_ids": {
       "flv": "125651719",
       "mp4": "125652516"
     },
     "streamlogos": {
       "flv": 1,
       "mp4": 1
     },
     "streamtypes": [
       "flv",
       "mp4"
     ],
     "streamtypes_o": [
       "flvhd",
       "mp4"
     ]
   }
   ],
   "user": {
     "id": "16080280"
   },
   "controller": {
     "search_count": true,
     "mp4_restrict": 1,
     "stream_mode": 1,
     "video_capture": true,
     "hd3_enabled": false,
     "area_code": 330100,
     "dma_code": 4837,
     "continuous": 0,
     "playmode": "normal",
     "circle": false,
     "tsflag": false,
     "other_disable": false,
     "xplayer_disable": false,
     "app_disable": false,
     "share_disabled": false,
     "download_disabled": false,
     "pc_disabled": false,
     "pad_disabled": false,
     "mobile_disabled": false,
     "tv_disabled": false,
     "comment_disabled": false
   }
 }
 *
 **/
@interface SYYoukuUrlFetcher : NSObject

- (void)urlOfId:(NSString *)videoId;

@end
