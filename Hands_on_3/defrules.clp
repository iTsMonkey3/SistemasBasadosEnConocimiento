;;1
(deffunction mostrar-stock-total ()
  (printout t crlf " Inventario actual " crlf)
  (do-for-all-facts ((?f inventario)) TRUE
    (printout t "Producto: " ?f:producto ", Modelo: " ?f:modelo ", Stock: " ?f:cantidad crlf)))

;;2
(deffunction mostrar-vales ()
  (do-for-all-facts ((?v vale)) TRUE
    (printout t "🎫 Cliente: " ?v:cliente ", Vales: " ?v:cantidad crlf)))

;;3
(defrule validar-cantidad
  ?orden <- (orden (cantidad ?q))
  (test (<= ?q 0))
  =>
  (printout t "⚠ Error: La cantidad debe ser mayor a 0." crlf)
  (retract ?orden))

;;21 detalle
;; (defrule mostrar-detalle-orden
;;  (orden (cliente ?c) (producto ?p) (cantidad ?q) (metodo-pago ?m))
;;  =>
;;  (printout t "-------------------------" crlf)
;;  (printout t "🧾 Detalle de Orden:" crlf)
;;  (printout t "- Cliente: " ?c crlf)
;;  (printout t "- Producto: " ?p crlf)
;;  (printout t "- Cantidad: " ?q crlf)
;;  (printout t "- Método de pago: " ?m crlf)
;;  (printout t "-------------------------" crlf))

(defrule mostrar-detalle-orden
  (orden (cliente ?c) (producto ?p) (modelo ?m) (cantidad ?q) (metodo-pago ?mp))
  (or 
    (smartphone (modelo ?m) (precio ?precio))
    (computadora (modelo ?m) (precio ?precio))
    (accesorio (modelo ?m) (precio ?precio)))
  =>
  (bind ?total (* ?q ?precio))
  (printout t "-------------------------" crlf)
  (printout t "🧾 Detalle de Orden:" crlf)
  (printout t "- Cliente: " ?c crlf)
  (printout t "- Producto: " ?p crlf)
  (printout t "- Modelo: " ?m crlf)
  (printout t "- Cantidad: " ?q crlf)
  (printout t "- Método de pago: " ?mp crlf)
  (printout t "- Total: $" ?total crlf)
  (printout t "-------------------------" crlf))

;;4
;;(defrule clasif-menudista
;;  (orden (cliente ?c) (cantidad ?q))
;;  (test (< ?q 10))
;;  =>
;;  (printout t "Cliente " ?c " clasificado como MENUDISTA (Cantidad: " ?q ")." crlf))

(defrule clasif-menudista
  (orden (cliente ?c) (cantidad ?q))
  ?cl <- (cliente (nombre ?c) (tipo ?t))
  (test (< ?q 10))
  (test (neq ?t "menudista"))
  =>
  (retract ?cl)
  (assert (cliente (nombre ?c) (tipo "menudista")))
  (printout t "✔ Cliente " ?c " reclasificado como MENUDISTA (Cantidad: " ?q ")." crlf))


;;5
;; (defrule clasif-mayorista
;;  (orden (cliente ?c) (cantidad ?q))
;;  (test (>= ?q 10))
;;  =>
;;  (printout t "Cliente " ?c " clasificado como MAYORISTA (Cantidad: " ?q ")." crlf))

(defrule clasif-mayorista
  (orden (cliente ?c) (cantidad ?q))
  ?cl <- (cliente (nombre ?c) (tipo ?t))
  (test (>= ?q 10))
  (test (neq ?t "mayorista"))
  =>
  (retract ?cl)
  (assert (cliente (nombre ?c) (tipo "mayorista")))
  (printout t "✔ Cliente " ?c " reclasificado como MAYORISTA (Cantidad: " ?q ")." crlf))


;;20
(defrule entrega-gratis-cantidad
  (orden (cantidad ?q) (cliente ?c))
  (test (> ?q 10))
  =>
  (printout t "🚚 Entrega gratuita activada para la orden de " ?c crlf))

;;6
(defrule promo-banamex
  (orden (producto "smartphone") (modelo "iPhone16") (metodo-pago "Banamex Oro"))
  =>
  (printout t "Promoción: 24 meses sin intereses en iPhone16 con Banamex Oro." crlf))

;;7
(defrule promo-liverpool
  (orden (producto "smartphone") (modelo "Note21") (metodo-pago "Liverpool VISA"))
  =>
  (printout t "Promoción: 12 meses sin intereses en Note21 con Liverpool VISA." crlf))

;;8
(defrule promo-accesorio
  (orden (producto "smartphone") (modelo ?modelo) (cliente ?cliente))
  =>
  (printout t "Descuento: 15% en funda y mica por la compra de un smartphone." crlf))

;;9
(defrule detectar-combo-contado
  ?orden1 <- (orden (producto "smartphone") (modelo "iPhone16") (cantidad ?q1) (cliente ?c) (metodo-pago "Contado"))
  ?orden2 <- (orden (producto "computadora") (modelo "MacBookAir") (cantidad ?q2) (cliente ?c) (metodo-pago "Contado"))
  =>
  (bind ?subtotal (+ (* 27000 ?q1) (* 32000 ?q2)))
  (assert (combo-detectado (cliente ?c) (subtotal ?subtotal))))

