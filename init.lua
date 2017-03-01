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
    local maximum = max(map)

    --[[
    -- if minimum is below zero, + everything till minimum is zero
    if minimum < 0 then
        for i=0,#map do
            for j=0,#map[0] do
                map[i][j] = map[i][j] - minimum
            end
        end
    end
    --]]

    -- normalize range of values to desired range
    for i=0,#map do
        for j=0,#map[0] do
            --floor(map[i][j] * NEW_MAX_VALUE / maximum)
            map[i][j] = (map[i][j] - minimum) / (maximum - minimum)
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
