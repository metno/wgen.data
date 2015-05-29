rm(list=ls())

###########################################################################
###########################################################################
##                                                                       ##
##   LIBRARIES AND DATA                                                  ##
##                                                                       ##
###########################################################################
###########################################################################

library(wgen.data)   
library(ncdf4) 


data(border_Europa)
#data(border_northEuropa)
#data(border_world)

path_ncdf<-"T:/jeanml/3-data/"
#path_ncdf<-"your/ncdf4/path/"
path_results<-"T:/jeanml/3-data/test/"
#path_results<-"your/results/path/"
dir.create(path_results, showWarnings = FALSE)

#filename architecture: filename_1+netcdf_type+variable_file+".nc"
filename_1<-"sub_interim_"
ncdf_type<-"eraInterim"
variable_file<-c("totprec","pw"   ,"totcl","u10m" ,"v10m","vimfd","t2m",
                 "t_500"   ,"t_700" ,"t_850" ,"t_925" ,
				 "u_500"   ,"u_700" ,"u_850" ,"u_925" ,
				 "v_500"   ,"v_700" ,"v_850" ,"v_925" ,
				 "rh_500"  ,"rh_700","rh_850","rh_925",
				 "sh_700","sh_850","sh_925") #"sh_500"  ,
				 #"z500"  ,"z700","z850" ,"z925")
				 
variable_ncdf<-c("precipitation_amount_acc",
                 "atmosphere_mass_content_of_water_vapor",
				 "cloud_area_fraction",
				 "x_wind_10m",
				 "y_wind_10m",
				 "ga_~_200",
				 "air_temperature_2m",
				 "air_temperature_pl",
				 "air_temperature_pl",
				 "air_temperature_pl",
				 "air_temperature_pl",
				 "x_wind_pl",
				 "x_wind_pl",
				 "x_wind_pl",
				 "x_wind_pl",
				 "y_wind_pl",
				 "y_wind_pl",
				 "y_wind_pl",
				 "y_wind_pl",
				 "relative_humidity_pl",
				 "relative_humidity_pl",
				 "relative_humidity_pl",
				 "relative_humidity_pl",
				 "ga_q_100",
				 "ga_q_100",
				 "ga_q_100" #, "ga_q_100"
				 ) 


domain<-"D0"
if (domain=="D0") {
   adm_border=border_Europa
} else if (domain=="D2") {
   adm_border=border_northEuropa
} else adm_border=border_world
UTM<-"latlon"
timestep<-24
time_resolution<-6
origin="2014-03-05"

#
# In case you don't know the name of the variable_ncdf
# path=paste(path_ncdf,ncdf_type,"/",sep="")
# i<-1
# file_name=paste(filename_1,variable_file[i],".nc",sep="")
# ftxt<-paste(path,file_name,sep="")					
# a <- nc_open(ftxt, verbose = TRUE, write = FALSE)
#

for (i in 1:length(variable_file)) {
   tmp<-geoW.ncdf42geoW(path_ncdf,path_results,ncdf_type,filename_1,variable_file[i],variable_ncdf[i],UTM,adm_border,timestep,time_resolution,origin=origin)
}
