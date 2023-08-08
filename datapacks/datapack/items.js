const fs = require('fs')
const readdir = require('@folder/readdir')
const pathjs = require('path')

const ITEMS_PATH = './items'

let itemMap = {}

module.exports = () => {
	itemMap = {}

	const files = readdir.sync(ITEMS_PATH)
	for (const path of files) {
		const file = JSON.parse(fs.readFileSync(pathjs.join(ITEMS_PATH, path), 'utf8'))
		const name = pathjs.basename(path, '.items.json')
		itemMap[name] = file
	}

	console.log(`Loaded ${Object.keys(itemMap).length} items.`)

	return itemMap
}
