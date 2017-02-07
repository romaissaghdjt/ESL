//
//  Contact.h
//  ESL
//
//  Created by eyou on 16/9/8.
//  Copyright © 2016年 cl. All rights reserved.
//

#ifndef Contact_h
#define Contact_h

#define SCREEN_SCALE ([[UIScreen mainScreen] bounds].size.width/375)
#define SCREEN_DCALE ([[UIScreen mainScreen] bounds].size.height/667)

#define KWIDTH  [UIScreen mainScreen].bounds.size.width
#define KHEIGHT [UIScreen mainScreen].bounds.size.height

#define ZXColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

#define kUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define PREURL @"http://ess8222.nbeysx.com/ashx/"

#define IOS7_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )

#define Login_Suc @"succeed"

#define SH [UIScreen mainScreen].bounds.size.height
#define SW [UIScreen mainScreen].bounds.size.width
//本地的用户账号密码
#define us [[NSUserDefaults standardUserDefaults]objectForKey:@"us"]
#define pw [[NSUserDefaults standardUserDefaults]objectForKey:@"pw"]

#define defaultImg [UIImage imageNamed:@"Unselected"]
#define seletedImg [UIImage imageNamed:@"Selected"]

#define  KEY_USERNAME_PASSWORD @"com.company.app.usernamepassword"
#define  KEY_USERNAME @"com.company.app.username"
#define  KEY_PASSWORD @"com.company.app.password"

#define WK(weakSelf) \
__weak __typeof(&*self)weakSelf = self;

#ifdef DEBUG //处于开发阶段  
#define XHLog(...) NSLog(__VA__ARGS__)
#else//处于发布阶段
#define NSLog(...)
#endif

#define KUUID [UUID getUUID]


#define SWIDTH_SCALE ([[UIScreen mainScreen] bounds].size.width/375)
#define SHEIGHT_DCALE ([[UIScreen mainScreen] bounds].size.height/667)
//#define KUUID [JPUSHService registrationID]//真机
#define APPID @"2016110202473874"
#define PRIVATEKEY @"MIICXQIBAAKBgQDL36b831NZdYHMD+LoQ0XtgU8WGRxTFHSXBR0fPCBqPeuKEvIBe7Ok9wyGReAmbB5rNz5fKsMTGzv1YpR3VFP58HyOMsBriGiQvOir983gtSx2n5N3tm/4YNKEmSYci36S85Y0VdcyR5f4dK+JLadqN8nvDctJAf70qQAFSwL5hwIDAQABAoGAMKjO2GgNIrrzIdtg0wLLe+ZzE9kmc4XcVfc4fi4Bppnkz+25qTT3KZZ1fM7Msx73G6vxzRENwk+rveOrf9e2uvHhfKghyhkTewir5jnU4ewP8ibvw359E7z2iM6Xfkmy+sHeLfEgeObpYzXUx+Z+8tTK16HnnCZyAFXxZNhFA4ECQQDpJUR6AH0IriV0i/GGGgzgGp9hYeNm/zNwNuYrPNWxjwW2T1JvUfBqF7uExRyGo19OWTiRrGLpQ62I0arVCpqnAkEA39vQB2X6sabopS0OJTBQEajU7+6RsAZBIDqi9fEvAKuPH7yoGz7h1qe2F6+LEpffg1IRgFsG/eN13lPzMhXmIQJBALWqXlMaMlMjLvhDWyz8+29cDziYR9Mno3Mas/qY6oHySacm47ruBAEHAQyRcorOniK0jsmjo2bTX1Ku3QgnvR0CQQCSm5o1jjNOL9rDeqt97ZMyzZiPfnYJiz8RxXU+j3NSBAmbJmoOVfOAKpxWDNCPH8nxbkkp//OnSVXDgsWOcsshAkBwVcqH0APlDn89FaCk3icz0yQ8h8/ZOpD9WbqVrmGkwvR/8ojsxXzB2rVdrGQ/ab1VPo7gOpgjxM0KYTRYWDl6"
#endif /* Contact_h */
