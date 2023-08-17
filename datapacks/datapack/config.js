const fs = require('fs')
const resources = require('./resources')
const loadTellrawMap = require('./tellraw')
const loadItemMap = require('./items')

function toRad(deg) {
	return deg * (Math.PI / 180)
}

function wrap180(n) {
	var sign = Math.sign(n)
	n *= sign
	while (n > 180) n -= 360
	return n === 180 ? n : n * sign
}

class LocalCoordinate {
	constructor({ x, z, r }) {
		this.x = Math.round(x || 0)
		this.z = Math.round(z || 0)
		this.r = r || 0
	}

	add(other) {
		let rot = wrap180(this.r + other.r)
		let cos = Math.cos(toRad(rot))
		let sin = Math.sin(toRad(rot))
		return new LocalCoordinate({
			x: this.x + (other.x * cos - other.z * sin),
			z: this.z + (other.z * cos + other.x * sin),
			r: rot,
		})
	}

	equal(other) {
		if (this.x == other.x && this.z == other.z && this.r == other.r) {
			return true
		}
		return false
	}

	toJSON() {
		return {
			x: this.x,
			z: this.z,
			r: this.r,
		}
	}

	toString() {
		return `{"x":${this.x},"z":${this.z},"r":${this.r}}`
	}
}

module.exports = () => ({
	global: {
		preBuild: build => {},
		postBuild: build => {
			if (build.success) setTimeout(resources.buildResources, 25)
		},
	},
	mc: {
		dev: !process.argv.includes('-prod'),
		devCommands: process.argv.includes('-devCommands') && !process.argv.includes('-prod'),
		header: '# Developed by SnaveSutit\n# built using mc-build (https://github.com/mc-build/mc-build)',
		internalScoreboard: 'i',
		generatedDirectory: 'zzz',
		rootNamespace: null,

		get tellrawMap() {
			return loadTellrawMap()
		},

		get itemMap() {
			return loadItemMap()
		},

		get tc() {
			return require('./tankchess.js')
		},

		obstacles: ['a', 'b', 'c', 'd', 'e', 'e_mirror', 'f', 'f_mirror', 'g', 'g_mirror'],

		generateMoveTree(vehicle) {
			const flatTree = []
			let leafId = -1
			let branchId = -1
			function recurse(depth, local, direction) {
				if (depth > 1) {
					branchId++
					const branch = {
						id: branchId,
						type: 'branch',
						local: local,
						lastDir: direction,
						items: {
							straight: recurse(
								depth - 1,
								local.add({ x: 0, z: 1, r: 0 }),
								'straight'
							),
						},
					}

					if (!(direction === 'right')) {
						branch.items.left = recurse(
							depth - 1,
							local.add({ x: 0, z: 0, r: -45 }),
							'left'
						)
					}

					if (!(direction === 'left')) {
						branch.items.right = recurse(
							depth - 1,
							local.add({ x: 0, z: 0, r: 45 }),
							'right'
						)
					}

					flatTree.push(branch)
					return branch
				} else {
					leafId++
					const leaf = {
						id: leafId,
						type: 'leaf',
						local: local,
					}
					flatTree.push(leaf)
					return leaf
				}
			}

			const tree = recurse(
				vehicle.speed + 1,
				new LocalCoordinate({ x: 0, z: 0, r: 0 }, 'straight')
			)
			return flatTree
		},
	},
})
