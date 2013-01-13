
DeFriesFulkerMethod1 <-
function( dataSet, oName_1, oName_2, rName="R" ) { 
  lmDetails <- stats::lm(dataSet[, oName_1] ~ 1 + dataSet[, oName_2] + dataSet[, rName] + dataSet[, oName_2]*dataSet[, rName])
  brief <- summary(lmDetails)
  coeficients <- coef(brief)
  nDouble <- length(brief$residuals) 
  #b0 <- coeficients["(Intercept)", "Estimate"]
  b1 <- coeficients["dataSet[, oName_2]", "Estimate"]  
  #b2 <- coeficients["R", "Estimate"]
  b3 <- coeficients["dataSet[, oName_2]:dataSet[, rName]", "Estimate"]
  eSquared <- 1 - (b1+b3)
  
  details <- list(lm=lmDetails)
  aceEstimate <- NlsyLinks::CreateAceEstimate(aSquared=b3, cSquared=b1, eSquared=eSquared, caseCount=nDouble, details=details)
  return( aceEstimate )
  #return( list(ASquared=b3, CSquared=b1, ESquared=eSquared, RowCount=nDouble) )
}


DeFriesFulkerMethod3 <-
  function( dataSet, oName_1, oName_2, rName="R" ) { 
    dv_1Centered <- base::scale(dataSet[, oName_1], center=TRUE, scale=FALSE)
    dv_2Centered <- base::scale(dataSet[, oName_2], center=TRUE, scale=FALSE)
    interaction <- dv_2Centered*dataSet[, rName]
    
    lmDetails <- stats::lm(dv_1Centered ~ 0 + dv_2Centered + interaction) #The '0' specifies and intercept-free model.
    brief <- summary(lmDetails)
    
    coeficients <- stats::coef(brief)
    nDouble <- length(brief$residuals) 
    b1 <- coeficients["dv_2Centered", "Estimate"]  
    b2 <- coeficients["interaction", "Estimate"]
    eSquared <- 1 - (b1+b2)
    
    details <- list(lm=lmDetails)
    aceEstimate <- NlsyLinks::CreateAceEstimate(aSquared=b2, cSquared=b1, eSquared=eSquared, caseCount=nDouble, details=details)
    return( aceEstimate )
    #  return( list(ASquared=b2, CSquared=b1, ESquared=eSquared, RowCount=nDouble) )
  }
