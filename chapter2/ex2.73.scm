#lang scheme

; "put" and "get" implementation from
; https://stackoverflow.com/questions/5499005/how-do-i-get-the-functions-put-and-get-in-sicp-scheme-exercise-2-78-and-on

(define *op-table* (make-hash))

(define (put op type proc)
  (hash-set! *op-table* (list op type) proc))

(define (get op type)
  (hash-ref *op-table* (list op type) '()))

; a. Number or variable do not have an operator as a tag
; b.

(define (attach-tag type contents)
  (cons type contents))
(define (type-tag datum)
  (if (pair? datum)
      (car datum)
      (error "Bad tagged datum -- TYPE-TAG" datum)))
(define (contents datum)
  (if (pair? datum)
      (cdr datum)
      (error "Bad tagged datum -- TYPE-TAG" datum)))

(define (make-sum a b)
  (cond ((and (number? a) (number? b)) (+ a b))
        ((eq? a 0) b)
        ((eq? b 0) a)
        (#t (attach-tag '+ (list a b)))))
(define (make-product a b)
  (cond ((or (eq? a 0) (eq? b 0)) 0)
        ((and (number? a) (number? b)) (* a b))
        ((eq? a 1) b)
        ((eq? b 1) a)
        (#t (attach-tag '* (list a b)))))
(define (make-exponentiation b e)
  (cond ((eq? e 1) b)
        ((eq? e 0) 1)
        (else (attach-tag '** (list b e)))))

(define variable? symbol?)
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        (else ((get 'deriv (operator exp)) (operands exp)
                                           var))))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

(define (install-sum)
  (define (addend exp) (car exp))
  (define (augend exp) (cadr exp))
  (define (deriv-sum exp var)
    (make-sum
     (deriv (addend exp) var)
     (deriv (augend exp) var)))
  (define (make-tagged-sum a b)
    (attach-tag '+ (cons a b)))
  (put 'deriv '+ deriv-sum))

(define (install-product)
  (define (multiplier exp) (car exp))
  (define (multiplicand exp) (cadr exp))
  (define (deriv-product exp var)
    (make-sum
     (make-product (multiplier exp)
                   (deriv (multiplicand exp) var))
     (make-product (deriv (multiplier exp) var)
                   (multiplicand exp))))
  (put 'deriv '* deriv-product))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
        (error
         "No method for these types -- APPLY-GENERIC"
         (list op type-tags))))))

;c

(define (install-exponentiation)
  (define (exponent e) (cadr e))
  (define (base e) (car e))
  (define (deriv-expo exp var)
    (make-product (exponent exp)
                  (make-exponentiation (base exp)
                                       (- (exponent exp) 1))))
  (put 'deriv '** deriv-expo))

;d

; each put would need to put data-tag before the name 'deriv 
