//
//  JSTFNetRequestHandler.m
//  MVVMDemo
//
//  Created by mc on 2018/3/21.
//  Copyright © 2018年 mc. All rights reserved.
//

#import "JSTFNetRequestHandler.h"
#import "AFNetworking.h"

@implementation JSTFNetRequestHandler

+ (NSString *)getRequestBaseDomain{
    return JSTF_API_BASE_HOST;
}

+ (void)request:(JSTFNetRequest *)request success:(void (^)(NSHTTPURLResponse *response, id responseObject))success failure:(void (^)(NSError *error))failure{
    // 1.获得请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    // 2.申明返回的结果是text/html类型
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"text/html",@"application/json",@"text/javascript",@"text/json",@"text/plain", nil];
    switch (request.contentType) {
        case MSRequestContentDefault:
            mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
            break;
        case MSRequestContentJson:
            mgr.requestSerializer = [AFJSONRequestSerializer serializer];
            [mgr.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            break;
        default:
            mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
            break;
    }
    // 3.设置超时时间为10s
    mgr.requestSerializer.timeoutInterval = 10;
    switch (request.methodType) {
        case MSRequestMethodGet:
        {
            [mgr GET:request.url parameters:request.params progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    NSDictionary *dictData = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
                    success((NSHTTPURLResponse *)task.response,dictData);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }break;
        case MSRequestMethodPost:
        {
            [mgr POST:request.url parameters:request.params progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    NSDictionary *dictData = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
                    success((NSHTTPURLResponse *)task.response,dictData);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }break;
        case MSRequestMethodPut:
        {
            [mgr PUT:request.url parameters:request.params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    NSDictionary *dictData = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
                    success((NSHTTPURLResponse *)task.response,dictData);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }break;
        case MSRequestMethodDelete:
        {
            [mgr DELETE:request.url parameters:request.params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    NSDictionary *dictData = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
                    success((NSHTTPURLResponse *)task.response,dictData);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }break;
        default:
        {
            [mgr GET:request.url parameters:request.params progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    NSDictionary *dictData = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
                    success((NSHTTPURLResponse *)task.response,dictData);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }break;
    }
    
}

+ (void)uploadImg:(UIImage *)image url:(NSString *)url success:(void (^)(NSHTTPURLResponse *response, id responseObject))success failure:(void (^)(NSError *error))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //接收类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         @"multipart/form-data",
                                                         nil];
    NSURLSessionDataTask *task;
    task = [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {

        NSData *imageData =UIImageJPEGRepresentation(image,1);

        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat =@"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];

        //上传的参数(上传图片，以文件流的格式)
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"multipart/form-data"];
    } progress:^(NSProgress *_Nonnull uploadProgress) {
        //打印下上传进度
    } success:^(NSURLSessionDataTask *_Nonnull task,id _Nullable responseObject) {
        //上传成功
        if (success) {
            success((NSHTTPURLResponse *)task.response,responseObject);
        }
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        //上传失败
        if (failure) {
            failure(error);
        }
    }];
    
//    NSError* error = NULL;
//    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        NSData* imageData = UIImageJPEGRepresentation(image, 1.0);
//        [formData appendPartWithFileData:imageData name:@"file" fileName:@"someFileName" mimeType:@"multipart/form-data"];
//    } error:&error];
//    // 可在此处配置验证信息
//    NSString *headStr=[NSString stringWithFormat:@"multipart/form-data; boundary=%@",@"----WebKitFormBoundaryAwuNdVxewoEkvnFr"];
//    [request setValue:headStr forHTTPHeaderField:@"Content-Type"];
//
//    // 将 NSURLRequest 与 completionBlock 包装为 NSURLSessionUploadTask
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//        if (!error) {
//            if (success) {
//                success((NSHTTPURLResponse *)response,responseObject);
//            }
//        }
//    }];
//    [uploadTask resume];
}
+ (void)uploadImgs:(NSArray *)images url:(NSString *)url success:(void (^)(NSHTTPURLResponse *response, id responseObject))success failure:(void (^)(NSError *error))failure{
    if (images==nil||images.count==0){
        if (failure) {
            failure(nil);
        }
        return;
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //接收类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         @"multipart/form-data",
                                                         nil];
    NSURLSessionDataTask *task;
    task = [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        for(int i=0;i<images.count;i++){
            UIImage *image = images[i];
            image = [UIImage imageByScalingToMaxSize:image];
            NSData *imageData =UIImageJPEGRepresentation(image,1);
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            formatter.dateFormat =@"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@_%@.jpg", str,@(i)];
            
            //上传的参数(上传图片，以文件流的格式)
            [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"multipart/form-data"];
        }
        
    } progress:^(NSProgress *_Nonnull uploadProgress) {
        //打印下上传进度
    } success:^(NSURLSessionDataTask *_Nonnull task,id _Nullable responseObject) {
        //上传成功
        if (success) {
            success((NSHTTPURLResponse *)task.response,responseObject);
        }
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        //上传失败
        if (failure) {
            failure(error);
        }
    }];
    
}
@end
