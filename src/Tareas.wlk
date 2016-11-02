import Excepciones.*

class Tarea{
	var complejidad
	method complejidad() =						return complejidad
	method dificultad(minion) =					return complejidad
	method energiaNecesaria(minion)=			return complejidad
	method puedeRealizarla(minion) =			return minion.energia() >= self.energiaNecesaria(minion)
	method laRealiza(minion){
		if(self.puedeRealizarla(minion)){
			minion.perderEnergia( self.energiaNecesaria(minion) )
			minion.agregarAlCurriculim(self)
		}
		else{ throw new NoPuedeRealizarTarea()}
	}
}

class Arreglar inherits Tarea{
	var herramientasNecesarias
	constructor(_c, _h){ complejidad = _c; herramientasNecesarias = _h }
	
	method herramientasNecesarias() =			return herramientasNecesarias
	override method dificultad(minion) =		return super(minion) * 2
	override method puedeRealizarla(minion) =	return super(minion) && minion.tieneHerramientasParaRealizar(self)
	override method laRealiza(minion){
		try { super(minion) }
		catch e: NoPuedeRealizarTarea{ throw new NoPuedeArreglar() }
	}
}

class Defender inherits Tarea{
	constructor(gradoDeAmenza){ complejidad = gradoDeAmenza }
	
	override method dificultad(minion) =		return minion.dificultadPorDefender(complejidad)
	override method energiaNecesaria(minion)=	return minion.oficio().energiaPorDefender( complejidad )
	override method puedeRealizarla(minion) =	return minion.oficio().puedeDefender() && minion.fuerza() >= self.complejidad()
	override method laRealiza(minion){ 
		try { super(minion) }
		catch e: NoPuedeRealizarTarea{ throw new NoPuedeDefender() }
		minion.oficio().aumentarPractica()
	}
}

class Limpieza inherits Tarea{
	var sector
	constructor(_sector){ sector = _sector; complejidad = complejidadParaTodasLasTareasDeLimpieza.es()}
	
	method sector() =							return sector
	override method energiaNecesaria(minion) =	return minion.oficio().energiaPorLimpiar( sector.energiaNecesaria() )
	override method laRealiza(minion){ 
		try { super(minion) }
		catch e: NoPuedeRealizarTarea{ throw new NoPuedeLimpiar() }
	}
}
object complejidadParaTodasLasTareasDeLimpieza{
	var complejidad = 10
	method es() =						return complejidad
	method cambiarComplejidad(num)		{complejidad = num}
}