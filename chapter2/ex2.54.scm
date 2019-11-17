#lang scheme

(define (equal? a b)
  (if (not (pair? a))
      (and (not (pair? b)) (eq? a b))
      (and (pair? b)
           (and (eq? (car a) (car b))
                (equal? (cdr a) (cdr b))))))