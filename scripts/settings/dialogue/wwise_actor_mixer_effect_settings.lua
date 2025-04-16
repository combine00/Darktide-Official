local wwise_actor_mixer_effect_settings = {
	nodes = {
		third_person = 251258888,
		first_person = 829615387
	},
	slots = {
		slot_2 = 2,
		slot_0 = 0,
		slot_3 = 3,
		slot_1 = 1
	},
	effects = {
		robo = 3059733992.0,
		harmonizer = 41385646,
		voicebox = 3168121006.0,
		tremolo = 3427672561.0,
		distortion = 3517175118.0,
		tube = 2689776681.0,
		futzbox = 2539875412.0,
		convulsion_tube = 2770168059.0,
		radio = 1900893695
	},
	presets = {
		default = {
			slot_2 = "futzbox",
			slot_0 = "voicebox",
			slot_1 = "robo"
		},
		tube_distortion = {
			slot_2 = "distortion",
			slot_0 = "convulsion_tube",
			slot_1 = "tube"
		}
	}
}

return settings("WwiseActorMixerEffectSettings", wwise_actor_mixer_effect_settings)
