{
  "resourceType": "GMObject",
  "resourceVersion": "1.0",
  "name": "obj_ui_fade",
  "eventList": [],
  "managed": true,
  "overriddenProperties": [
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","objectId":{"name":"obj_ui_parent","path":"objects/obj_ui_parent/obj_ui_parent.yy",},"propertyId":{"name":"ui_script_draw","path":"objects/obj_ui_parent/obj_ui_parent.yy",},"value":"ui_fade_draw",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","objectId":{"name":"obj_ui_parent","path":"objects/obj_ui_parent/obj_ui_parent.yy",},"propertyId":{"name":"ui_script_step","path":"objects/obj_ui_parent/obj_ui_parent.yy",},"value":"ui_fade_step",},
  ],
  "parent": {
    "name": "Objects",
    "path": "folders/[Engine]/Menu UI/Objects.yy",
  },
  "parentObjectId": {
    "name": "obj_ui_parent",
    "path": "objects/obj_ui_parent/obj_ui_parent.yy",
  },
  "persistent": false,
  "physicsAngularDamping": 0.1,
  "physicsDensity": 0.5,
  "physicsFriction": 0.2,
  "physicsGroup": 0,
  "physicsKinematic": false,
  "physicsLinearDamping": 0.1,
  "physicsObject": false,
  "physicsRestitution": 0.1,
  "physicsSensor": false,
  "physicsShape": 1,
  "physicsShapePoints": [],
  "physicsStartAwake": true,
  "properties": [
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"fade","filters":[
        "GMTileSet",
        "GMSprite",
        "GMSound",
        "GMPath",
        "GMScript",
        "GMShader",
        "GMFont",
        "GMTimeLine",
        "GMObject",
        "GMRoom",
      ],"listItems":null,"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"0","varType":0,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"fade_goal","filters":[
        "GMTileSet",
        "GMSprite",
        "GMSound",
        "GMPath",
        "GMScript",
        "GMShader",
        "GMFont",
        "GMTimeLine",
        "GMObject",
        "GMRoom",
      ],"listItems":null,"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"0","varType":0,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"fade_speed","filters":[
        "GMTileSet",
        "GMSprite",
        "GMSound",
        "GMPath",
        "GMScript",
        "GMShader",
        "GMFont",
        "GMTimeLine",
        "GMObject",
        "GMRoom",
      ],"listItems":null,"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"0.2","varType":0,},
  ],
  "solid": false,
  "spriteId": {
    "name": "spr_ui_fade",
    "path": "sprites/spr_ui_fade/spr_ui_fade.yy",
  },
  "spriteMaskId": null,
  "visible": true,
}