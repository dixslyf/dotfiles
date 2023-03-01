def npins_matrix($npins_dir):
    .pins
    | keys_unsorted
    | [{ name: .[], "npins-dir": $npins_dir }]
;
