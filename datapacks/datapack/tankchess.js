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
		this.customModelData = options.customModelData

		i = MovementType.all.find((v) => v.name === options.movementType)
		if (!i) throw new Error(`Unknown movementType '${i}'`)
		this.movementType = i

		this.speed = options.speed

		i = GunType.all.find((v) => v.name === options.gunType)
		if (!i) throw new Error(`Unknown gunType '${i}'`)
		this.gunType = i

		this.gunPower = options.gunPower
		this.armor = options.armor

		Vehicle.all.push(this)
	}
}

let lastSkinId = -1
class Skin {
	static all = []
	constructor(name) {
		lastSkinId++
		this.id = lastSkinId
		this.name = name
		this.customModelDataOffset = lastSkinId + Vehicle.all.length - 1
		Skin.all.push(this)
	}
}

new GunType('fixed')
new GunType('turret')
new GunType('mortar')

new MovementType('basic')

new Vehicle({
	name: 'lv',
	customModelData: 1,
	movementType: 'basic',
	speed: 5,
	gunType: 'turret',
	gunPower: 1,
	armor: new Armor(1, 0, 0),
})

new Skin('origin')
new Skin('spaceships')

module.exports = { GunType, MovementType, Vehicle, Skin }
