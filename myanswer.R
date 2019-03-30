library("dplyr")

#create a local copy of **mtcars**
ds <- tbl_df(mtcars)
 
#select the following columns: mpg, cyl, disp, hp, drat, wt 
ds <- select(ds, mpg, cyl, disp, hp, drat, wt)
#select() also works with keywords such as starts_with, contains(), ends_with()
#for example: select(ds, starts_with("m"))
#it also works with numbers: select(ds, c(5,1,3)) to select 5th,1st and 3rd columns
#or instead of select(), you can use select_if(is.numeric) to select all columns with numeric values.

#arrange the data frame by the disp column in the descending order
ds <- arrange(ds, desc(disp))

#create a new column which is equal to mpg*cyl/wt and name it x
ds <- mutate(ds, x=mpg*cyl/wt)

#group the data by cyl, calculate the average, standard deviation of disp column
#and the number of columns, write the output as *dplyr-exercise-disp.txt*
output <- summarise(group_by(ds, cyl),
                    meanDisp=mean(disp, na.rm=TRUE), 
                    sdDisp = sd(disp, na.rm=TRUE),
                    n= n())
cat("A quick note on the displacement variable:\n\n",
    file="dplyr-exercise-disp.txt", append=FALSE)
write.table(output, file="dplyr-exercise-disp.txt", 
            append=TRUE, quote=FALSE, row.names=FALSE)
#Note that if you load "plyr" and "dplyr" at the same time, group_by won't work
#due to name col

#add a new column which is the copy of cyl column where 4,6, and 8 are represented as "A","B", and "C", respectively
ds <-   mutate(ds, newcyl = case_when(cyl == 4 ~ "A",
                                  cyl ==6 ~ "B",
                                  cyl ==8 ~ "C"))



#rename x column as mcw
ds <- rename(ds, mcw=x)

#create a new data frame with all the rows having a value between 3 and 100
#in the disp column and save the new data frame as *dplyr-exercise.out* 
#(white space separated, without quotation marks)

ds <- filter(ds,between(disp, 3, 100))
write.table(ds, file="dplyr-exercise.out", quote=FALSE, row.names=FALSE)
