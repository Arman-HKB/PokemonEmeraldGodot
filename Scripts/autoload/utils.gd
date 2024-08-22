extends Node

func get_current_scene():
	return get_node("/root/SceneManager/Current")

func get_player():
	return get_node("/root/SceneManager/Current").get_children().back().get_node("Player")
	
func get_scene_manager():
	return get_node("/root/SceneManager")
 
func update_pokemon_stats(pokemon : Resource):
	pokemon.hp = (2 * pokemon.base_hp + pokemon.hp_iv + pokemon.hp_ev/4) * pokemon.level / 100 + pokemon.level + 10
	pokemon.max_hp = pokemon.hp
	pokemon.attack = ((2 * pokemon.base_attack + pokemon.attack_iv + pokemon.attack_ev/4) * pokemon.level / 100 + 5)*1
	pokemon.defence = ((2 * pokemon.base_defence + pokemon.defence_iv + pokemon.defence_ev/4) * pokemon.level / 100 + 5)*1
	pokemon.special_attack = ((2 * pokemon.base_special_attack + pokemon.special_attack_iv + pokemon.special_attack_ev/4) * pokemon.level / 100 + 5)*1
	pokemon.special_defence = ((2 * pokemon.base_special_defence + pokemon.special_defence_iv + pokemon.special_defence_ev/4) * pokemon.level / 100 + 5)*1
	pokemon.speed = ((2 * pokemon.base_speed + pokemon.speed_iv + pokemon.speed_ev/4) * pokemon.level / 100 + 5)*1
	return pokemon
 
