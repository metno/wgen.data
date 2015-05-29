#' geoW.read_ncdf4
#'
#' geoW.read_ncdf4
#' @param path
#' @param file_name
#' @param variable
#' @param west_coord
#' @param east_coord
#' @param south_coord
#' @param north_coord
#' @param origin  "2014-03-05", tz = "GMT", ok for eraInterim netcdf4 from Norwegian Meteorological Institute convert from ECMWF grib
#' @keywords geoW
#' @export
#' @examples
#' geoW.read_ncdf4()
geoW.read_ncdf4<-function(path,file_name,variable,west_coord,east_coord,south_coord,north_coord, origin="2014-03-05") {

   ftxt<-paste(path,file_name,sep="")					
   a <- nc_open(ftxt, verbose = FALSE, write = FALSE)
   lat<-ncvar_get(a,"latitude")
   long<-ncvar_get(a,"longitude")
   time <- ncvar_get(a,"time")
   
   cellsize<-abs(lat[2]-lat[1])
   if (is.null(south_coord)) south_coord<-min(lat)
   if (is.null(north_coord)) north_coord<-max(lat)
   if (is.null(west_coord)) west_coord<-min(long)
   if (is.null(east_coord)) east_coord<-max(long)
   
   ymin_ncdf<-south_coord
   ymax_ncdf<-north_coord
   xmin_ncdf<-west_coord
   xmax_ncdf<-east_coord
     
   #west_ind<-round((xmin_ncdf+180)/cellsize)+1
   #east_ind<-round((xmax_ncdf+180)/cellsize)+1
   #north_ind<-round((ymax_ncdf+90)/cellsize)+1
   #south_ind<-round((ymin_ncdf+90)/cellsize)+1
   west_ind<-round((xmin_ncdf-min(long))/cellsize)+1
   east_ind<-round((xmax_ncdf-min(long))/cellsize)+1
   north_ind<-round((ymax_ncdf-min(lat))/cellsize)+1
   south_ind<-round((ymin_ncdf-min(lat))/cellsize)+1
   
   Nx<-abs(west_ind-east_ind)
   Ny<-abs(south_ind-north_ind)
   
   # date Timeserie
   dateTS <- as.POSIXct(time, origin = origin, tz = "GMT")    #ok for eraInterim Norwegian Meteorological Institute, to be checked for other dataset
   dateTS<-sub( "[[:punct:]]", "",sub( "[[:punct:]]", "",dateTS))
   dateTS<-strptime(dateTS, "%Y%m%d %H:%M:%OS")
   Nt<-length(dateTS)
   
   #ncdf x,y,v format
   ncdf.grid<-matrix(NA,ncol=3,nrow=Ny*Nx)
   colnames(ncdf.grid)<-c('x','y','v')

   ncdf.grid[,1]<-rep(seq(xmin_ncdf+cellsize/2,xmin_ncdf+cellsize*Nx,cellsize),Ny)
   ncdf.grid[,2]<-rep(seq(ymin_ncdf+cellsize*Ny-cellsize/2,ymin_ncdf+cellsize/2,-1*cellsize),each=Nx)
  
   if (length(attributes(a$dim)$names)==4) {
      tmp<-ncvar_get(a,variable,start=c(west_ind,south_ind,1,1),count=c(Nx,Ny,1,Nt))
   } else tmp<-ncvar_get(a,variable,start=c(west_ind,south_ind,1),count=c(Nx,Ny,Nt))	  
   
   xyvTS<-matrix(NA,nr=Nx*Ny,nc=Nt)
   
   #time consuming   
   for (i in 1: Nt) {  
      xyvTS[,i]<-geoW.raster2xyp_R(b=as.matrix(tmp[,,i]))        	  
   }  

   results<-list(xyvTS=xyvTS,
              ncdf.grid=ncdf.grid[,1:2],
			  cellsize=cellsize,
              xMin=ymin_ncdf,
   			  xMax=xmax_ncdf,
   			  yMin=ymin_ncdf,
   			  yMax=ymax_ncdf,
   			  Ny=Ny,
   			  Nx=Nx,
			  dateTS=dateTS)

   nc_close(a)
   
   return(results)   
}
