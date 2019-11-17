#lang scheme

(define (lookup given-key tree-of-records)
  (cond ((null? tree-of-records) false)
        ((equal? given-key (key (entry tree-of-records)))
                 (entry tree-of-records))
        ((< given-key (key (entry tree-of-records)))
         (lookup given-key (left-tree tree-of-records)))
        ((> given-key (key (entry tree-of-records)))
         (lookup given-key (right-tree tree-of-records)))))
