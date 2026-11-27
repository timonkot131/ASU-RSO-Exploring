importing
loadSource: aSource
^ aSource files collect: [ :each | YAML2JSON fromFile: each ]