#import <Foundation/Foundation.h>
#import "cmdline.h"

int main(int argc, const char* argv[])
{
    int ret = -1;
    if (argc > 1)
    {
        ret = cmdline_main(argc, argv);
    }
    
    if (ret == -1)
    {
        fprintf(stderr, "Commandline options\n"
                "  --width       (-w)  Width\n"
                "  --height      (-h)  Height\n"
                "  --scale       (-s)  Scale (2.0 = Retina, default=current)\n"
                "  --bits        (-b)  Color depth (default=current)\n"
                "  --freq        (-f)  Frequency (default=none)\n"
                "  --interlaced  (-i)  Interlaced flag (default=off)\n"
                "  --display     (-d)  Select display # (default=main)\n"
                "  --rotation    (-r)  Rotation angle 0,90,180,270 (default=current)\n"
                "  --displays    (-ld) List available displays\n"
                "  --modes       (-lm) List available modes\n"
                "  --commands    (-lc) List available command-lines\n"
                "\n");
    }
}
