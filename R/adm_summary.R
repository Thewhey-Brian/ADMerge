#' Summary function for ADMerge analysis results
#'
#' This function generates a summary of the results from the ADMerge function, including the number of participants, number of variables, and the merging parameters.
#'
#' @param res The result object from the ADMerge function.
#' @param vars A vector of variable names to include in the summary. If NULL, all variables will be included.
#' @param ... Additional parameters for the function.
#'
#' @return A summary of the ADMerge analysis results.
#' @export
#'
#' @examples
#' \dontrun{
#' summary.ADMerge_res(res)
#' }
#'
summary.ADMerge_res = function(res, vars = NULL, ...) {
  ana_data = res$analysis_data
  dict_src = res$dict_src
  name_ID = na.omit(unique(unlist(strsplit(dict_src$ID_for_merge, ", "))))[1]
  pat = ana_data %>% distinct(!!as.name(name_ID), .keep_all = TRUE)
  n_pat = dim(pat)[1]
  n_var = dim(pat)[2]
  win_setting = dict_src %>%
    select(c(file, WINDOW, IS_overlap)) %>%
    mutate(info = paste(file, WINDOW, IS_overlap)) %>%
    pull(info)
  win_setting = c("File Window_Size Is_Overlap", win_setting)
  cat('Number of participants:', n_pat,
      'Number of variables:',    n_var,
      'Merged by:',              name_ID,
      'Window settings:',        win_setting,
      sep = "\n")
}

#' Plot function for ADMerge analysis results
#'
#' This function generates a bar plot of the distribution of a given variable among different groups in the merged dataset generated by the ADMerge function.
#'
#' @param res The result object from the ADMerge function.
#' @param distn The name of the variable to plot the distribution of.
#' @param group The name of the variable to group the distribution by.
#' @param baseline A boolean indicating whether to include only the baseline data in the plot.
#' @param ... Additional parameters for the function.
#'
#' @return A bar plot of the distribution of the given variable among different groups in the merged dataset.
#' @export
#'
#' @examples
#' \dinttun{
#' plot.ADMerge_res(res, "AGE", "SEX")
#' }
#'
#' @import ggplot2
#'
plot.ADMerge_res = function(res,
                            distn, # extend ...
                            group,
                            baseline = TRUE,
                            ...) {
  ana_data = res$analysis_data
  dict_src = res$dict_src
  name_ID = na.omit(unique(unlist(strsplit(dict_src$ID_for_merge, ", "))))[1]
  plot_data <- ana_data %>%
    select(!!as.name(name_ID), !!as.name(distn), !!as.name(group))
  if (baseline) {
    plot_data <- plot_data %>%
      distinct(!!as.name(name_ID), .keep_all = TRUE)
  }
  a_gen_tbl <- function(pat, group, distn) {
    info <- as.data.frame(pat %>%
                            count(!!as.name(distn), !!as.name(group))) %>%
      na.omit()
    tbl <- reshape(info, idvar = distn, timevar = group, direction = 'wide', sep = '_') %>%
      replace(., is.na(.), 0) %>%
      mutate(All = rowSums(across(where(is.numeric))))
    return(tbl)
  }
  tbl <- a_gen_tbl(plot_data, group, distn)
  p <- ggplot(plot_data) +
    theme_bw() +
    geom_bar(aes(x = !!as.name(distn), color = !!as.name(group), fill = !!as.name(group)),
             position = 'stack', alpha = 0.9) +
    labs(x = distn, y = 'Number of Subjects', title = 'Participant Distribution') +
    theme(plot.title = element_text(size = 12, face = 'bold', hjust = 0.5))
  p
}
