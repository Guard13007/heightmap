math.randomseed(os.time())

local heightmap = require((...)\gsub("%.", "/") .. "/heightmap")

local floor = math.floor

local function min(t)
    local r = t[0][0]
    for i=0,#t do
        for j=0,#t[0] do
            if r > t[i][j] then r = t[i][j] end
        end
    end
    return r
end

local function max(t)
    local r = t[0][0]
    for i=0,#t do
        for j=0,#t[0] do
            if r < t[i][j] then r = t[i][j] end
        end
    end
    return r
end

local function create(width, height, f_or_min, min_or_max, max_if_f)
    if type(f_or_min) == "function" then
        local map = heightmap.create(width, height, f)
        local rangeMin = min_or_max
        local rangeMax = max_if_f
    else
        local map = heightmap.create(width, height)
        local rangeMin = f_or_min
        local rangeMax = min_or_max
    end

    local minimum = min(map)
    local initialRange = max(map) - minimum
    local finalRange = rangeMax - rangeMin
    for i=0,#map do
        for j=0,#map[0] do
            map[i][j] = (map[i][j] - minimum) / initialRange * finalRange + rangeMin
        end
    end

    map.min = min(map)
    map.max = max(map)

    return map
end

return {
    create = create,
    defaultf = heightmap.defaultf
}
