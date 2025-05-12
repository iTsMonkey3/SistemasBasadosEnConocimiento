(deffacts base-conocimientos
  ;; Smartphones
  (smartphone (marca "Apple") (modelo "iPhone16") (color "Rojo") (precio 27000))
  (smartphone (marca "Samsung") (modelo "Note21") (color "Negro") (precio 22000))
  (smartphone (marca "Xiaomi") (modelo "Redmi Note 13") (color "Blanco") (precio 12000))

  ;; Computadoras
  (computadora (marca "Apple") (modelo "MacBookPro") (color "Gris") (precio 47000))
  (computadora (marca "Apple") (modelo "MacBookAir") (color "Gris") (precio 32000))
  (computadora (marca "HP") (modelo "Pavilion") (color "Rojo") (precio 23000))

  ;; Accesorios
  (accesorio (tipo "Funda") (modelo "Funda-Universal") (precio 300))
  (accesorio (tipo "Mica") (modelo "Mica-Antirreflejo") (precio 150))
  (accesorio (tipo "Funda") (modelo "Funda-iPhone 14 Pro Max") (precio 450))
  (accesorio (tipo "Cargador") (modelo "Cargador-FastCharge 30W") (precio 600))
  (accesorio (tipo "Audífonos") (modelo "Audifonos-Bluetooth Pro") (precio 1200))
  (accesorio (tipo "Mica") (modelo "Mica-Privacidad") (precio 200))

  ;; Inventario
  (inventario (producto "smartphone") (modelo "Redmi Note 13") (cantidad 20))
  (inventario (producto "smartphone") (modelo "iPhone16") (cantidad 50))
  (inventario (producto "smartphone") (modelo "Note21") (cantidad 30))
  (inventario (producto "computadora") (modelo "MacBookPro") (cantidad 20))
  (inventario (producto "computadora") (modelo "MacBookAir") (cantidad 15))
  (inventario (producto "computadora") (modelo "Pavilion") (cantidad 15))
  (inventario (producto "accesorio") (modelo "Funda-Universal") (cantidad 25))           
  (inventario (producto "accesorio") (modelo "Mica-Antirreflejo") (cantidad 30))        
  (inventario (producto "accesorio") (modelo "Funda-iPhone 14 Pro Max") (cantidad 20))   
  (inventario (producto "accesorio") (modelo "Cargador-FastCharge 30W") (cantidad 15))      
  (inventario (producto "accesorio") (modelo "Audifonos-Bluetooth Pro") (cantidad 10))       
  (inventario (producto "accesorio") (modelo "Mica-Privacidad") (cantidad 18))          

  ;; Tarjetas de crédito
  (tarjetacred (banco "Banamex") (grupo "Oro") (exp-date "01-12-23"))
  (tarjetacred (banco "Liverpool") (grupo "VISA") (exp-date "15-11-24"))

  ;; Clientes
  (cliente (nombre "Juan Perez") (tipo "no-aplica"))
  (cliente (nombre "Ana Lopez") (tipo "no-aplica"))

  (computadora (marca "HP") (modelo "Pavilion") (color "Negro") (precio 18500))
  
)