#lang scheme

(define (cons x y)
  (if (or (< x 0) (< y 0))
      (error "Numbers should be non-negative")
      (* (expt 2 x) (expt 3 y))))

(define (car z)
  (define (helper n acc)
    (if (= (remainder n 2) 0)
        (helper (/ n 2) (+ acc 1))
        acc))
  (helper z 0))

(define (cdr z)
  (define (helper n acc)
    (if (= (remainder n 3) 0)
        (helper (/ n 3) (+ acc 1))
        acc))
  (helper z 0))
