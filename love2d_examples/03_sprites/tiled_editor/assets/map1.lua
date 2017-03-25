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
  nextobjectid = 12,
  properties = {},
  tilesets = {
    {
      name = "fantasy-tileset",
      firstgid = 1,
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      image = "fantasy-tileset.png",
      imagewidth = 256,
      imageheight = 832,
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      terrains = {},
      tilecount = 208,
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
        19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
        19, 9, 9, 9, 9, 9, 9, 9, 9, 19,
        19, 9, 9, 9, 10, 9, 9, 9, 9, 19,
        19, 9, 9, 9, 9, 9, 9, 9, 9, 19,
        19, 9, 9, 9, 9, 9, 10, 9, 9, 19,
        19, 9, 9, 9, 9, 9, 9, 9, 9, 19,
        19, 9, 9, 9, 10, 9, 9, 9, 9, 19,
        19, 9, 9, 9, 9, 9, 9, 9, 9, 19,
        19, 9, 9, 9, 9, 9, 9, 9, 9, 19,
        19, 19, 19, 19, 19, 19, 19, 19, 19, 19
      }
    },
    {
      type = "objectgroup",
      name = "Obstacles",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 1,
          name = "WallTop",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 320,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["isImpassable"] = true
          }
        },
        {
          id = 2,
          name = "WallBottom",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 288,
          width = 320,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["isImpassable"] = true
          }
        },
        {
          id = 4,
          name = "WallLeft",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 32,
          width = 32,
          height = 256,
          rotation = 0,
          visible = true,
          properties = {
            ["isImpassable"] = true
          }
        },
        {
          id = 5,
          name = "WallRight",
          type = "",
          shape = "rectangle",
          x = 288,
          y = 32,
          width = 32,
          height = 256,
          rotation = 0,
          visible = true,
          properties = {
            ["isImpassable"] = true
          }
        },
        {
          id = 6,
          name = "Obstacle",
          type = "",
          shape = "rectangle",
          x = 128,
          y = 64,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["isImpassable"] = true
          }
        },
        {
          id = 7,
          name = "Obstacle",
          type = "",
          shape = "rectangle",
          x = 192,
          y = 128,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["isImpassable"] = true
          }
        },
        {
          id = 8,
          name = "Obstacle",
          type = "",
          shape = "rectangle",
          x = 128,
          y = 192,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["isImpassable"] = true
          }
        }
      }
    },
    {
      type = "objectgroup",
      name = "SpawnObjects",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 10,
          name = "Player",
          type = "",
          shape = "rectangle",
          x = 32,
          y = 32,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "Exit",
          type = "",
          shape = "rectangle",
          x = 256,
          y = 256,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
