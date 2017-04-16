# Colorkinesis

**Colorkinesis** is a prototype game that I created for the the selection process of Fellowship of the Game, ICMC-USP game development group, in 2016. This is a Snake-like puzzle game, made in Lua language using the LOVE 2D framework. This prototype are made in LOVE 0.10.1; higher versions may need a change in *conf.lua* file.

All the graphic assets are from RPG Maker VX's Run-Time Package (RTP), from Enterbrain. All rights reserved. This is just a studying project.

## How to play

The main objective is reach the goal in each map (in this prototype, the goal is the jar). The girl moves like the snake head, in the classic game, with the arrow keys. There are magical doors blocking the goal; each door have a color and a number n. To pass through a door, the girl need to have n magic crystals (collected passing in colored tiles), in sequence, on the end of the "crystal snake". The crystals will be organized like a stack (first in, first out).

## Creating new levels

This prototype have just two levels, but the algorithm to read new levels in files works. To create a new level, go to the *levels* directory and create a new text file, with the extension *.level*. To play new levels in the game, go to the *modules/config.lua* file and update the list *levels* with the names of the new levels (no extension).

### Structure of level file
- Number A of columns of the level
- Number B of rows of the level
- A character matrix AxB for the walls/goal
- A character matrix AxB for magic crystals' spawn areas
- A character matrix AxB for magic doors

### Characters for walls/goal
- **W**: wall, have mortal collision
- **E**: grass, default tile, to walk
- **Z**: goal, achieve to win the map

### Characters for spawn areas
- **R**: red crystal spawn area
- **B**: blue crystal spawn area
- **G**: green crystal spawn area
- **P**: purple crystal spawn area

### Characters for doors
- **A, S, D**: red door with numbers 1, 2, 3, respectively
- **F, G, H**: blue door with numbers 1, 2, 3, respectively