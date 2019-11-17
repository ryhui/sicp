#lang scheme

(require sicp-pict)

(define (split op0 op1)
  (define op (lambda (painter n)
               (if (= n 0)
                   painter
                   (let ((smaller (op painter (- n 1))))
                     (op0 painter (op1 smaller smaller))))))
  op)
  
(define right-split (split beside below))
(define up-split (split below beside))