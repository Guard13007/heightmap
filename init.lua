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

local function create(width, height, f, rangeMin, rangeMax)
    local map = heightmap.create(width, height, f)

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
