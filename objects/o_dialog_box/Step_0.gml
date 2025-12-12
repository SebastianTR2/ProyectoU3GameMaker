if (!active) exit;

var _confirm = keyboard_check_pressed(ord("E")) || keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space);
var _up = keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"));
var _down = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"));

// Initialize options array if missing
if (!variable_instance_exists(id, "options")) options = [];

if (array_length(options) > 0) {
    // Navigate Options
    if (_up) selected_option--;
    if (_down) selected_option++;
    
    // Wrap around
    var _len = array_length(options);
    if (selected_option < 0) selected_option = _len - 1;
    if (selected_option >= _len) selected_option = 0;
    
    if (_confirm) {
        // Execute Choice based on state and index
        if (global.DialogState == "offer_can_accept") {
            if (selected_option == 0) { // ACCEPT
                accept_blessing(global.DialogGodID);
            } else { // REJECT
                // Optional: rejection dialog logic here?
            }
        } 
        else if (global.DialogState == "offer_must_swap") {
            // Options are usually: [Replace 1, Replace 2, Replace 3, Cancel]
            if (selected_option < 3) {
                // Determine actual slot index
                // Note: The UI shows the active blessings. We assume options[0] corresponds to slot 0, etc.
                swap_blessing(global.DialogGodID, selected_option);
            } else {
                // Cancel/Reject
            }
        }
        
        // Always close after choice (functions called above should handle logic)
        instance_destroy();
    }
} else {
    // Info only (press anything to close)
    if (_confirm || _up || _down) {
        instance_destroy();
    }
}
