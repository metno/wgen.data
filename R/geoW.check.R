#' geoW.check
#'
#' geoW.check
#' @param geoW
#' @param variable
#' @param percentage
#' @param SIM
#' @param OUTLIER
#' @keywords geoW
#' @export
#' @examples
#' geoW.check()
geoW.check<-function(geoW,variable,percentage=30,SIM,OUTLIER) {

   #keep timestep with not more than p% of NA
   keep_col<-which(colMeans(is.na(geoW$values))<percentage/100)
      
   #keep pixel/gages with not more than p% of NA
   keep_row<-which(rowMeans(is.na(geoW$values))<percentage/100)

   #only zeros
   zero_col<-which(colMeans(geoW$values,na.rm=TRUE)==0) 
   zero_row<-which(rowMeans(geoW$values,na.rm=TRUE)==0)   
   
   if (OUTLIER) {} #outlier detection to be included
   
   #Conditioned simulation on NAs by using the easiest method of CS
   #To be improved
   if (SIM) tmp<-simulation.cs.easiest(geoW=geoW,variable=variable,SPATIAL=TRUE)
   
   results<-geoW
   results$values<-tmp
   results$keep<-list(keep_col=keep_col,keep_row=keep_row)
   results$zero<-list(zero_col=zero_col,zero_row=zero_row)
   return(results)
   
}   