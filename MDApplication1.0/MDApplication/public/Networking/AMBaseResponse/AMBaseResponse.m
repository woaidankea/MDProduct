//
//  AMResponse.m
//  AMen
//
//  Created by 曾宏亮 on 15/10/30.
//  Copyright © 2015年 gaoxinfei. All rights reserved.
//

#import "AMBaseResponse.h"
#import "MDPublicConfig.h"
@implementation AMBaseResponse

-(BOOL) isSucceed{
    if(ServerJieKu){
    return self.statusCode==0|| self.statusCode == 1023||self.statusCode == 1024||self.statusCode==1010;
    }
        
    return self.statusCode==0;
}

@end
