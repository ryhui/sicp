#lang scheme

(define (square x)
  (* x x))

(define (map proc items)
  (if (null? items)
      '()
      (cons (proc (car items)) (map proc (cdr items)))))

(define (square-list-1 items)
  (if (null? items)
      '()
      (cons (square (car items)) (square-list-1 (cdr items)))))

(define (square-list-2 items)
  (map square items))

; test

(define xs (list 3 5 7 9))
(square-list-1 xs)
(square-list-2 xs)