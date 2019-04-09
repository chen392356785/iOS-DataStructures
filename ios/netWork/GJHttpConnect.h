
#import <Foundation/Foundation.h>
//#import "zlib.h"

@class GJHttpConnect;
@class YAJLDocument;

@protocol GJHttpConnectDelegate			//futherInfo存在的意义在于在开始和结束网络之间传递数据，不过必须保证该指针在这个整个过程中都不会成为野指针。

//@required
//- (void)httpConnect:(GJHttpConnect*)httpConnect successDownloadData:(id)data withFutherInfo:(void*)futherInfo;
//- (void)httpConnectDownloadDataFailed:(GJHttpConnect*)httpConnect withFutherInfo:(void*)futherInfo;
//- (void)httpConnectDownloadDataTimeOut:(GJHttpConnect*)httpConnect withFutherInfo:(void*)futherInfo;

@optional
- (void)httpConnect:(GJHttpConnect*)httpConnect downloadedSize:(long long)dSize expectedSize:(long long)eSize;
- (void)httpConnect:(GJHttpConnect *)httpConnect didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite;

@end

@interface GJHttpConnect : NSObject {
	NSMutableURLRequest *connectionRequest;
    NSURLConnection *urlConnection;
    NSMutableData *connectionData;
	
	NSDictionary *responseHttpHeaderFields;
	NSInteger responseStatusCode;
	long long httpConnectExpectedSize;
	
	id target;
	SEL successAction;
	SEL failedAction;
	SEL timeoutAction;
	
	void* furtherInfo;
	
	id<GJHttpConnectDelegate> delegate;
	bool jsonEncode;
	bool gzipEncode;
	NSString* downloadURL;
	
	//json
	YAJLDocument *document;
	bool jsonDecodeFinished;
	bool jsonDecodeStarted;
    
    NSInteger errorCode;
    bool longConnect;
}

@property(nonatomic,assign) id<GJHttpConnectDelegate> delegate;
@property(nonatomic) bool jsonEncode;									//该标志位意味着在网络的传输过程中会对于整个数据串进行json解析
@property(nonatomic) bool gzipEncode;									//该标志位意味着json解析会在整个数据传输结束后才进行解析（应用中一般说明数据串被压缩了）

@property(nonatomic) NSInteger errorCode;
@property(nonatomic) bool longConnect;


- (void)setTarget:(id)target1 withSuccessAction:(SEL)action1 withFailedAction:(SEL)action2 withTimeOutAction:(SEL)action3;	//除了使用协议来回调之外，还可以使用target-action的方式来回调相关的处理。


- (void)preCreateConnectRequestWithURL:(NSString *)urlString;
- (void)setHttpBody:(NSData*)postData;
- (void)setHttpMethod:(NSString*)methodString;
- (void)setHttpHeader:(NSDictionary*)allHeadInfo;


- (void)startCreatedConnectWithFurtherInfo:(void*)exterInfo;
//no use
//- (BOOL)startConnection:(NSString *)urlString withFurtherInfo:(void*)exterInfo;
- (void)endConnection;
- (void)cancelConnection;


- (NSString*)reponseHeadInfoWithField:(NSString*)field;
- (NSInteger)reponseStatusCode;
//lixj no use
//- (NSData*)getUrlFinalData;
@end
