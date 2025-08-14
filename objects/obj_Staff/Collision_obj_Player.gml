// Runs parent event.
event_inherited();

// Override script for staff-specific behavior.
if (!has_been_picked_up) post_pickup(other.id, { message: "Picked up wooden staff!", room: room });

has_been_picked_up = true;
