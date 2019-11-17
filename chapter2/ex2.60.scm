#lang scheme

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (cons x set))

(define (union-set set1 set2)
  (if (null? set2)
      set1
      (union-set (adjoin-set (car set2) set1)
                 (cdr set2))))

(define (intersection-set set1 set2)
  (if (or (null? set1) (null? set2))
      '()
      (if (element-of-set? (car set2) set1)
          (cons (car set2) (intersection-set set1 (cdr set2)))
          (intersection-set set1 (cdr set2)))))