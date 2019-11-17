#lang scheme

(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ result (term a)))))
  (iter a 0))

; test with simple sum

(define (inc x) (+ x 1))
(define (identity x) x)

(sum identity 1 inc 9)