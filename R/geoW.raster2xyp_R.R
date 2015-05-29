#' geoW.raster2xyp_R
#'
#' geoW.raster2xyp_R
#' @param b
#' @keywords geoW
#' @export
#' @examples
#' geoW.raster2xyp_R()
geoW.raster2xyp_R<-function(b) {
   c <- matrix(0,nc=ncol(b),nr=nrow(b))
   d <- matrix(0,nc=nrow(b),nr=ncol(b))
   #transform the matrix to be able to plot the raster using the function image()
   for (i in 1:nrow(b)) {
      for (j in 1:ncol(b)) {
         indice<-ncol(b)-j+1
         c[i,indice]<-b[i,j] 
      }
   }

   #format min(x,y) : bottom left; max(x,y) : top right
   for (i in 1:ncol(b)) {
      for (j in 1:nrow(b)) {
         indice<-(ncol(b)-i+1)
         d[i,j]<-c[j,indice]
      }
   }
   
   nr_raster<-nrow(b)
   nc_raster<-ncol(b)
   results<-rep(NA,nc_raster*nr_raster)
   for (i in 1:nc_raster) {
      for (j in 1:nr_raster) {
         indice<-(j+(i-1)*nr_raster)         
         results[indice]<-d[i,j]
      }
   }

   return(results)
}
