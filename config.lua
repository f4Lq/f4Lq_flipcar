Config = {}

-- For debug
Config.Debug = false
Config.DebugCar = false

Config.TimesTillFlip = 15  -- How long TIME until the car flips.
Config.CustomProgBar = true -- If you have a custom progbar you can set it to a real line = 47 (Used progerssBar ox_lib)

Config.Langes = "en"
Config.Lang = {
	["en"] = {
		['flipped'] = 'You have flipped the vehicle!',
		['allset'] = 'Vehicle is already upright', 
		['in_vehicle'] = 'You can not flip the vehicle from inside!',
	},
	["de"] = {
		['flipped'] = 'Du hast das Fahrzeug umgekippt!',
		['allset'] = 'Das Fahrzeug steht bereits aufrecht.',
		['in_vehicle'] = 'Du kannst das Fahrzeug nicht von innen umkippen!',
	},
	["pl"] = {
		['flipped'] = 'Przewróciłeś pojazd!',
		['allset'] = 'Pojazd jest już przewrócony.',
		['in_vehicle'] = 'Nie możesz przechylić pojazdu od wewnątrz!',
	}
}

