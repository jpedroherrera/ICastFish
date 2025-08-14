// Item configuration
item_id = "wooden_staff";
item_name = "Super Cool Wooden Staff";
item_type = "weapon";
item_value = 10; // Damage in this case.
item_sprite = sprite_index;

// Runs parent event.
event_inherited();

// Post parent event item configuration.
autopickup = true; // Tells parent object that it is an auto pickup item.
has_specific_post_pickup = true; // Tells the parent not to run post pickup function.
item_persistent = true; // This staff should remain through different rooms.

// Necessary variables.
state = "pickup"; // Current state
orbit_target = noone; // Player instance to orbit.
orbit_speed = 5; // Degrees per step.
orbit_radius = 15; // Distance from player.
orbit_angle = 0; // Current angle.
damage = 10; // Damage dealt to enemies.
