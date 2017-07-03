
#import "Database.h"
#import <sqlite3.h>

sqlite3 *database;
@implementation Database
@synthesize rowID;



#pragma mark getInitConferenceData
+	(void)	createTable:(NSString *)dbPath
{
	@try
    {
		
        if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK)
        {
            NSString *DB_Calculator = @"CREATE TABLE IF NOT EXISTS VideoSalsa(ID INTEGER PRIMARY KEY NOT NULL ,Name VARCHAR,VideoId VARCHAR,Date VARCHAR,Image VARCHAR,Duration Numeric,WatchVideoFlag Numeric,IsdeleteFlag Numeric)";
            if(sqlite3_exec(database, [DB_Calculator UTF8String],NULL,NULL,NULL) == SQLITE_OK)
            {
                //NSLog(@"DB_Calculator Table Create");
            }
            
        }
        else
        {
            sqlite3_close(database); //Even though the open call failed, close the database connection to release all the memory.
        }
		
	}
	
    @catch (NSException * e) {
		//NSLog(@"%@",e);
	}
	
	
}
- (id) initWithPrimaryKeyForEvent:(NSInteger) pk {
	
	//[super init];
	rowID = pk;
	
	return self;
}


+ (void) copyDatabaseIfNeeded {
    
    //Using NSFileManager we can perform many file system operations.
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    
    NSString *dbPath = [Database getDatabasePath];
    BOOL success = [fileManager fileExistsAtPath:dbPath];
    
    if(!success) {
        
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"test.sqlite"];
        
        success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
        if (!success)
            NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
}


+(NSString* )getDatabasePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"test.sqlite"];
    NSLog(@"writableDBPath >> %@",writableDBPath);
    return writableDBPath;
}

