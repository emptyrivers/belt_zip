local persist 
local defaultMt = {__index = function(self,k) self[k] = {} return self[k] end}

local function CollectData()
  persist.distances = {}
  for name, prototype in pairs(game.entity_prototypes) do
    persist.distances[name] = prototype.type == "underground-belt" and prototype.max_underground_distance or nil
  end
end

script.on_init(function()
  persist = global
  CollectData()
  persist.zipped = setmetatable({}, defaultMt)
end)

script.on_load(function()
  persist = global
  setmetatable(persist.zipped, defaultMt)
end)

script.on_configuration_changed(function()
  CollectData()
end)

script.on_event("belt-zip-select", function(event)
  local player = game.players[event.player_index]
  local stack = player.cursor_stack
  if stack.valid_for_read then
    if stack.name == "belt-zipper" then --remove belt zipper
      stack.clear()
    else
      if player.clean_cursor() then
        stack.set_stack "belt-zipper"
      end
    end
  else
    stack.set_stack "belt-zipper"
  end
end)

script.on_event(defines.events.on_player_dropped_item, function(event)
  local entity = event.entity
  if entity.stack.name == "belt-zipper" then
    entity.destroy()
  end
end)

script.on_event(defines.events.on_player_selected_area, function(event)
  local entities, toExamine = event.entities, {}
  for _, entity in pairs(entities) do
    if entity.type == "underground-belt" then
      toExamine[entity] = persist.distances[entity.name]
    end
  end

end)
script.on_event(defines.events.on_player_alt_selected_area, function(event)
  -- unzip
end)