#lang scheme

; direct
(define (square-tree tree)
  (cond ((null? tree) '())
        ((not (pair? tree)) (* tree tree))
        (else (cons (square-tree (car tree))
                    (square-tree (cdr tree))))))

; map
(define (square-tree-1 tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (square-tree-1 sub-tree)
             (* sub-tree sub-tree)))
       tree))

; test
(square-tree
 (list 1
       (list 2 (list 3 4) 5)
       (list 6 7)))

(square-tree-1
 (list 1
       (list 2 (list 3 4) 5)
       (list 6 7)))