{ lib, sing-box, src }:

sing-box.overrideAttrs (old: {
  pname = "sing-box-ref1nd";
  version = "1.14.2-reF1nd";

  inherit src;

  vendorHash = "sha256-9+1iHJoU4X1/drwSh82rjkTFQBSmEmvn7mHZCP7eU44=";
})
