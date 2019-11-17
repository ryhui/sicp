#lang scheme

(define (filter predicate sequence)
  (cond ((null? sequence) empty)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

(define (remove item sequence)
  (filter (lambda (x) (not (= x item)))
          sequence))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence) (accumulate op initial (cdr sequence)))))

(define (flatmap proc seq)
  (accumulate append empty (map proc seq)))

(define (enumerate-interval low high)
  (if (> low high)
      empty
      (cons low (enumerate-interval (+ low 1) high))))

(define (ordered-triplets n) ; assume n > 3
  (flatmap (lambda (i)
             (flatmap (lambda (j)
                        (map (lambda (k) (list i j k))
                             (remove j (remove i (enumerate-interval 1 5)))))
                      (remove i (enumerate-interval 1 n))))
           (enumerate-interval 1 n)))

(define (sum-s? triplet s)
  (= (accumulate + 0 triplet) s))

(define (f n s)
  (filter (lambda (x) (sum-s? x s)) (ordered-triplets n)))
  