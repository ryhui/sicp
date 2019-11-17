#lang scheme

(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1 (right-branch tree))))))

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))

(define (make-tree entry left right)
  (list entry left right))

(define (left-branch tree)
        (cadr tree))
  
(define (entry tree)
        (car tree))
      
(define (right-branch tree)
        (caddr tree))
  
; testing with different trees

(define tree-1
  (make-tree 7
             (make-tree 3
                        (make-tree 1 '() '())
                        (make-tree 5 '() '()))
             (make-tree 9 '() (make-tree 11 '() '()))))

(define tree-2
  (make-tree 3
             (make-tree 1 '() '())
             (make-tree 7
                        (make-tree 5 '() '())
                        (make-tree 9 '()
                                   (make-tree 11 '() '())))))

(define tree-3
  (make-tree 5
             (make-tree 3
                        (make-tree 1 '() '())
                        '())
             (make-tree 9
                        (make-tree 7 '() '())
                        (make-tree 11 '() '()))))

(define tree-2.17
  (make-tree 1
             '()
             (make-tree 2
                        '()
                        (make-tree 3
                                   '()
                                   (make-tree 4
                                              '()
                                              (make-tree 5
                                                         '()
                                                         (make-tree 6
                                                                    '()
                                                                    (make-tree 7 '() '()))))))))

(tree->list-1 tree-1)
(tree->list-2 tree-1)

(tree->list-1 tree-2)
(tree->list-2 tree-2)

(tree->list-1 tree-3)
(tree->list-2 tree-3)

(tree->list-1 tree-2.17)
(tree->list-2 tree-2.17)

; a: they are the same
; b: the complexity at the tree-list function level is the same, but what
; happens within each call is different - cons is a constant-time operation,
; while append grows proportional to the first list argument.
; Overall, tree->list-2 ~ O(nlogn), tree->list-1 ~ O(n)