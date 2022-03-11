#import <Foundation/Foundation.h>
#import "Dota_infoTests-Swift.h"

__attribute__((constructor))
void CucumberishInit()
{
    [CucumberishInitializer setupCucumberish];
}
