{ writers, python3Packages }:

writers.writePython3Bin "kzzi-light" {
  libraries = [ python3Packages.hidapi ];
} (builtins.readFile ../scripts/kzzi_light.py)
