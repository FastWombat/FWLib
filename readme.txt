How to Use FWLib
================

1. Add the FWLib.xcodeproj to your project
2. In XCode Preferences, create a Sources directory called "FWLIB" that points to your FWLib source tree
3. Add these build properties

    OTHER_LDFLAGS = -ObjC -force_load $TARGET_BUILD_DIR/libFWLib.a
    USER_HEADER_SEARCH_PATHS = $(FWLIB)/**

To Do:
    Push FWLib to public (or private) repository
    
Caveats:
    Any file that JUST has categories in it will get stripped, I though force_load would fix this, but apparently not. The workaround is to
    define a throw away class in each "category" file. This is done with a macro, for example:
    
        FORCE_LINKER_TO_FIND_CATEGORY(NSManagedObjectContextExtensions);

Unanswered Questions