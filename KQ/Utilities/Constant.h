

#pragma mark - Parameter

#define kTestJSONHost @"http://douban.fm/j/mine/playlist?type=n&h=&channel=0&from=mainsite&r=4941e23d79"

#define kLimit 30

#pragma mark - file


//#define kFontName @"STHeitiSC-Light"
#define kFontName @"ArialMT"
//#define kFontBoldName @"STHeitiSC-Medium"
#define kFontBoldName @"ArialMT"


#pragma mark - Key

#define kUmengAppKey @"5469be08fd98c53e5b0015b1" // 在share的时候要用到


#pragma mark - Notification

#define kNotificationLogin @"toLogin"


#pragma mark - UI


#define kColorGreen     [UIColor colorWithRed:47.0/255 green:175.0/255 blue:54.0/255 alpha:1]
#define kColorYellow      [UIColor colorWithRed:253.0/255 green:130.0/255 blue:37.0/255 alpha:1]
#define kColorLightYellow  [UIColor colorWithRed:255.0/255 green:164.0/255 blue:0.0/255 alpha:1]

#define kColorBlack     [UIColor colorWithRed:24.0/255 green:24.0/255 blue:24.0/255 alpha:1]
#define kColorDardGray  [UIColor colorWithRed:62.0/255 green:58.0/255 blue:57.0/255 alpha:1]
#define kColorGray      [UIColor colorWithRed:113.0/255 green:113.0/255 blue:113.0/255 alpha:1]
#define kColorLightGray  [UIColor colorWithRed:213.0/255 green:213.0/255 blue:213.0/255 alpha:1]
#define kColorWhite     [UIColor colorWithWhite:.97 alpha:1]
#define kColorBG        [UIColor colorWithRed:242.0/255 green:242.0/255 blue:242.0/255 alpha:1]
#define kColorRed       [UIColor colorWithRed:244.0/255 green:99.0/255 blue:56.0/255 alpha:1]
#define kColorBlue      [UIColor colorWithRed:61.0/255 green:125.0/255 blue:245.0/255 alpha:1]
#define kColorTableBG      [UIColor colorWithRed:237.0/255 green:237.0/255 blue:237.0/255 alpha:1]

#define kHNavigationbar (isPad?44.0:32.0)

#define kHPopNavigationbar (isPad?(isIOS7?44.0:36.0):32.0)


typedef void (^VoidBlock)();
typedef void (^BooleanResultBlock)(BOOL succeeded, NSError *error);
typedef void (^IntegerResultBlock)(int number, NSError *error);
typedef void (^ArrayResultBlock)(NSArray *objects, NSError *error);
typedef void (^SetResultBlock)(NSSet *channels, NSError *error);
typedef void (^DataResultBlock)(NSData *data, NSError *error);
typedef void (^DataStreamResultBlock)(NSInputStream *stream, NSError *error);
typedef void (^StringResultBlock)(NSString *string, NSError *error);
typedef void (^IdResultBlock)(id object, NSError *error);
typedef void (^DictionaryResultBlock)(NSDictionary *dict, NSError *error);
typedef void (^ProgressBlock)(int percentDone);






#pragma mark - Debug & Release


#ifdef DEBUG



#else




#endif

