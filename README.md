Heightmap
=========

Overview
--------

A Lua module by Marc Lepage for producing heightmaps. Modified by Guard13007 to add built-in normalization.

The heightmap module uses the diamond-square algorithm to generate cloud or plasma fractal heightmaps which can be used for terrain.

Usage
-----

```lua
-- import module
local heightmap = require "heightmap"

-- create 32x32 heightmap
map = heightmap.create(32, 32)

-- examine each height value
for x = 0, map.w do
    for y = 0, map.h do
        print(map[x][y])
    end
end

-- define a custom height function
-- (reusing the default but scaling it)
function f(map, x, y, d, h)
    return 2 * heightmap.defaultf(map, x, y, d, h)
end

-- use it to create a larger non-square heightmap
map = heightmap.create(100, 200, f)

-- create a map with normalized range of -1 to 1
map = heightmap.create(150, 300, -1, 1)

-- use the custom height function and normalize with a range of 10 to 20
map = heightmap.create(200, 200, f, 10, 20)
```

How it Works
------------

The heightmap must be a square the size of a power of two, plus one, so that it can be evenly divided. For example, 4x4 cells will require 5x5 vertices. If another size is specified, a sufficiently large power of two square will be used, and the result clipped to the desired size.

First the four corners are seeded with a random value (C).

Then each square is used to set the value of its center (S) based on the average of its four corners (plus some randomness).

Then each diamond is used to set the value of its center (D) based on the average of its four points (plus some randomness).

The square and diamond steps continue until all values have been set:

      4     S 2    D 2    S 1    D 1
    C...C  c...c  c.D.c  c.d.c  cDdDc
    .....  .....  .....  .S.S.  DsDsD
    .....  ..S..  D.s.D  d.s.d  dDsDd
    .....  .....  .....  .S.S.  DsDsD
    C...C  c...c  c.D.c  c.d.c  cDdDc

The default height function randomly displaces values by up to +/- 0.5 of the step size. So above, the corners will be from -2 to +2, the center will be the mean of the corners randomly displaced from -1 to +1, and so on.

Resources
---------

* [Wikipedia: heightmap](http://en.wikipedia.org/wiki/Heightmap)
* [Wikipedia: diamond-square algorithm](http://en.wikipedia.org/wiki/Diamond-square_algorithm)
* [Wikipedia: fractal landscape](http://en.wikipedia.org/wiki/Fractal_landscape)
