#########################translation_csvs############################

#8/16/2017

#Renske van Raaphorst

#####################################################################

##MicrobeJ

extr.MicrobeJMESH <- function(dataloc){
  MESH <- read.table(dataloc, header=T, sep=",")
  meshL <- list()
  meshL$cellList <- MESH
  MESH$cell <- as.numeric(gsub("b", "", MESH$NAME))
  MESH$frame <- MESH$POSITION
  MESH <- MESH[,c("X", "Y", "cell", "frame")]
  meshL$meshList <- MESH
  return(meshL)
}


extr.MicrobeJSpots <- function(spotloc){
  SPOTS <- read.table(spotloc, header=T, sep=",")
  spotL <- list()
  spotL$cellList <- SPOTS
  SPOTS$x <- t(data.frame(strsplit(stringr::str_sub(SPOTS$LOCATION,2,-2),";"))[1,])
  SPOTS$y <- t(data.frame(strsplit(stringr::str_sub(SPOTS$LOCATION,2,-2),";"))[2,])
  SPOTS$x <- as.numeric(SPOTS$x)
  SPOTS$y <- as.numeric(SPOTS$y)
  SPOTS$NAME <- NULL
  SPOTS$NAME.name <- NULL
  SPOTS$NAME.id <- NULL
  SPOTS$cell <- as.numeric(gsub("b", "", SPOTS$PARENT.name))
  SPOTS$frame <- SPOTS$POSITION.frame
  SPOTS <- SPOTS[,c("x", "y", "cell", "frame")]
  spotL$spotList <- SPOTS
  return(spotL)
}

#' @export
extr.MicrobeJ <- function(dataloc, spotloc){
  outlist <- list()
  if(missing(dataloc)!=T){
    MESH <- extr.MicrobeJMESH(dataloc)$meshList
    cellList <- extr.MicrobeJMESH(dataloc)$cellList
    if(missing(spotloc)==T){
      outlist$cellList <- cellList
    }
  }
  if(missing(spotloc)!=T){
    SPOTS <- extr.MicrobeJSpots(spotloc)$spotList
    cellList2 <- extr.MicrobeJSpots(spotloc)$cellList
    if(missing(dataloc)==T){
      outlist$cellList <- cellList2
    }
  }
  if(missing(spotloc)!=T&missing(dataloc)!=T){
    listbox <- spotsInBox(SPOTS, MESH)
    outlist$spotList <- spot
    outlist$meshList <- listbox$Mfull
    cellList3 <- list()
    cellList3$Mesh <- cellList
    cellList3$Spots <- cellList2
    outlist$cellList <- cellList3
  }
  return(outlist)
}

##ISBatch
#' @export
extr.ISBatch <- function(dataloc){
  SPOTS <- read.table(dataloc, header=T, sep=",")
  SPOTS$frame  <- SPOTS$slice
  SPOTS$slice <- NULL
  spotminimal <- SPOTS[,c("x","y","cell","frame")]
  listout <- list()
  listout$cellList <- SPOTS
  listout$spotList <- spotminimal
  return(listout)
}


