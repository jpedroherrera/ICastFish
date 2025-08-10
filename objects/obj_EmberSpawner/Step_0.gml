ember_timer += 1;

if (ember_timer >= ember_interval)
{
    ember_timer = 0;
    ember_interval = irandom_range(20, 50); // Slight randomness.

    var ember = instance_create_layer(x + random_range(-2, 2), y - 4, "WallsAndUtils", obj_Ember);

    // Random upward motion.
    ember.hspeed = random_range(-0.2, 0.2);
    ember.vspeed = random_range(-1.2, -0.6);
}

//Depth Sort with Player
DepthSorting("ember spawner");