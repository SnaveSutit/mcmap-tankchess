const fs = require('fs')
const readdir = require('@folder/readdir')
const pathjs = require('path')

const TELLRAW_PATH = './tellraw'

let tellrawMap = {}

module.exports = () => {
	tellrawMap = {}

	const files = readdir.sync(TELLRAW_PATH)
	for (const path of files) {
		const file = JSON.parse(fs.readFileSync(pathjs.join(TELLRAW_PATH, path), 'utf8'))
		const name = pathjs.basename(path, '.tellraw.json')
		tellrawMap[name] = file
	}

	console.log(`Loaded ${Object.keys(tellrawMap).length} tellraws.`)

	return tellrawMap
}