+(NSMutableArray *)executeQuery:(NSString*)str{

	sqlite3_stmt *statement= nil;
	sqlite3 *database;
	NSString *strPath = [self getDatabasePath];
	NSMutableArray *allDataArray = [[NSMutableArray alloc] init];
	if (sqlite3_open([strPath UTF8String],&database) == SQLITE_OK) {
		if (sqlite3_prepare_v2(database, [str UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			

			while (sqlite3_step(statement) == SQLITE_ROW) {
							NSInteger i = 0;
				NSInteger iColumnCount = sqlite3_column_count(statement);
				NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
				while (i< iColumnCount) {
					NSString *str = [self encodedString:(const unsigned char*)sqlite3_column_text(statement, i)];
					
					
				NSString *strFieldName = [self encodedString:(const unsigned char*)sqlite3_column_name(statement, i)];
					
					[dict setObject:str forKey:strFieldName];
					i++;
				}
				
				[allDataArray addObject:dict];
			}
		}

		sqlite3_finalize(statement);
	} 
	sqlite3_close(database);
	return allDataArray;
}
+(NSString*)encodedString:(const unsigned char *)ch
{
	NSString *retStr;
	if(ch == nil)
		retStr = @"";
	else
		retStr = [NSString stringWithCString:(char*)ch encoding:NSUTF8StringEncoding];
	return retStr;
}


+(BOOL)executebulkinsert:(NSArray *)arr {
   
    char* errorMessage;
    BOOL success = NO;
    sqlite3_stmt *insert_statement = nil;
    sqlite3_exec(database, "BEGIN EXCLUSIVE TRANSACTION", NULL, NULL, &errorMessage);

    
    if (arr == nil) {
        return success = NO;
    }
    
    const char *insertsql = "insert into VideoSalsa (Id, Name, VideoId, Date, Image, Duration, WatchVideoFlag, IsdeleteFlag) VALUES (?,?,?,?,?,?,1,1)";
    
    if (insert_statement == nil) {
        
        if (sqlite3_prepare_v2(database, insertsql, -1, &insert_statement, NULL) != SQLITE_OK) {
            
            NSAssert1(0, @"Error: failed to perpare statement with message '%s'.", sqlite3_errmsg(database));
            return success = NO;
        }
        else {
            //sqlite3_bind_text(insert_statement, 1, [dboObject.Pk_id UTF8String], -1, SQLITE_TRANSIENT);
            
            for (unsigned i = 0; i < [arr count]; i++) {
            sqlite3_bind_text(insert_statement, 1, [[[arr objectAtIndex:i] objectForKey:@"id"] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(insert_statement, 2, [[[arr objectAtIndex:i] objectForKey:@"name"] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(insert_statement, 3, [[[arr objectAtIndex:i] objectForKey:@"videoid"] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(insert_statement, 4, [[[arr objectAtIndex:i] objectForKey:@"updated"] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(insert_statement, 5, [[[arr objectAtIndex:i] objectForKey:@"thumb"] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(insert_statement, 6, [[[arr objectAtIndex:i] objectForKey:@"duration"] UTF8String], -1, SQLITE_TRANSIENT);
                
                double retValue = sqlite3_step(insert_statement);
                if (retValue == SQLITE_DONE)
                    success = YES;
                
                sqlite3_reset(insert_statement);
                
            }
           
        }
    }
   
    sqlite3_reset(insert_statement);
    sqlite3_finalize(insert_statement);
    sqlite3_exec(database, "COMMIT TRANSACTION", NULL, NULL, &errorMessage);
    sqlite3_close(database);
    insert_statement = nil;
    return success;
}
/*
+(BOOL)executebulkinsert :(NSArray *)arr
{
    char* errorMessage;
    BOOL fRet = NO;
    sqlite3_exec(database, "BEGIN EXCLUSIVE TRANSACTION", NULL, NULL, &errorMessage);
    char buffer[] = "insert into VideoSalsa (Id, Name, VideoId, Date, Image, Duration, WatchVideoFlag, IsdeleteFlag) values(?,?,?,?,?,?,1,1)";
    
   // @"insert into VideoSalsa (Id, Name, VideoId, Date, Image, Duration, WatchVideoFlag, IsdeleteFlag) values('%@','%@','%@','%@','%@','%@',1,1)"
    
    sqlite3_stmt* stmt;
    sqlite3_prepare_v2(database, buffer, strlen(buffer), &stmt, NULL);
    for (unsigned i = 0; i < [arr count]; i++) {
        
         sqlite3_bind_int(stmt, 1, [[[arr objectAtIndex:i] objectForKey:@"id"] integerValue]);
        //(stmt, 1, [[[arr objectAtIndex:i] objectForKey:@"id"] UTF8String], -1, SQLITE_TRANSIENT);
         sqlite3_bind_text(stmt, 2, [[[arr objectAtIndex:i] objectForKey:@"name"] UTF8String], -1, SQLITE_TRANSIENT);
         sqlite3_bind_text(stmt, 3, [[[arr objectAtIndex:i] objectForKey:@"videoid"] UTF8String], -1, SQLITE_TRANSIENT);
         sqlite3_bind_text(stmt, 4, [[[arr objectAtIndex:i] objectForKey:@"updated"] UTF8String], -1, SQLITE_TRANSIENT);
         sqlite3_bind_text(stmt, 5, [[[arr objectAtIndex:i] objectForKey:@"thumb"] UTF8String], -1, SQLITE_TRANSIENT);
         //sqlite3_bind_text(stmt, 6, [[[arr objectAtIndex:i] objectForKey:@"duration"] UTF8String], -1, SQLITE_TRANSIENT);
        
        sqlite3_bind_int(stmt, 6, [[[arr objectAtIndex:i] objectForKey:@"duration"] integerValue]);
        //(stmt, 6, [[[arr objectAtIndex:i] objectForKey:@"duration"] UTF8String], -1, SQLITE_TRANSIENT);
        
//       // std::string id = getID();
//       // sqlite3_bind_text(stmt, 1, id.c_str(), id.size(), SQLITE_STATIC);
//        sqlite3_bind_double(stmt, 2, getDouble());
//        sqlite3_bind_double(stmt, 3, getDouble());
//        sqlite3_bind_double(stmt, 4, getDouble());
//        sqlite3_bind_int(stmt, 5, getInt());
//        sqlite3_bind_int(stmt, 6, getInt());
//        sqlite3_bind_int(stmt, 7, getInt());
        if (sqlite3_step(stmt) != SQLITE_DONE) {
            printf("Commit Failed!\n");
        }
        else
        {
            fRet =YES;
        }
        sqlite3_reset(stmt);
    }
    sqlite3_exec(database, "COMMIT TRANSACTION", NULL, NULL, &errorMessage);
    sqlite3_finalize(stmt);
    return fRet;
}
*/
 
+(BOOL)executeScalarQuery:(NSString*)str{
	
    sqlite3_stmt *statement= nil;
	sqlite3 *database = NULL;
	BOOL fRet = NO;
    char* errorMessage;
    //sqlite3_exec(database, "BEGIN TRANSACTION", NULL, NULL, &errorMessage);

	NSString *strPath = [self getDatabasePath];
	if (sqlite3_open([strPath UTF8String],&database) == SQLITE_OK) {
		if (sqlite3_prepare(database, [str UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_DONE)
            {
				fRet =YES;
               NSLog(@"Done Dona Done");
            }
            else
            {
                NSLog(@"step failed: %s", sqlite3_errmsg(database));
            }
		}
		
        
        
		sqlite3_finalize(statement);
	}
   // sqlite3_exec(database, "COMMIT TRANSACTION", NULL, NULL, &errorMessage);
	sqlite3_close(database);
	return fRet;
}




@end
