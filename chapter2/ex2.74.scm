#lang scheme

; a
; need to understand the structure of the file. So the type information should be
; the division

(define (get-record name file)
  (let ((op (get 'get-record (get-tag file))))
    (op name (get-content file))))

; b

(define (get-salary record)
  (let ((op (get 'get-salary (get-tag record))))
    (op (get-content record))))

; c

(define (get-names file)
  (let ((op (get 'get-names (get-tag file))))
    (op (get-content file))))
(define (find-employee-record name file-list)
  (if (empty? file-list)
      (error name "not found in any records")
      (if (memq? name (get-names (car file-list)))
          (get-record name (car file-list))
          (find-employee-record name (cdr file-list)))))

; d
; We would need to write a new package for the new company, including
; (at least) corresponding 'get-names, 'get-record, 'get-salary functions.
