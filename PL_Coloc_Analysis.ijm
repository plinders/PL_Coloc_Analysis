


name_input = getImageID();

var old_height;
var new_height;
var old_width;
var new_width ;

var y_coord;
var x_coord;
getSelectionBounds(x_coord,y_coord,old_width,old_height);
print("1",x_coord,y_coord,old_width,old_height);

	new_width = old_width;
	new_height = old_height;

if (old_width > old_height) { 
	//old_height = height;
	new_height =old_width;
	new_width = old_width;
	y_coord = (y_coord - 0.5*(new_height - old_height));
} 



if (old_height > old_width) {
	//width = old_width;
	new_width = old_height;
	new_height = old_height;
	x_coord = x_coord - 0.5*(new_width-old_width);
}

print("2",x_coord,y_coord,new_width,new_height);
makeRectangle(x_coord, y_coord, new_width, new_height);

Stack.getDimensions(X,Y,Channels,T,Z);
newImage("HyperStack", "16-bit color-mode", new_width, new_height, Channels, 1, 1);
name_new= getImageID();


for(i=1; i <= Channels;i++){
selectImage(name_input);
setSlice(i);
run("Copy");
selectImage(name_new);
setSlice(i);
run("Paste");
run("Enhance Contrast", "saturated=0.35");
};
selectImage(name_input);
setSlice(1);
selectImage(name_new);
setSlice(1);

/*
 * Clear circle in middle of 70% dimensions
 */

run("In [+]");
run("In [+]");
run("In [+]");
run("In [+]");
run("In [+]");
run("In [+]");

setTool("oval");
beep();
selectWindow("HyperStack");
waitForUser("Select ROI to clear");
setBackgroundColor(0, 0, 0);
run("Clear", "stack");

run("Polar Stack");

setSlice(1);
setThreshold(5, 1366);
run("Create Selection");
run("Size...", "width=360 height=1 average interpolation=Bilinear");
run("Split Channels");
run("Coloc 2", "channel_1=C1-resultPolar.tif channel_2=C2-resultPolar.tif roi_or_mask=<None> spearman's_rank_correlation manders'_correlation psf=3 costes_randomisations=10");
selectWindow("HyperStack");
close();
selectWindow("C4-resultPolar.tif");
close();
selectWindow("C3-resultPolar.tif");
close();
selectWindow("C2-resultPolar.tif");
close();
selectWindow("C1-resultPolar.tif");
close();
selectWindow("Log");

