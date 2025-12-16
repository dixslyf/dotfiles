{
  writeShellScriptBin,
  qmk,
}:

{
  qmkSrc,
  keyboardName,
  firmwareFile,
}:

writeShellScriptBin "flash-qmk-firmware-${keyboardName}" ''
  export QMK_HOME='${qmkSrc}'
  ${qmk}/bin/qmk flash '${firmwareFile}'
''
