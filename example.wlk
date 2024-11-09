class Personaje{
  const property fuerza
  const property inteligencia
  var rol

  method cambiarDeRol(unRol){
    rol = unRol
  }
  method rol() = rol 

  method poderOfensivo() = fuerza * 10 * rol.extra()

  method esInteligente()

  method esGrosoEnSuRol() = rol.esGroso(self)

  method esGroso() = self.esInteligente() or self.esGrosoEnSuRol()
}
class Orco inherits Personaje{
  override method poderOfensivo() = super() * 1.1
  override method esInteligente() = false
}
class Humano inherits Personaje{
  override method esInteligente() = inteligencia > 50
}
//ROLES
object guerrero{
  method esGroso(unPersonaje) = unPersonaje.fuerza() > 50
  method extra() = 100
}
class Cazador{
  const property mascota
  method esGroso(unPersonaje) = mascota.esLongeba()
  method extra() = mascota.extra()
}
object brujo{
  method extra() = 0
   method esGroso(unPersonaje) = true
}
class Mascota{
  const property fuerza
  var edad
  const property tieneGarras
  method edad() = edad
  method aumentarEdad(){edad += 1}
  method esLongeba() = edad > 10
  method extra() = if(tieneGarras){fuerza*2}else{fuerza}
}
//localidades
class Localidad{
  var ejercito
  method potencialDefensivo() = ejercito.potencialTotal()
  method serOcupada(unEjercito)
}
class Aldea inherits Localidad{
  const property cantidadMaximaHabitantes
  override method serOcupada(unEjercito){
    if(unEjercito.size() > cantidadMaximaHabitantes){
      ejercito = unEjercito.nuevoEjercitoFuerte(10)
    }
    else{
      ejercito = unEjercito
    }
  }

}
class Ciudad inherits Localidad{
  override method potencialDefensivo() = super() + 300
  override method serOcupada(unEjercito){ejercito = unEjercito}
}
class Ejercito{
  const property personajes = []
  method puedeTomarLocalidad(unaLocalidad) = self.potencialTotal() > unaLocalidad.potencialDefensivo()
  method invadir(unaLocalidad){
    if(self.puedeTomarLocalidad(unaLocalidad)){
      unaLocalidad.serOcupada(self)
    }
  }
  method potencialTotal() = personajes.sum({p => p.poderOfensivo()})
  method nuevoEjercitoFuerte(unaCantidad){
    const nuevoEjercito = personajes.sortBy({p1,p2 => p1.poderOfensivo() > p2.poderOfensivo()}).take(unaCantidad)
    personajes.removeAll(nuevoEjercito)
    return new Ejercito(personajes = nuevoEjercito)
  }
}