let b:pear_tree_pairs = remove(copy(g:pear_tree_pairs), "'")
let b:pear_tree_pairs['#|'] = #{ closer: '|#' }
let b:pear_tree_pairs['|'] = #{ closer: '|' }
