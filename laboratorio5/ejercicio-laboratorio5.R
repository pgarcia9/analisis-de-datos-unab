for(i in unique(data$rama1)) {
  data[paste("type", i, sep="")] <- ifelse(data$rama1 == i, 1, 0)
}