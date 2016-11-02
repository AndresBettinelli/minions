class Trabajador {
	var herramientas = new List()
	
	method herramientas() =					return herramientas
	method fuerzaGanada() =					return 0
	method puedeDefender() =				true
	method aumentarPractica()				{ }
	method energiaPorDefender(num) =		return num / 2
	method energiaPorLimpiar(num) =			return num
	method realizarTarea(minion, tarea)		{ tarea.laRealiza(minion) }
}

class Soldado inherits Trabajador{
	var practica = 0
	override method fuerzaGanada() =		return practica * 2
	override method aumentarPractica()		{ practica += 1}
	override method energiaPorDefender(num)	{ return 0 }	
}

object mucama inherits Trabajador{
	override method puedeDefender()=				false
	override method energiaPorLimpiar(num) =		return 0
}

class Obrero inherits Trabajador{
	constructor(_h){ herramientas = _h }
}

class Capataz inherits Trabajador{
	var equipo
	constructor(_e) {equipo = _e}
	method ordenarPorExperiencia(){ return equipo.sortedBy({masExp, menosExp => masExp.experiencia() >= menosExp.experiencia()}) }
	override method realizarTarea(minion, tarea){
		try{
			self.ordenarPorExperiencia().find({ m => tarea.puedeRealizarla(m)})
		} catch e:ElementNotFoundException{
			tarea.laRealiza(minion)
		}
	}
}