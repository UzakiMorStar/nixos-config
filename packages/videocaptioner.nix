{ lib, python312Packages, fetchurl, libsForQt5, pyqt-fluent-widgets, makeBinaryWrapper }:

python312Packages.buildPythonApplication rec {
  pname = "videocaptioner";
  version = "1.4.2";
  format = "pyproject";

  src = fetchurl {
    url = "https://files.pythonhosted.org/packages/67/68/5d84f0c13e7344de3e64399c0f737e433dc0452faa38cc22a242697c232e/videocaptioner-1.4.2.tar.gz";
    hash = "sha256-BIsDwF2r814oIfYrhmdBWqT5N+RTOJoVpWqTYjXPQpA=";
  };

  nativeBuildInputs = [
    python312Packages.hatchling
    python312Packages.hatch-vcs
    makeBinaryWrapper
  ];

  propagatedBuildInputs = with python312Packages; [
    requests
    openai
    diskcache
    yt-dlp
    json-repair
    langdetect
    pydub
    tenacity
    pillow
    fonttools
    platformdirs
    pyqt5
    pyqt-fluent-widgets
    modelscope
    psutil
    gputil
  ] ++ lib.optionals (pythonOlder "3.11") [
    tomli
  ];

  # videocaptioner pins PyQt5==5.15.11 and PyQt-Fluent-Widgets==1.8.4
  # but nixpkgs has 5.15.10 which is compatible.
  pythonRelaxDeps = true;

  # wrapQtAppsHook is designed for compiled binaries with Qt DT_NEEDED entries.
  # Python scripts get skipped, so we set QT_PLUGIN_PATH manually so the GUI
  # can find libqxcb.so (platform plugin) at runtime.
  postFixup = ''
    for exe in videocaptioner videocaptioner-gui; do
      wrapProgram "$out/bin/$exe" \
        --prefix QT_PLUGIN_PATH : ${libsForQt5.qtbase}/${libsForQt5.qtbase.qtPluginPrefix}
    done
  '';

  pythonImportsCheck = [];

  meta = with lib; {
    description = "AI-powered video captioning tool — ASR, subtitle optimization, translation, and synthesis";
    homepage = "https://github.com/WEIFENG2333/VideoCaptioner";
    license = licenses.gpl3Only;
    mainProgram = "videocaptioner";
  };
}
