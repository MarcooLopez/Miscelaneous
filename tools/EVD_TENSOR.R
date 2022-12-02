
EVD.TENSOR <- function(G, O, ID_G=NULL, ID_O=NULL, threshold=0.95,
                        min.value=.Machine$double.eps, path=".", verbose=FALSE){
    ## Produces eigenvectors of the kronecker product of G and O
    #  Retains the top eigenvectors that capture a proportion of variance >= threshold

    if(is.null(ID_G)){
      if(is.null(rownames(G))){
        rownames(G) <- paste0(1:nrow(G))
      }
      ID_G <- rep(rownames(G), each=ncol(O))
    }
    if(is.null(ID_O)){
      if(is.null(rownames(O))){
        rownames(O) <- paste0(1:nrow(O))
      }
      ID_O <- rep(rownames(O), ncol(G))
    }
    ID_G <- as.character(ID_G)
    ID_O <- as.character(ID_O)

    stopifnot(all(ID_G %in% rownames(G)))
    stopifnot(all(ID_O %in% rownames(O)))
    stopifnot(length(ID_G) == length(ID_O))

    EVD.G <- eigen(G)
    EVD.O <- eigen(O)

    INDEX <- data.frame(G=match(ID_G, rownames(G)), O=match(ID_O, rownames(O)))

    dyn.load(paste0(path,"/c_utils.so"))
    tmp <- .Call('get_tensor_evd', EVD.G$vectors, EVD.O$vectors,
                            EVD.G$values, EVD.O$values,
                            as.numeric(min.value), INDEX$G-1L, INDEX$O-1L,
                            as.numeric(threshold), verbose)
    dyn.unload(paste0(path,"/c_utils.so"))

    index <- (tmp[[1]]+1)[seq(tmp[[2]])]
    totalVar <- tmp[[3]]
    namesPC <- paste0((tmp[[4]]+1)[index],"_",(tmp[[5]]+1)[index])
    INFO <- data.frame(eigenvalue=tmp[[6]][index],Var=tmp[[7]][index], propVar=tmp[[7]][index]/totalVar)

    rownames(tmp[[8]]) <- paste0(ID_G,":",ID_O)
    colnames(tmp[[8]]) <- namesPC

    return(list(PC=tmp[[8]], INFO=INFO, totalVar=totalVar))
}
