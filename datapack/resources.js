const fs = require('fs')
const pathjs = require('path')

const fontPath = 'D:/github-repos/mcmap-tankchess/resources/assets/tankchess/font'
const langPath = 'D:/github-repos/mcmap-tankchess/resources/assets/tankchess/lang/en_us.json'

class Font {
	static all = []

	constructor(name) {
		this.name = name
		this.chars = []
		this.lastChar = 61440 // \uf000 +

		Font.all.push(this)
	}

	/**
	 * @param {string} translation - The translation key to use to reference this character
	 * @param {string} file - The character's texture file
	 * @param {number} ascent - How far above the text line to render the character
	 * @param {number} height - How large to render the character
	 * @param {string} char - What character to replace with this one
	 */
	newChar(translation, file, ascent, height) {
		this.chars.push({
			translation: translation,
			file,
			ascent,
			height,
			type: 'bitmap',
			char: translation.length !== 1 ? String.fromCharCode(this.lastChar++) : translation,
		})
		return this
	}

	toJSON() {
		return {
			providers: this.chars.map(v => ({
				file: v.file,
				ascent: v.ascent,
				height: v.height,
				type: v.type,
				chars: [v.char],
			})),
		}
	}
}

function instantiate() {
	new Font('vehicle_icons')
		.newChar('icon.command', 'tankchess:font/vehicle_icons/command.png', 31, 31)
		.newChar('icon.lv', 'tankchess:font/vehicle_icons/lv.png', 31, 31)
		.newChar('icon.mv', 'tankchess:font/vehicle_icons/mv.png', 31, 31)
		.newChar('icon.hv', 'tankchess:font/vehicle_icons/hv.png', 31, 31)
		.newChar('icon.vd', 'tankchess:font/vehicle_icons/vd.png', 31, 31)
		.newChar('icon.hm', 'tankchess:font/vehicle_icons/hm.png', 31, 31)

		.newChar('icon.command', 'tankchess:font/vehicle_icons/command_small.png', 0, 7)
		.newChar('icon.lv_s', 'tankchess:font/vehicle_icons/lv_small.png', 0, 7)
		.newChar('icon.mv_s', 'tankchess:font/vehicle_icons/mv_small.png', 0, 7)
		.newChar('icon.hv_s', 'tankchess:font/vehicle_icons/hv_small.png', 0, 7)
		.newChar('icon.vd_s', 'tankchess:font/vehicle_icons/vd_small.png', 0, 7)
		.newChar('icon.hm_s', 'tankchess:font/vehicle_icons/hm_small.png', 0, 7)

	new Font('nametags')
		.newChar('background', 'tankchess:font/nametag_background.png', 0, 16)

		.newChar('icon.commander', 'tankchess:font/vehicle_icons/command_nametag.png', 0, 16)
		.newChar('1', 'tankchess:font/vehicle_icons/lv_nametag.png', 0, 16)
		.newChar('2', 'tankchess:font/vehicle_icons/mv_nametag.png', 0, 16)
		.newChar('3', 'tankchess:font/vehicle_icons/hv_nametag.png', 0, 16)
		.newChar('4', 'tankchess:font/vehicle_icons/vd_nametag.png', 0, 16)
		.newChar('5', 'tankchess:font/vehicle_icons/hm_nametag.png', 0, 16)

	new Font('player_numbers')
		.newChar('p', 'tankchess:font/player_numbers/p.png', 0, 16)
		.newChar('1', 'tankchess:font/player_numbers/1.png', 0, 16)
		.newChar('2', 'tankchess:font/player_numbers/2.png', 0, 16)
		.newChar('3', 'tankchess:font/player_numbers/3.png', 0, 16)
		.newChar('4', 'tankchess:font/player_numbers/4.png', 0, 16)
}

function buildResources() {
	const lang = JSON.parse(fs.readFileSync(langPath))

	for (const font of Font.all) {
		fs.writeFileSync(pathjs.join(fontPath, `${font.name}.json`), JSON.stringify(font))
		for (const char of font.chars) {
			if (char.translation !== char.char) lang[char.translation] = char.char
		}
	}

	fs.writeFileSync(langPath, JSON.stringify(lang, null, '\t'))
}

instantiate()

module.exports = {
	buildResources,
}
