library(googleLanguageR)
gl_auth(file.choose())

library(tractor.base)
vec = c('gs://',Name_of_bucket,'/',Upload_file_name)
URI = implode(vec) #"gs://bucet_buck/file1.wav"

library(tuneR)
wave_header =readWave(file.choose())


speech_result <- gl_speech(URI, languageCode = "en-GB",sampleRateHertz = 48000L,asynch = TRUE)

gl_speech_op(speech_result)

result <- gl_speech_op(speech_result)


#Writing the resulkt into Csv file
Name_of_csv_file = readline(prompt="Enter name of csv file where you want to write: ")
write.csv(result$timings,file = Name_of_csv_file,row.names = FALSE)

#Reading the data

data =read.csv(file = Name_of_csv_file,header = T)

library(plyr)

library(qdap)

textAnalytics =rm_row(data, "word", c("this","to","on","up","and","in","the","be","as","is","with","how","a","will","of","that","can"), contains = FALSE, ignore.case=TRUE)


write.csv(textAnalytics,file = 'Filtered_data.csv',row.names = FALSE)
df <- read.csv("Filtered_data.csv")
df['new_column'] = Upload_file_name
write.csv(df, file = 'Filtered_data.csv',row.names = FALSE)

#mongoDb Insert

library(mongolite)
#mongodb collection
c = mongo(collection = "textAnalytics",db ="Rdb")

c$insert(textAnalytics)