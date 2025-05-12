(deftemplate smartphone
  (slot marca)
  (slot modelo)
  (slot color)
  (slot precio))

(deftemplate computadora
  (slot marca)
  (slot modelo)
  (slot color)
  (slot precio))

(deftemplate accesorio
  (slot tipo)
  (slot modelo)
  (slot precio))

(deftemplate tarjetacred
  (slot banco)
  (slot grupo)
  (slot exp-date))

(deftemplate cliente
  (slot nombre)
  (slot tipo)) ;; "menudista" o "mayorista"

(deftemplate orden
  (slot producto)
  (slot modelo)
  (slot cantidad)
  (slot cliente)
  (slot metodo-pago)) ;; ej. Banamex Oro, Contado

(deftemplate vale
  (slot cliente)
  (slot cantidad))

(deftemplate inventario
  (slot producto)
  (slot modelo)
  (slot cantidad))

(deftemplate combo-detectado
  (slot cliente)
  (slot subtotal))