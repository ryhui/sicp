#lang scheme

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))

(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set (make-leaf (car pair)
                               (cadr pair))
                    (make-leaf-set (cdr pairs))))))


(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

(define (left-branch tree) (car tree))
(define (right-branch tree) (cadr tree))
(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))
(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

(define (make-leaf symbol weight)
  (list 'leaf symbol weight))
(define (leaf? object)
  (eq? (car object) 'leaf))
(define (symbol-leaf x) (cadr x))
(define (weight-leaf x) (caddr x))

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge leaf-set)
  (cond ((null? leaf-set) '())
        ((null? (cdr leaf-set)) (car leaf-set))
        (else (successive-merge
               (adjoin-set (make-code-tree (car leaf-set) (cadr leaf-set))
                           (cddr leaf-set))))))

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

(define (encode-symbol letter tree)
  (cond ((and (leaf? tree) (eq? letter (symbol-leaf tree)))
         '())
        ((memq letter (symbols (left-branch tree)))
         (cons 0 (encode-symbol letter (left-branch tree))))
        ((memq letter (symbols (right-branch tree)))
         (cons 1 (encode-symbol letter (right-branch tree))))
        (else (error "bad symbol -- ENCODE-SYMBOL" letter))))
;;
(define rock-tree (generate-huffman-tree
                   '((A 2) (NA 16) (BOOM 1) (SHA 3) (GET 2) (YIP 9) (JOB 2) (WAH 1))))

(define lyrics
  '(GET A JOB SHA NA NA NA NA NA NA NA NA GET A JOB SHA NA NA NA NA NA NA NA NA WAH YIP YIP YIP YIP YIP YIP YIP YIP YIP SHA BOOM))

(define code (encode lyrics rock-tree))

(length code) ; we used 84 bits
(length lyrics) ; 36 * 3 = 108
; what is happening here??

