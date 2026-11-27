sorting
sortByNameThenActivity
^(#name collatedBy: #value), (#activity collatedBy: [:x | (x replaceAllRegex: '[a-zA-Z]' with: '') asInteger])