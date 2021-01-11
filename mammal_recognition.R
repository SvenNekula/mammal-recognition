#loading packages
library(EBImage)
library(keras)

#setting wd
setwd("C:\\Users\\svenn\\Documents\\ML\\images\\")

#reading files
pictures <- c("c1.jpg", "c2.jpg", "c3.jpg", "c4.jpg", "c5.jpg", "c6.jpg", "c7.jpg", "c8.jpg", "c9.jpg", "c10.jpg",
              "o1.jpg", "o2.jpg", "o3.jpg", "o4.jpg", "o5.jpg", "o6.jpg", "o7.jpg", "o8.jpg", "o9.jpg", "o10.jpg",
              "s1.jpg", "s2.jpg", "s3.jpg", "s4.jpg", "s5.jpg", "s6.jpg", "s7.jpg", "s8.jpg", "s9.jpg", "s10.jpg")

mypictures <- list()

for (i in 1:30){
  mypictures[[i]] <- readImage(pictures[i])
}

#overview of the data
print(mypictures[[1]])
display(mypictures[[1]])
summary(mypictures[[1]])
hist(mypictures[[1]])
str(mypictures)

#resizing images
for (i in 1:30){
  mypictures[[i]] <- resize(mypictures[[i]], 48, 48)
}

str(mypictures)
#as you can see, pictures have been resized to 48x48

#reshaping images
for (i in 1:30){
  mypictures[[i]] <- array_reshape(mypictures[[i]], c(48, 48, 3))
}

str(mypictures)

display()
#binding the data
#training set
trainx <- vector()

#cat pictures
for (i in 1:8){
  trainx <- rbind(trainx, mypictures[[i]])
}

#orangutang pictures
for (i in 11:18){
  trainx <- rbind(trainx, mypictures[[i]])
}

#sloth pictures
for (i in 21:28){
  trainx <- rbind(trainx, mypictures[[i]])
}

str(trainx)

#testing set
testx <- vector()

for (i in c(9,10,19,20,29,30)){
  testx <- rbind(testx, mypictures[[i]])
}

#y variables: 0=cat, 1=orangutan, 2=sloth
trainy <- c(0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2)
testy <- c(0,0,1,1,2,2)

#one hot encoding
trainLabels <- to_categorical(trainy)
testLabels <- to_categorical(testy)

#creating model
model <- keras_model_sequential()
model %>%
  layer_dense(units = 256, activation = "relu", input_shape = c(6912)) %>%
  layer_dense(units = 128, activation = "relu") %>%
  layer_dense(units = 3, activation = "softmax")

summary(model)

#compiling model
model %>%
  compile(loss = "categorical_crossentropy",
          optimizer = optimizer_rmsprop(),
          metrics = c("accuracy"))

#fitting model
history <- model %>%
  fit(trainx,
      trainLabels,
      epochs = 100,
      batch_size =72,
      validation_split = 0.2)

plot(history)

#evaluation and predtiction - train data
model %>% evaluate(trainx, trainLabels)
prediction <- model %>% predict_classes(trainx)
table(Predicted = prediction, Actual = trainy)
probability <- model %>% predict_proba(trainx)
cbind(probability, Predicted = prediction, Actual=trainy)












