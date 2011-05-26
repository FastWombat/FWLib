How to Use FWLib
================

1. Add the FWLib.xcodeproj to your project
2. Add these build properties to deal with the categories properly

    OTHER_LDFLAGS = -ObjC -force_load $TARGET_BUILD_DIR/libFWLib.a

3. To find headers do one one of the following -
    
    a) In XCode Preferences, create a Sources directory called "FWLIB" that points to your FWLib source tree and add this path to the build:

        USER_HEADER_SEARCH_PATHS = $(FWLIB)/**

    b) Add the library as a submodule
        
        USER_HEADER_SEARCH_PATHS = $(PROJECT_DIR)/lib/FWLib/**

4.

Caveats:
    Any file that JUST has categories in it will get stripped, I though force_load would fix this, but apparently not. The workaround is to
    define a throw away class in each "category" file. This is done with a macro, for example:
    
        FORCE_LINKER_TO_FIND_CATEGORY(NSManagedObjectContextExtensions);

Unanswered Questions