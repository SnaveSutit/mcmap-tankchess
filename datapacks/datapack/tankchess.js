class Armor {
	constructor(front, side, back) {
		this.front = front
		this.side = side
		this.back = back
	}
}

let lastMovementId = -1
class MovementType {
	static all = []
	constructor(name) {
		lastMovementId++
		this.id = lastMovementId
		this.name = name

		MovementType.all.push(this)
	}
}

let lastGunId = -1
class GunType {
	static all = []
	constructor(name) {
		lastGunId++
		this.id = lastGunId
		this.name = name

		GunType.all.push(this)
	}
}

let lastVehicleId = -1
class Vehicle {
	static all = []
	constructor(options) {
		let i
		lastVehicleId++
		this.id = lastVehicleId
		this.name = options.name

		i = MovementType.all.find(v => v.name === options.movementType)
		if (!i) throw new Error(`Unknown movementType '${i}'`)
		this.movementType = i

		this.speed = options.speed

		i = GunType.all.find(v => v.name === options.gunType)
		if (!i) throw new Error(`Unknown gunType '${i}'`)
		this.gunType = i

		this.gunPower = options.gunPower
		this.armor = options.armor

		Vehicle.all.push(this)
	}
}

new GunType('fixed')
new GunType('turret')
new GunType('mortar')

new MovementType('basic')

new Vehicle({
	name: 'lv',
	movementType: 'basic',
	speed: 5,
	gunType: 'turret',
	gunPower: 1,
	armor: new Armor(1, 0, 0),
})

new Vehicle({
	name: 'mv',
	movementType: 'basic',
	speed: 4,
	gunType: 'turret',
	gunPower: 2,
	armor: new Armor(2, 1, 0),
})

module.exports = { GunType, MovementType, Vehicle }
