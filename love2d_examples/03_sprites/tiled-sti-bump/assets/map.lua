return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "0.18.2",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 10,
  height = 10,
  tilewidth = 32,
  tileheight = 32,
  nextobjectid = 11,
  properties = {},
  tilesets = {
    {
      name = "terrain",
      firstgid = 1,
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      image = "terrain.png",
      imagewidth = 1024,
      imageheight = 1024,
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      terrains = {},
      tilecount = 1024,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "Background",
      x = 0,
      y = 0,
      width = 10,
      height = 10,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        125, 125, 125, 125, 125, 125, 125, 125, 214, 125,
        125, 278, 279, 279, 279, 279, 279, 279, 280, 125,
        125, 310, 311, 311, 311, 311, 311, 311, 312, 125,
        125, 310, 311, 311, 311, 311, 311, 215, 344, 125,
        125, 310, 311, 311, 311, 311, 311, 312, 376, 125,
        125, 310, 311, 311, 311, 311, 311, 312, 125, 125,
        125, 310, 311, 311, 311, 311, 311, 312, 125, 125,
        125, 310, 311, 311, 311, 311, 311, 312, 125, 376,
        125, 342, 343, 343, 343, 343, 343, 344, 125, 125,
        125, 246, 125, 125, 125, 125, 125, 376, 125, 125
      }
    },
    {
      type = "tilelayer",
      name = "Deco",
      x = 0,
      y = 0,
      width = 10,
      height = 10,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 16, 0, 193, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 193, 0, 0, 637, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 669, 0, 0, 0, 0,
        0, 0, 0, 16, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      name = "Impassable",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {
        ["collidable"] = true,
        ["impassable"] = true
      },
      objects = {
        {
          id = 1,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 320,
          height = 56,
          rotation = 0,
          visible = true,
          properties = {
            ["collidable"] = true,
            ["impassable"] = true
          }
        },
        {
          id = 2,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 56,
          width = 56,
          height = 264,
          rotation = 0,
          visible = true,
          properties = {
            ["collidable"] = true,
            ["impassable"] = true
          }
        },
        {
          id = 3,
          name = "",
          type = "",
          shape = "rectangle",
          x = 56,
          y = 264,
          width = 264,
          height = 56,
          rotation = 0,
          visible = true,
          properties = {
            ["collidable"] = true,
            ["impassable"] = true
          }
        },
        {
          id = 4,
          name = "",
          type = "",
          shape = "rectangle",
          x = 264,
          y = 56,
          width = 56,
          height = 208,
          rotation = 0,
          visible = true,
          properties = {
            ["collidable"] = true,
            ["impassable"] = true
          }
        },
        {
          id = 6,
          name = "",
          type = "",
          shape = "rectangle",
          x = 224,
          y = 128,
          width = 40,
          height = 136,
          rotation = 0,
          visible = true,
          properties = {
            ["collidable"] = true,
            ["impassable"] = true
          }
        },
        {
          id = 7,
          name = "",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 176,
          width = 32,
          height = 48,
          rotation = 0,
          visible = true,
          properties = {
            ["collidable"] = true,
            ["impassable"] = true
          }
        },
        {
          id = 10,
          name = "",
          type = "",
          shape = "rectangle",
          x = 240,
          y = 104,
          width = 24,
          height = 24,
          rotation = 0,
          visible = true,
          properties = {
            ["collidable"] = true,
            ["impassable"] = true
          }
        }
      }
    },
    {
      type = "objectgroup",
      name = "Hot",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 8,
          name = "",
          type = "",
          shape = "rectangle",
          x = 96,
          y = 96,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["collidable"] = true,
            ["hot"] = true
          }
        },
        {
          id = 9,
          name = "",
          type = "",
          shape = "rectangle",
          x = 96,
          y = 224,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["collidable"] = true,
            ["hot"] = true
          }
        }
      }
    }
  }
}
