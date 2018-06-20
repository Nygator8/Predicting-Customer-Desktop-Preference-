#New Product prediction_Multiple regression 
library(readr)
library(caret)
newproductattributes2017_2 <- read_csv("~/Desktop/Austin DA/Course 2/Task 3/newproductattributes2017.2.csv")
View(newproductattributes2017_2)

#Check data settings
summary(newproductattributes2017_2)
attributes(newproductattributes2017_2)
str(newproductattributes2017_2)
is.na(newproductattributes2017_2)
setwd("~/Desktop/Austin DA/Course 2/Task 3/")

#Rename data
ProductTypePredict <- newproductattributes2017_2
ProductTypePredict
summary(ProductTypePredict)
str(Productfinal$Volume)

#Convert attributes to DV
?dummyVars
DVProduct<- dummyVars("~ .", data = ProductTypePredict)
DVProduct
print(DVProduct)
attributes(DVProduct)
print(ProductTypePredict$ProductType)
Productfinal <-data.frame(predict(DVProduct, newdata = ProductTypePredict))
Productfinal
str(Productfinal)
attributes(Productfinal)
Productfinal$Volume<- as.numeric(Productfinal$Volume)


#Feature Engineering
Productfinal$x5StarReviews<- NULL
Productfinal$x3StarReviews<- NULL
Productfinal$x1StarReviews<- NULL
Productfinal$NegativeServiceReview<-NULL
Productfinal$ProductTypeAccessories<-NULL
Productfinal$ProductTypeDisplay<-NULL
Productfinal$ProductTypeExtendedWarranty<-NULL
Productfinal$ProductTypePrinter<-NULL
Productfinal$ProductTypePrinterSupplies<-NULL
Productfinal$ProductTypeSoftware<-NULL
Productfinal$ProductTypeTablet<-NULL
Productfinal$ProductTypeGameConsole<-NULL
Productfinal$BestSellersRank<-NULL
Productfinal$ProductNum<-NULL
attributes(Productfinal)
summary(Productfinal)
str(Productfinal$Volume)



#Final Pred SVM model
set.seed(123)

FinalPred <- predict(SVMFit1, Productfinal)
FinalPred
str(FinalPred)

FinalPred<- as.data.frame(FinalPred)
postResample(FinalPred, testing_type$Volume)

#Final Pred RF model
FinalPred_RF <- predict(TypeForrest100, Productfinal)
summary(TypeForrest100)
FinalPred_RF
?postResample
postResample(FinalPred_RF, testing_type$Volume)

#Final Pred GBM
set.seed(123)
Final_PredGBM <- predict(gbm.caret, Productfinal)
Final_PredGBM
postResample(Final_PredGBM, Productfinal$Volume)

#Final Pred LM 
set.seed(123)
FinalPred_LM <- predict(LMfIT_TYPE, Productfinal)
FinalPred_LM
postResample(FinalPred_LM, Productfinal$Volume)

#Tranfer prediction data to excel
install.packages("WriteXLS")
library(WriteXLS)
FinalPred_RF<-as.data.frame(FinalPred_RF)
WriteXLS(FinalPred_RF, ExcelFileName = "Finaloutcome_product_rf.xlsx")



