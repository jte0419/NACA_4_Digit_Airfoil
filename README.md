# NACA_4_Digit_Airfoil

This repository contains the code used to generate NACA 4-digit airfoil coordinate files.  As this is coded as a GUI, it contains both the *.m* and *.fig* files.  If you want to run the code, you will need to download both [GUI_NACA_4_Digit_Airfoil.m](GUI_NACA_4_Digit_Airfoil.m) and [GUI_NACA_4_Digit_Airfoil.fig](GUI_NACA_4_Digit_Airfoil.fig), and place them in the same directory/folder.  Then you will open the *.m* file and run it.  With the default values given in the GUI upon startup, you should be able to simply press **Plot Airfoil**, and the NACA 0012 will appear.  Again, without changing any values, you should be able to press **Save Data**, and the coordinate file will be saved as *NACA.txt* to the directory that the code is located in.

For in-depth descriptions of the different aspects of the GUI, see the sections below.  The X and Y values are normalized by the chord length.  This is also a useful way to save coordinate files, as you can multiply both the X and Y values by the chord length you desire, while still having only a single coordinate file for each airfoil.

## YouTube Videos

I have made some YouTube videos regarding the math behind the airfoil, as well as how to code it in MATLAB as both a simple script, and in a GUI.

For a video on the math behind the airfoils, click [here](https://www.youtube.com/watch?v=6pt8Uolfj0M).

For a video on coding a simple script, click [here](https://www.youtube.com/watch?v=QezOan1pVgs).

For a 10-video series on creating this GUI, click [here for video 1](https://www.youtube.com/watch?v=iQ1-C6c3YyA).  Note that the code you can download here is slightly different than that in the videos because I have made some updates.  It's nothing major, and you will still be able to follow along.  You can go to the next video in the series after the first one ends, or by going to my [channel page](https://www.youtube.com/user/JoshTheEngineer).

## Airfoil

This is a 4-digit airfoil program, and as such, you will need to specify only 4 digits.  Any more or less and the program will give you an error.  For the two most well-known airfoils, try *0012* (symmetric) and *2412* (cambered).

## Angle of Attack (AoA)

The angle of attack (AoA) setting is there solely for visualization purposes.  The coordinate files are not affected by the AoA.  If you are using the coordinate files in a panel code, then you do not want the AoA in the coordinate file; it should be set in the panel code itself.  This way, you can use the same airfoil coordinate file for any AoA.

## Grid Points

This value specifies the number of grid points to use for the upper surface and lower surface.  That is, if you specify 10 grid points, there will be 10 points for the upper surface and 10 points for the lower surface, not 10 points total.  The minimum number of grid points you can use is three.  If you were to use two, the resulting airfoil would be a line.  With three points, the airfoil will actually be a diamond shape with a little thickness.  Needless to say, you should use larger values of grid points if you want to be able to resolve the shape accurately.

## Grid Type

You can specify either a uniform or non-uniform grid type.  The uniform grid type splits the X values of the airfoil evenly from 0 to 1.  The non-uniform grid type clusters more points at the leading edge (LE) and trailing edge (TE) of the airfoil.  This allows you to resolve the LE and TE better for the same amount of data points.  This is particularly useful in the vortex panel method, where the pressure coefficient is highly dependent on accuracy at the LE and TE.  I would always recommend using the non-uniform grid type.

## Trailing Edge

This option allows you to specify whether the trailing edge of the airfoil is closed or open.  If it is closed, then the last point on both the upper and lower surfaces have the same X and Y values.  If it is open, then the last point on both upper and lower surfaces have the same X value, but a different Y value (the lower is the negative of the upper).  If you plan on laser cutting some ribs for a model plane, I would recommend using an open trailing edge, as it's not as easy to break them.

## Plot As

This feature allows you to switch between plotting the airfoil as (1) a line, (2) circles, (3) dots, or (4) a filled polygon.  When plotting as a line, you can see how smooth the surfaces look.  When plotting with dots, you can see the clustering from the grid type much better.  The filled polygon just looks nice.

## Show Camber Line

If toggled on, the plot will display the camber line in red.  This just shows the curvature of the airfoil.  It is not used when saving the coordinate file, and is purely for visualization.

## Plot Airfoil

When this button is pressed, the airfoil coordinates will be computed and displayed in the plot, based off the inputs currently selected in the fields above the button.  If you change any of the inputs, you will need to press this button to recompute the airfoil and display it again.  When an airfoil is plotted, the **Save Data** button will become enabled.  This push button will not be enabled (will be grayed out) if the airfoil entered is a not 4 digits, or if the number of grid points is two or less.

## Save Filename

This is the filename that you wish to save the coordinates to.  There is always a single header line to indicate which column is X and which is Y.  There is no directory in the file name; it will be saved in the same directory that the code is located in.  If you need it somewhere else, you can either update the MATLAB code to include a directory, or you can copy-paste the output file.

## Save Type

There are two options here.  The first starts from the LE (0,0), outputs along the upper surface to the TE (X = 1), then back along the lower surface to the LE.  The second options starts from the TE (X = 1), outputs along the upper surface to the LE, then back along the lower surface to the TE.  Either option is fine, depending on what program you are using next.

## Save Data

By pressing this button, the file you specified will be created, and you can use it in any other program you desire.
