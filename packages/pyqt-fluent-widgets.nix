{ lib, python312Packages, fetchurl, pyqt5-frameless-window }:

python312Packages.buildPythonPackage rec {
  pname = "pyqt-fluent-widgets";
  version = "1.8.4";
  format = "setuptools";

  src = fetchurl {
    url = "https://files.pythonhosted.org/packages/49/6f/45d5789a071db0d4d96c99745ca35f1069ae84136c9ce3cd49fed011e9ca/pyqt_fluent_widgets-1.8.4.tar.gz";
    hash = "sha256-CkLxJatEBxxjhgWxFa6cnWkT+7C/Zq3WUOaUNXY7lSc=";
  };

  propagatedBuildInputs = with python312Packages; [
    pyqt5
    pyqt5-frameless-window
    darkdetect
  ];

  # qfluentwidgets → qframelesswindow → PyQt5.QtX11Extras (unavailable in nixpkgs pyqt5)
  # Skip import check; CLI usage of videocaptioner does not trigger this path.
  pythonImportsCheck = [];

  meta = with lib; {
    description = "A fluent design widgets library for PyQt5";
    homepage = "https://github.com/zhiyiYo/PyQt-Fluent-Widgets";
    license = licenses.gpl3Only;
  };
}
