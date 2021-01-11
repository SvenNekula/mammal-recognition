#loading packages
library(EBImage)
library(keras)

#setting wd
setwd("C:\\Users\\svenn\\Documents\\ML\\images\\")

#List of animals to model
animal_list <- c("cat", "orangutan", "sloth")

#number of output classes
output_n <- length(animal_list)

#image size to scale down original picture
img_width <- 28
img_height <- 28
target_size <- c(img_width, img_height)

#RGB -> 3 channels
channels <- 3

#image folders
train_image_file_path <- "C:\\Users\\svenn\\Documents\\ML\\images\\training\\"
valid_image_file_path <- "validation"

#optional data augmentation
train_data_gen <- image_data_generator(rescale =1/255)
valid_data_gen <- image_data_generator(rescale=1/255)

#loading training images
train_image_array_gen <- flow_images_from_directory(train_image_file_path,
                                                    train_data_gen,
                                                    target_size = target_size,
                                                    class_mode = "categorical",
                                                    classes = animal_list,
                                                    seed = 123)

#loading validiation images
valid_image_array_gen <- flow_images_from_directory(valid_image_file_path,
                                                    valid_data_gen,
                                                    target_size = target_size,
                                                    class_mode = "categorical",
                                                    classes = animal_list,
                                                    seed = 123)