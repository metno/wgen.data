#' geoW.ncdf42geoW
#'
#' geoW.ncdf42geoW
#' @param path_ncdf 
#' @param ncdf_type 
#' @param filename_1 
#' @param variable_file 
#' @param variable_ncdf 
#' @param UTM 
#' @param adm_border 
#' @param timestep 
#' @param time_resolution
#' @param origin  "2014-03-05", tz = "GMT", ok for eraInterim netcdf4 from Norwegian Meteorological Institute convert from ECMWF grib
#' @keywords geoW
#' @export
#' @examples
#' geoW.ncdf42geoW()
geoW.ncdf42geoW<-function(path_ncdf,path_results,ncdf_type,filename_1,variable_file,variable_ncdf,UTM,adm_border,timestep,time_resolution,origin="2014-03-05"){

    tmp<-geoW.read_ncdf4(path=paste(path_ncdf,ncdf_type,"/",sep=""),
                    file_name=paste(filename_1,variable_file,".nc",sep=""),
					variable=variable_ncdf[i],
					west_coord=NULL,
	                east_coord=NULL,
	                south_coord=NULL,
	                north_coord=NULL,
					origin=origin)
	  
	geoW.parameter<-list(UTM=UTM,
                         adm_border=adm_border) 
	 
    geoW.date<-list(dateTS=tmp$dateTS,
                            timestep=timestep,                 # hours  measure frequency                          !!! Detection to be made automatic !!
                            time_resolution=time_resolution )  # hours  time resolution of the phenomena measured  !!! Detection to be made automatic !!
						
    geoW.ground<-list(name=paste(ncdf_type,domain,sep=""),
                              grid=tmp$ncdf.grid,
			            	  cellsize=tmp$cellsize,
					          Nx=tmp$Nx,
					          Ny=tmp$Ny,
					          xMin=tmp$xMin,
					          yMin=tmp$yMin,
					          xMax=tmp$xMax,
					          yMax=tmp$yMax,
					          indice=seq(1,(round((tmp$xMax-(tmp$xMin))/tmp$cellsize))*(round((tmp$yMax-tmp$yMin)/tmp$cellsize))))
		
	geoW.values<-t(tmp$xyvTS)   
	
	geoW<-list(parameter=geoW.parameter,
               ground=geoW.ground,
			   values=geoW.values,
			   date=geoW.date,
			   covariate=NULL,
			   locations=NULL)
				  
    # SAVE
	#assign(paste(ncdf_type,domain,"_",variable_file[i],sep=""),geoW)
	save(geoW,file=paste(path_results,ncdf_type,domain,"_",variable_file[i],".rda",sep=""))    
	rm(tmp,geoW.parameter,geoW.date,geoW.ground,geoW.values,geoW)
	
	results<- TRUE
	return(results)
}
