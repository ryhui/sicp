#lang scheme

(define (accumulate op init seq)
  (if (null? seq)
      init
      (op (car seq) (accumulate op init (cdr seq)))))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      '()
      (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(define (matrix-*-vector m v)
  (map (lambda (mrow) (dot-product mrow v)) m))

(define (transpose mat)
  (accumulate-n cons '() mat))
  
(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (mrow)
           (matrix-*-vector cols mrow))
           m)))

; test

(define M (list (list 2 3 4) (list 3 5 6)))
(define N (list (list 1 1) (list 2 2)))
(define v (list 1 2 2))

(dot-product (list 1 2 3) (list 2 2 1))
(matrix-*-vector M v)
(matrix-*-matrix N M)