#ObjectJ - mostly manual entry.
#' @export
spotrExtrObjectJ <- function(dataloc, spots="X", constr, xcolumns, ycolumns, xconstr, yconstr, spotcol,spotloc){
  if(substr(dataloc, nchar(dataloc)-3, nchar(dataloc))==".txt"){
    OJ <- read.table(dataloc, header=T, sep="\t")
  }
  if(substr(dataloc, nchar(dataloc)-3, nchar(dataloc))==".csv"){
    OJ <- read.csv(dataloc, header=T)
  }

  OJ$cell <- OJ$n
  OJ$max.length <- round(OJ$Axis,2)
  OJ$max.width <- OJ$Dia
  OJ$n <- NULL
  OJ$Dia <- NULL


  if(spots=="X"&missing(spotloc)){
    spots <- readline("Does the file contain spot coordinates? Y/N: ")
  }

  if(spots=="Y"|spots=="y"){
    if(missing(xcolumns)|missing(ycolumns)){
    print("Give the name(s) of the column(s) containing the x localization of the spots.\nPress <enter> between names, end with #<enter>")
    xcolumns <- choosecolumns()
    print("Give the name(s) of the column(s) containing the y localization of the spots.\nPress <enter> between names, end with #<enter>" )
    ycolumns <- choosecolumns()
    }
    n <- length(xcolumns)
    if(n!=length(ycolumns)){
      stop("Number of x and y columns does not match.")
    }

    OJ[,xcolumns[1]][is.na(OJ[,xcolumns[1]])] <- 0
    OJ <- tidyr::gather(OJ, "xspot", "l", xcolumns[1:n], na.rm=T)
    OJ$l[OJ$l==0] <- NA
    OJ[,ycolumns[1]][is.na(OJ[,ycolumns[1]])] <- 0
    OJ <- tidyr::gather(OJ, "yspot", "d", ycolumns[1:n], na.rm=T)
    OJ$d[OJ$d==0] <- NA
    if(missing(spotcol)){
    spotcol <- readline("If included, give the name of the column containing the number of spots per cell.\nOtherwise, press #<enter>")
    }
    if(spotcol!="#"){
      colnames(OJ)[colnames(OJ)==spotcol] <- "spotn"

    }
  }
  if(missing(spotloc)!=T){
    if(substr(spotloc, nchar(spotloc)-3, nchar(spotloc))==".csv"){
      SF <- read.csv(spotloc, header=T)
    }
    if(substr(spotloc, nchar(spotloc)-3, nchar(spotloc))==".txt"){
      SF <- read.table(spotloc, header=T, sep="\t")
    }
    SF <- spotrExtractSpotsObjectJ(SF)
    OJ <- merge(OJ, SF, all=T)
  }


  if(missing(constr)){
  constr <- readline("Does the file contain constriction point coordinates? Y/N: ")
  }
  if(constr=="Y"|constr=="y"){
    if(missing(xconstr)|missing(yconstr)){
    print("Give the name(s) of the column(s) containing the distance of the constriction point to the Axis.\nPress <enter> between names, end with #<enter>")
    xconstr <- choosecolumns()
    print("Give the name(s) of the column(s) containing the distance of the constriction point to the Axis.\nPress <enter> between names, end with #<enter>")
    yconstr <- choosecolumns()
    }
    i <- length(xconstr)
    if(i!=length(yconstr)){
      stop("Number of x and y columns does not match.")
    }

    OJ[,xconstr[1]][is.na(OJ[,xconstr[1]])] <- 0
    OJ <- tidyr::gather(OJ, "xconstr", "LC", xconstr[1:i], na.rm=T)
    OJ$LC[OJ$LC==0] <- NA
    OJ[,yconstr[1]][is.na(OJ[,yconstr[1]])] <- 0
    OJ <- tidyr::gather(OJ, "yconstr", "DC", yconstr[1:i], na.rm=T)
    OJ$DC[OJ$DC==0] <- NA
  }

  OJ$max.length <- OJ$Axis
  OJ$Axis <- NULL
  return(OJ)

}



choosecolumns <- function(){
  u <- "i"
  columnamelist <- list()
  while(u!="#"){
    u <- readline()
    if(u!="#"){
      columnamelist <- append(columnamelist, u)
    }
  }
  return(unlist(columnamelist))
}

spotrExtractSpotsObjectJ <- function(SF){
  nmax <- (ncol(SF)-4)/3
  for(n in 1:nmax){
    SN <- SF[,c("n", "len", "seq", "mirr", paste("type",n, sep=""), paste("pp",n,sep=""), paste("off",n, sep=""))]
    colnames(SN) <- c("cell", "length", "spotorder", "mirr", "type", "l", "d")
    if(n==1){Sframe <- SN}
    if(n>1){
      SN <-SN[!is.na(SN$L),]
      Sframe <- rbind(Sframe,SN)}
  }
  Sframe <- Sframe[order(Sframe$cell, Sframe$L),]
  return(Sframe)
}