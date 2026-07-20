pkgs:
with pkgs;
let
  python312Fixed = python312.override {
    packageOverrides = self: super: {
      inline-snapshot = super.inline-snapshot.overridePythonAttrs (_: { doCheck = false; });
      curl-cffi = super.curl-cffi.overridePythonAttrs (_: { doCheck = false; });
    };
  };
  pyqt5-fw = callPackage ./packages/pyqt5-frameless-window.nix {};
  pyqt-fluent = callPackage ./packages/pyqt-fluent-widgets.nix {
    pyqt5-frameless-window = pyqt5-fw;
  };
  videocaptioner = callPackage ./packages/videocaptioner.nix {
    python312Packages = python312Fixed.pkgs;
    inherit libsForQt5;
    pyqt-fluent-widgets = pyqt-fluent;
  };
in
  buildEnv {
    name = "videocaptioner-env";
    paths = [
      videocaptioner
      ffmpeg
      (makeDesktopItem {
        name = "videocaptioner";
        exec = "videocaptioner-gui";
        desktopName = "VideoCaptioner";
        comment = "AI-powered video captioning — ASR, subtitle optimization, translation, and synthesis";
        categories = [ "AudioVideo" "Video" ];
        terminal = false;
      })
    ];
  }
