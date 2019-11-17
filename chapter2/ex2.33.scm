#lang scheme

(define (accumulate fun initial sequence)
  (if (null? sequence)
      initial
      (fun (car sequence) (accumulate fun initial (cdr sequence)))))

(define (map p sequence)
  (accumulate (lambda (x y) (cons (p x) y)) '() sequence))

(define (append seq1 seq2)
  (accumulate cons seq2 seq1))

(define (length sequence)
  (accumulate (lambda (x y) (+ x 1)) 0 sequence))

; test
(define x (list 3 6 1 6))
(define y (list 6 7 8))

(map (lambda (x) (* x x)) x)
(append x y)
(length x)