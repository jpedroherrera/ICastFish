// In your door object's Step Event
// Store player collision in a variable
var player_colliding = place_meeting(x, y, obj_Player);

if (player_colliding && !has_prompt) {
    // Create prompt only once
    prompt_instance = instance_create_layer(x + 27, y - 10, "MainInstances", obj_InteractPrompt);
    has_prompt = true;
}
else if (!player_colliding && has_prompt) {
    // Destroy prompt only when player leaves
    if (instance_exists(prompt_instance)) {
        instance_destroy(prompt_instance);
    }
    has_prompt = false;
}
