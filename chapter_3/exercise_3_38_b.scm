#lang racket

;; P210 - [练习 3.38-b]

(define (remove item lst)
  (filter (lambda (x) (not (eq? x item)))
          lst))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (arrange lst)      
  (if (null? lst)
      (list '())
      (accumulate append '()
                  (map (lambda (x)
                         (let ((subarrange (arrange (remove x lst))))
                           (append '() (map (lambda (sub) (append (list x) sub)) 
                                            subarrange))))
                       lst))))

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (if (element-of-set? x set)
      set
      (cons x set)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define all-balance-values '())

(define (run orders)
  (let ((balance 100)
        (peter-balance 0)
        (paul-balance 0)
        (mary-balance 0))
    (define (process x)
      (cond ((eq? x 'Peter-Get)
             (set! peter-balance balance))
            ((eq? x 'Peter-Set)
             (set! balance (+ peter-balance 10)))
            ((eq? x 'Paul-Get)
             (set! paul-balance balance))
            ((eq? x 'Paul-Set)
             (set! balance (- paul-balance 20)))
            ((eq? x 'Mary-Get)
             (set! mary-balance balance))
            ((eq? x 'Mary-Set)
             (set! balance (- mary-balance (/ mary-balance 2))))))
    (for-each process orders)
    
    (set! all-balance-values(adjoin-set balance all-balance-values))
    (display orders)
    (display ": ")
    (display balance)
    (newline)))

; 用于判断列表中 a 是否在 b 前面。
; 当 a 在 b 的前面时，肯定先搜索到 a, 再搜索到 b
(define (right-order? order a b)
  (and (memq a order)
       (memq b (memq a order))))

(define (gen-orders)
  (let* ((lst (list 'Peter-Get 'Peter-Set 'Paul-Get 'Paul-Set 'Mary-Get 'Mary-Set))
         (orders (arrange lst)))
    (filter (lambda (x)
              (and (right-order? x 'Peter-Get 'Peter-Set)
                   (right-order? x 'Paul-Get 'Paul-Set)
                   (right-order? x 'Mary-Get 'Mary-Set)))
            orders)))

(define orders (gen-orders))
(for-each run orders)
all-balance-values

