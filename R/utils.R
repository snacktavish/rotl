split_by_n <- function(x, n, ...) {
    split(x, ceiling(seq_along(x)/n), ...)
}
