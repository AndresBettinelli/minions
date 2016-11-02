class Minion{
	var energia
	var oficio
	var curriculum = new List()
	constructor(_e){
		energia = _e
		}
	
	method energia()=								return energia
	method ganarEnergia(num)						{ energia += num }
	method perderEnergia(num)						{ energia = (energia - num).max(0)}
	method comer(comida)							{ self.ganarEnergia( comida.nutrientes() ) }
	method asignarOficio(_oficio)					{ oficio = _oficio }
	method oficio() =								return oficio
	method fuerza() =								return energia/2.0 + 2.0 + oficio.fuerzaGanada()

	method experiencia() =							return curriculum.size() * curriculum.sum({ t => t.dificultad(self)})
	method agregarAlCurriculim(tarea)				{ curriculum.add(tarea) }
	method realizarTarea(tarea)						{ oficio.realizarTarea(self, tarea) }
//	method realizarTarea(tarea)						{ tarea.laRealiza(self) }
	
	method dificultadPorDefender(num) =				return num
	method tieneHerramientasParaRealizar(tarea){
		if(tarea.herramientasNecesarias().isEmpty()){ return true }
		else{ return tarea.herramientasNecesarias().all({ h => self.oficio().herramientas().contains(h)}) }
		}
}

class Biclope inherits Minion{
	constructor(_e) = super(_e.min(10))
	override method ganarEnergia(plus)				{ energia = (energia + plus).min(10)}
}

class Ciclope inherits Minion{
	constructor(_e) = super(_e)
	
	override method fuerza() =						return super()/2
	override method dificultadPorDefender(num) =	return num * 2
}