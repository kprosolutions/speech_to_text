#Setting environment variables
Sys.setenv("GCS_CLIENT_ID" = "1092353186895-m9lpaqvk65ku96eqdm8f1arl0eaf90di.apps.googleusercontent.com")
Sys.setenv( "GCS_CLIENT_SECRET" = "gU-kfJG-tcNfwOVSH2I12bWF")


#Authenticate google API
gl_auth(file.choose())
#bSys.setenv(file.choose())

library(googleLanguageR)
library(googleCloudStorageR)

#Create Bucket
#gcs_global_bucket("audio_to_text-bucket")
#gcs_get_bucket()

## get your project ID from the API console
path_to_Project_details_file =file.choose()
library(jsonlite)
Store_JSON = fromJSON(path_to_Project_details_file)
Project_ID =Store_JSON[["web"]][["project_id"]]

##Bucket names must be between 3 and 63 characters.
#A bucket name can contain lowercase alphanumeric characters, hyphens, and underscores. 
#It can contain dots (.) if it forms a valid domain name with a top-level domain (such as .com).
#Bucket names must start and end with a lowercase alphanumeric character.
#DON"T PUT CAPITAL LETTER
Name_of_bucket = readline(prompt="Enter name of bucket: ")
Sys.setenv("GCS_DEFAULT_BUCKET" = Name_of_bucket)
#Create Bucket
gcs_create_bucket(Name_of_bucket,Project_ID,location = "asia", storageClass = "MULTI_REGIONAL")

## Getting Bucket name which is there in project
#buckets <- gcs_list_buckets(Project_ID)

#To get Info about Particular 
#bucket <- Name_of_bucket
#bucket_info <- gcs_get_bucket(bucket)
#bucket_info
#Set bucket where you need to upload

gcs_get_bucket( Name_of_bucket)
gcs_global_bucket(Name_of_bucket)

##Uploading File
Upload_file_name = readline(prompt="Enter upload file name: ")

upload<- gcs_upload(file.choose(),bucket = gcs_get_global_bucket(), type = NULL,name = Upload_file_name)

#In case file size greater than 5MB
#try2 <- gcs_retry_upload(upload)

#Download objects from cloud
#objects <- gcs_list_objects()
#save_file_name = readline(prompt="Saving file name: ")
#gcs_get_object(objects$name[1], saveToDisk = save_file_name )



