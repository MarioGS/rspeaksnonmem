#' Estimates parameters using NONMEM
#'
#' @param modelFile NONMEM control stream file name (without extension)
#' @param modelExtension NONMEM control stream file extension. Defaults to '.mod'
#' @param reportExtension NONMEM control stream output file extension. 
#' Defaults to '.lst'
#' @param working.dir Working directory containing control stream and where 
#' output files should be stored
#' @param cleanup Whether to clean up additional NONMEM files and folders 
#' following estimation. Defaults to TRUE.
#' @param NMcommand Command line for calling NONMEM. For Windows must point to a
#' file of type .bat or .exe.
#' @return NONMEM estimation output files
#' @examples
#' estimate.NM(modelFile='warfarin_PK_CONC_MKS', modelExtension='.ctl', 
#' working.dir='./data')

estimate_NM <- function(command = NULL, modelFile = NULL, 
                        lstFile = NULL, lstFileExtension = "lst", 
                        clean = 1, ...) {
    
    baseCommand <- ifelse(is.null(command), 
                          defineExecutable(tool = "nonmem", ...), 
                          defineExecutable(command = command, ...))
    lstFile <- ifelse(is.null(lstFile), 
                      paste(tools::file_path_sans_ext(modelFile), 
                            sub("\\.", "", lstFileExtension), sep = "."), 
                      lstFile)
    
    command <- paste(baseCommand, shQuote(modelFile), shQuote(lstFile))
    
    cat(paste(command, "\n"))
    execute(command)
    
    if (clean > 0) cleanup()
}
