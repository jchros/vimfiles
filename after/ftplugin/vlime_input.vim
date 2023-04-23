setlocal syntax=lisp
let b:pear_tree_pairs = deepcopy(g:pear_tree_pairs)
call remove(b:pear_tree_pairs, "'")
let b:pear_tree_pairs['#|'] = #{ closer: '|#' }
let b:pear_tree_pairs['|'] = #{ closer: '|' }
