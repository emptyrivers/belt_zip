local util = require "util"

data:extend{
  {
    type = "selection-tool",
    name = "belt-zipper",
    order = "bz_a",
    localised_name = {"item-name.belt-zipper"},
    localised_description = {"item-description.belt-zipper"},
    stack_size = 1,
    flags = {"hidden"},
    selection_color = util.color "add8e6",
    alt_selection_color = util.color "a9a9a9",
    selection_mode = {"matches-force", "blueprint"},
    alt_selection_mode = {"buildable-type"},
    selection_cursor_box_type = "electricity",
  },

  {
    type = "custom-input",
    name = "belt-zip-select",
    localised_name = {"input-name.belt-zip-select"},
    localised_description = {"input-description.belt-zip-select"},
    key_sequence = "ALT + Z",
  }
}