;;10
(defrule otorgar-vales-combo
  ?combo <- (combo-detectado (cliente ?c) (subtotal ?subtotal))
  =>
  (bind ?vales (/ ?subtotal 1000))
  (assert (vale (cliente ?c) (cantidad ?vales)))
  (retract ?combo)
  (printout t "🎁 Cliente " ?c " recibe " ?vales " vales por combo iPhone16 + MacBookAir. Total $" ?subtotal crlf))

;;11
(defrule otorgar-vales-compra
  (orden (producto ?producto) (modelo ?modelo) (cantidad ?cantidad) (cliente ?cliente))
  (or (smartphone (modelo ?modelo) (precio ?precio))
      (computadora (modelo ?modelo) (precio ?precio)))
  (test (>= (* ?precio ?cantidad) 10000))
  =>
  (bind ?vales (/ (* ?precio ?cantidad) 1000))
  (assert (vale (cliente ?cliente) (cantidad ?vales)))
  (printout t "🎁 Cliente " ?cliente " recibe " ?vales " vales por compra de $" (* ?precio ?cantidad) "." crlf))





;;13
(defrule oferta-hp-descuento
  (orden (producto "computadora") (modelo "Pavilion") (cliente ?c))
  =>
  (printout t "🎉 Oferta especial: 10% de descuento en HP Pavilion para " ?c crlf))

;;14
(defrule recomendacion-iphone-accessorios
  (orden (producto "smartphone") (modelo "iPhone16") (cliente ?c))
  =>
  (printout t "💡 Recomendación: Añade funda y mica para proteger tu iPhone16, " ?c crlf))

;;15
(defrule combo-samsung-accesorio
  (orden (producto "smartphone") (modelo "Note21") (cliente ?c))
  =>
  (printout t "📦 Combo: Llévate un cargador Samsung con 50% de descuento por tu compra Note21, " ?c crlf))

;;16
(defrule compra-mayorista-bonificacion
  (orden (cliente ?c) (cantidad ?q))
  (cliente (nombre ?c) (tipo "mayorista"))
  (test (> ?q 15))
  =>
  (printout t "🎊 Bonificación: Cliente mayorista " ?c " recibe 5% adicional en su siguiente compra." crlf))

;;17
(defrule recomendacion-backup-macbook
  (orden (producto "computadora") (modelo "MacBookPro") (cantidad ?q) (cliente ?c) (metodo-pago ?m))
  =>
  (printout t "💾 Recomendación: Añade un disco externo para backups en tu MacBookPro, " ?c crlf))


;;18
(defrule acceso-premium-macbook
  (orden (producto "computadora") (modelo "MacBookAir") (cliente ?c))
  =>
  (printout t "🔐 Regalo: 1 año de acceso premium a software de productividad con tu MacBookAir." crlf))

;;19
(defrule aviso-stock-bajo
  (inventario (producto ?p) (modelo ?m) (cantidad ?c))
  (test (<= ?c 5))
  =>
  (printout t "⚠️ Alerta: Stock bajo para " ?p " modelo " ?m ": quedan " ?c " unidades." crlf))

;;22
(defrule recordatorio-garantia
  (orden (producto ?p) (modelo ?m) (cliente ?c))
  =>
  (printout t "🧾 Recuerda registrar tu garantía para el producto: " ?p " modelo " ?m crlf))

;;23
(defrule mensaje-agradecimiento
  (orden (cliente ?c))
  =>
  (printout t "🙏 Gracias por tu compra, " ?c "! Esperamos verte pronto." crlf))

;;24
(defrule recomendacion-limpieza-mica
  (declare (salience 10))
  (orden (producto "accesorio") (modelo ?modelo) (cliente ?c))
  (accesorio (tipo "Mica") (modelo ?modelo))
  =>
  (printout t "✨ Recomendación: " ?c ", recuerda usar un paño de microfibra antes de aplicar la mica modelo " ?modelo "." crlf))

;;25
(defrule recomendacion-cuidado-audifonos
  (declare (salience 10))
  (orden (producto "accesorio") (modelo ?modelo) (cliente ?c))
  (accesorio (tipo "Audífonos") (modelo ?modelo))
  =>
  (printout t "🎧 Tip: " ?c ", guarda siempre tus audífonos " ?modelo " en su estuche para mayor duración." crlf))

;;26
(defrule bonificacion-accesorios
  (declare (salience 10))
  (orden (producto "accesorio") (modelo ?m) (cantidad ?q) (cliente ?c))
  (test (> ?q 2))
  =>
  (printout t "🎁 Bonificación: " ?c " recibe un descuento especial por comprar más de 2 accesorios modelo " ?m "." crlf))

;;12
(defrule actualizar-stock
  (declare (salience -10)) ; menor prioridad
  ?orden <- (orden (producto ?producto) (modelo ?modelo) (cantidad ?cantidad) (cliente ?cliente) (metodo-pago ?mp))
  ?inv <- (inventario (producto ?producto) (modelo ?modelo) (cantidad ?stock))
  (test (>= ?stock ?cantidad))
  =>
  (bind ?nuevo-stock (- ?stock ?cantidad))
  (retract ?inv)
  (assert (inventario (producto ?producto) (modelo ?modelo) (cantidad ?nuevo-stock)))
  (printout t "✔ Orden procesada y eliminada: " ?producto " " ?modelo crlf)
  (printout t "📦 Stock actualizado: " ?producto " " ?modelo " = " ?nuevo-stock crlf)
  (retract ?orden)) 