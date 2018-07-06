# Max Shvayuk Embedded BaseCamp 
###**Description to second tasks**
I created a program, which can resize the image.  
To compile it, you should previously install [GraphicsMagick API](http://www.graphicsmagick.org/README.html) to your system.
If you use *ArchLinux*, you just need to run   
__sudo pacman -S graphicsmagick__.   
![](https://upload.wikimedia.org/wikipedia/ru/d/de/GraphicsMagick-Logo.png)  
After this, compile program using *gcc*:  
__`gcc -o resize_image_O2 resize_image.c -O2` \`GraphicsMagickWand-config --cppflags --ldflags --libs\`__  
You can use different levels of optimization, changing a number in flag _-O**X**_ , where *__X__* may acquire the values _(0, 1, 2, 3, s)_.  
Also you can use **Makefile** to built a program.  
Just run **make** in terminal in folder with source file __resize_image.c__ and __Makefile__.

To run the program, usage:  
__./`program_name <path_to_source_image> <path_to_output_image> <width_output_image> <height_output_image>`__
