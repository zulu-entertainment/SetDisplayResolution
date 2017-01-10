# SetDisplayResolution
OS X command-line tool, to set the display resolution.

Source based on RetinaDisplayMenu 0.2



Command-line options:

    --width       (-w)  Width
    --height      (-h)  Height
    --scale       (-s)  Scale (2.0 = Retina, default=current)
    --bits        (-b)  Color depth (default=current)
    --freq        (-f)  Frequency (default=none)
    --interlaced  (-i)  Interlaced flag (default=off)
    --display     (-d)  Select display # (default=main)
    --rotation    (-r)  Rotation angle 0,90,180,270 (default=current)
    --displays    (-ld) List available displays
    --modes       (-lm) List available modes
    --commands    (-lc) List available command-lines


Examples:

    SetDisplayResolution -w 2560 -h 1440 -s 1 -f 60
    SetDisplayResolution -w 1920 -h 1080 -s 1 -f 50 -i
    SetDisplayResolution -d 0 -w 1920 -h 1080 -s 2
    SetDisplayResolution -r 90
