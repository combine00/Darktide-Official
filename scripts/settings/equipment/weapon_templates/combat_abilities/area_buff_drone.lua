local ProjectileTemplates = require("scripts/settings/projectile/projectile_templates")
local drone_weapon_template_generator = require("scripts/settings/equipment/weapon_templates/weapon_template_generators/drone_weapon_template_generator")
local weapon_template = drone_weapon_template_generator()
weapon_template.projectile_template = ProjectileTemplates.area_buff_drone
weapon_template.hud_icon = "content/ui/materials/icons/throwables/hud/area_buff_drone"

return weapon_template
