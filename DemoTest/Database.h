

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "AppDelegate.h"

@interface Database : NSObject
{
	
	NSInteger rowID;
}
@property(nonatomic)NSInteger rowID;


+ (void) createTable:(NSString *)dbPath;
+(NSString* )getDatabasePath;
+(NSMutableArray *)executeQuery:(NSString*)str;
+(NSString*)encodedString:(const unsigned char *)ch;
+(BOOL)executeScalarQuery:(NSString*)str;
+(BOOL)executebulkinsert :(NSArray *)arr;
+ (void) copyDatabaseIfNeeded ;

@end
