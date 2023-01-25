config = {
}

--Configuration Marker--
config.markertype = 6 
config.red = 0 
config.green = 155 
config.blue = 255 
config.opacity = 200 



--Customisation Menu--
config.BanniereColorActivation = false


--Configuration Laboratoire Option--
--Merci de choisi seulement 1 OPTION--
config.codelabo = false 
config.standardlabo = false
config.keylabo = true


--Configuration Code Labo (Si config.codelabo = true)
config.codelabometh = '1111'
config.codelaboweed = '1111'
config.codelabocoke = '1111'
config.codelaboopium = '1111'




--Couleur Menu (Si config.BanniereColorActivation = true)--
config.BanniereRed = 00
config.BanniereGreen = 00
config.BanniereBlue = 00
config.BanniereOpacity = 255
-----------------------------------------------------------

--Position--
Config = {
    Policerminimum = 0,
--------------------Tenue Position--------------------

    position = { 
        vector3(1002.76, -3195.08, -39.99),
        vector3(1060.41, -3183.36, -40.13),
        vector3(1087.4, -3194.35, -39.99),
        vector3(2331.6047363281,2571.287109375,45.682762145996)
    },
------------------------------------------------------


--------------------Meth--------------------
    teleportationmeth = { 
        vector3(1407.96, 3619.23, 34.89),
        vector3(997.21, -3200.80, -36.39),
    },

    methpositionrecolte = {
        vector3(2433.92, 4969.07, 42.35),
    },

    methpositiontraitement = {
        vector3(1005.72, -3200.40, -38.51),
    },

    methpositionemballage = {
        vector3(1013.43, -3195.17, -38.99),
    },
--------------------------------------------

--------------------Weed--------------------
teleportationweed = { 
    vector3(-1108.3, -1643.17, 4.64),
    vector3(1066.14, -3183.48, -39.16),
},

weedpositionrecolte = {
    vector3(2224.22, 5577.11, 53.84),
},

weedpositiontraitement = {
    vector3(1057.49, -3197.23, -39.13),
},

weedpositionemballage = {
    vector3(1039.43, -3205.17, -38.15),
},
--------------------------------------------

--------------------Coke--------------------
teleportationcoke = { 
    vector3(-13.61, 6480.58, 31.43),
    vector3(1088.69, -3187.79, -38.99),
},

cokepositionrecolte = {
    vector3(2224.22, 5577.11, 53.84),
},

cokepositiontraitement = {
    vector3(1090.47, -3196.73, -38.99),
},

cokepositionemballage = {
    vector3(1101.92, -3194.01, -38.99),
},
--------------------------------------------

--------------------Opium--------------------
teleportationopium = { 
    vector3(0,0,0),
    vector3(0,0,0),
},

opiumpositionrecolte = {
    vector3(1443.3032226563,6332.1948242188,23.981889724731),
},

opiumpositiontraitement = {
    vector3(2328.2475585938,2569.9877929688,46.67692565918),
},

opiumpositionemballage = {
    vector3(2328.6162109375,2572.3364257813,46.67663192749),
},
---------------------------------------------

--------------------Opium--------------------
blanchimentposition = {
    vector3(1122.322265625,-3194.7202148438,-40.399997711182),
},

blanchimentteleportposition = {
    vector3(285.06185913086,-977.87432861328,44.987602233887),
    vector3(1138.0454101563,-3198.8271484375,-39.665729522705),
}
---------------------------------------------

}

