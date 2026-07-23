{ writers, python3Packages }:

writers.writePython3Bin "kzzi-battery" {
  libraries = [ python3Packages.hidapi ];
} (builtins.readFile ../scripts/kzzi_battery.py)
