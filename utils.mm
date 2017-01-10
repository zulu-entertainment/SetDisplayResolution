#import <Foundation/Foundation.h>
#import <IOKit/graphics/IOGraphicsLib.h>
#import "utils.h"

void CopyAllDisplayModes(CGDirectDisplayID display, modes_D4** modes, int* cnt)
{
    int nModes;
    CGSGetNumberOfDisplayModes(display, &nModes);
    
    if (nModes)
        *cnt = nModes;
    
    if (!modes)
        return;
    
    *modes = (modes_D4*) malloc(sizeof(modes_D4)* nModes);
    for (int i=0; i<nModes; i++)
    {
        
        CGSGetDisplayModeDescriptionOfLength(display, i, &(*modes)[i], 0xD4);
    }
}

void SetDisplayModeNum(CGDirectDisplayID display, int modeNum)
{
    CGDisplayConfigRef config;
    CGBeginDisplayConfiguration(&config);
    CGSConfigureDisplayMode(config, display, modeNum);
    CGCompleteDisplayConfiguration(config, kCGConfigurePermanently);
}

/*
 Returns the io_service_t corresponding to a CG display ID, or 0 on failure.
 The io_service_t should be released with IOObjectRelease when not needed.
 based on: https://github.com/glfw/glfw/pull/192/files
 */
io_service_t IOServicePortFromCGDisplayID(CGDirectDisplayID display)
{
    io_iterator_t iter;
    io_service_t serv, servicePort = 0;
    
    CFMutableDictionaryRef matching = IOServiceMatching(IOFRAMEBUFFER_CONFORMSTO);
    
    kern_return_t err = IOServiceGetMatchingServices(kIOMasterPortDefault, matching, &iter);
    
    if (err != KERN_SUCCESS)
        return 0;
    
    while ((serv = IOIteratorNext(iter)) != MACH_PORT_NULL)
    {
        CFDictionaryRef info;
        CFIndex vendorID = 0, productID = 0, serialNumber = 0;
        CFNumberRef vendorIDRef, productIDRef, serialNumberRef;
        Boolean success = 0;
        
        info = IODisplayCreateInfoDictionary(serv, kIODisplayOnlyPreferredName);
        
        if (CFDictionaryGetValueIfPresent(info, CFSTR(kDisplayVendorID), (const void**)&vendorIDRef))
            success = CFNumberGetValue(vendorIDRef, kCFNumberCFIndexType, &vendorID);
        
        if (CFDictionaryGetValueIfPresent(info, CFSTR(kDisplayProductID), (const void**)&productIDRef))
            success &= CFNumberGetValue(productIDRef, kCFNumberCFIndexType, &productID);
        
        if (CFDictionaryGetValueIfPresent(info, CFSTR(kDisplaySerialNumber), (const void**)&serialNumberRef))
            CFNumberGetValue(serialNumberRef, kCFNumberCFIndexType, &serialNumber);
        
        if (CGDisplayVendorNumber(display) != vendorID ||
            CGDisplayModelNumber(display) != productID ||
            CGDisplaySerialNumber(display) != serialNumber)
        {
            CFRelease(info);
            continue;
        }
        
        servicePort = serv;
        CFRelease(info);
        break;
    }
    
    IOObjectRelease(iter);
    return servicePort;
}



