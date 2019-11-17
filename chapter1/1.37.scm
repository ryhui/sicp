#lang scheme

; a. recursive version:

(define tolerance 0.00005)

(define (cont-frac n d k)
  (define (helper i)
    (if (equal? i k)
        (/ (n i) (d i))
        (/ (n i) (+ (d i) (helper (+ 1 i))))))
  (helper 1))

(define (res-k k)
  (cont-frac (lambda (i) 1.0)
             (lambda (i) 1.0)
             k))

(define (test-k k)
  (let ((current (/ 1 (res-k k)))
        (next (/ 1 (res-k (+ k 1)))))
    (if (< (abs (- current next)) tolerance)
        k
        (test-k (+ k 1)))))
  
(test-k 2)
; 12

; b. iterative version:

(define (cont-frac-i n d k)
  (define (helper i res)
    (if (equal? i k)
        (/ (n i) (+ (d i) res))
        (helper (+ 1 i) (/ (n i) (+ (d i) res)))))
  (helper 1 0))

; test

(cont-frac (lambda (i) 1.0)
           (lambda (i) 1.0)
           10)

(cont-frac-i (lambda (i) 1.0)
             (lambda (i) 1.0)
             10)