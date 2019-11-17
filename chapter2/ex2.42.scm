#lang scheme

(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) (safe? k positions))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

(define (flatmap proc seq)
  (accumulate append empty (map proc seq)))

(define (accumulate op initial seq)
  (if (null? seq)
      initial
      (op (car seq)
          (accumulate op initial (cdr seq)))))

(define empty-board empty)

(define (enumerate-interval low high)
  (if (> low high)
      empty
      (cons low (enumerate-interval (+ low 1) high))))

(define (adjoin-position new-row k rest-of-queens)
  (append (list (cons new-row k)) rest-of-queens))

(define (filter predicate sequence)
  (cond ((null? sequence) empty)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

(define (remove item sequence)
  (filter (lambda (x) (not (= x item)))
          sequence))

(define (safe? k positions)
  (define (safe-pair? x y)
    (cond ((= (car x) (car y)) #f)
          ((= (cdr x) (cdr y)) #f)
          ((= (abs (- (car x) (car y))) (abs (- (cdr x) (cdr y)))) #f)
          (else #t)))
  (accumulate (lambda (a b) (and a b))
              #t
              (map (lambda (x)
                     (safe-pair? (car positions) x))
                   (cdr positions))))
