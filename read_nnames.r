# read in the data
names_df <- read.csv("nicknames.csv")

# make sure every name is unique
names_df <- unique(unlist(names_df))

# create a data frame to store the final result
result_df <- data.frame(name = character(0), regex = character(0))

# loop through every name
for (name in names_df) {
  # find all related names
  related_names <- unique(unlist(names_df[grepl(name, names_df),]))
  
  # create the regex expression
  regex <- paste("^(", paste(sprintf("^%s$", related_names), collapse = "|"), ")$", sep = "")
  
  # add the name and its related names' regex to the result data frame
  result_df <- rbind(result_df, data.frame(name = name, regex = regex))
}

# remove duplicates
result_df <- unique(result_df)