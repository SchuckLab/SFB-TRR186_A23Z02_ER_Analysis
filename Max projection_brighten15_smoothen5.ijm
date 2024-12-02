//open images from a given directory
	setBatchMode(true);
	dir = getDirectory("Choose a Directory");
	list = getFileList(dir);

// generate folders and subfolders required for further processing	
	File.makeDirectory(dir+"_MAX");
	File.makeDirectory(dir+"_MAX_bright15");
	File.makeDirectory(dir+"_MAX_bright15_smooth5");

		for (i=0; i<list.length; i++) {
			open(dir+list[i]);
			onoma=getTitle;

//run Z projection over all Z slices with maximum intensity & save
			run("Z Project...", "projection=[Max Intensity]");
		
			name1= replace(onoma,".TIF","_MAX.tif");
			save(dir+"_MAX/"+name1);

//run contrast&brightness adjutment to reach a saturation of 15.0, apply and save
			run("Enhance Contrast", "saturated=15.00");
			run("Apply LUT");
			
			name2= replace(onoma,".TIF","_MAX_bright.tif");
			save(dir+"_MAX_bright15/"+name2);
			
//run smoothing five times, then save			
			run("Smooth");
			run("Smooth");
			run("Smooth");
			run("Smooth");
			run("Smooth");

			name3= replace(onoma,".TIF","_MAX_bright15_smooth5.tif");
			save(dir+"_MAX_bright15_smooth5/"+name3);


			close("*");
	 	    }
