{ lib, python312Packages, fetchurl }:

python312Packages.buildPythonPackage rec {
  pname = "pyqt5-frameless-window";
  version = "0.8.1";
  format = "setuptools";

  src = fetchurl {
    url = "https://files.pythonhosted.org/packages/a9/8d/e01888a2b02807c9e046c169d8543d608038a5c38c4b994703cbe142345a/pyqt5_frameless_window-0.8.1.tar.gz";
    hash = "sha256-QS7yC82ExhSv/a5GoRs2B1rzSR17gt9uG/6OinCMJKw=";
  };

  propagatedBuildInputs = with python312Packages; [
    pyqt5
  ] ++ lib.optionals stdenv.isLinux [
    xcffib
  ];

  # nixpkgs pyqt5 does not build QtX11Extras bindings (missing qtx11extras
  # Qt module during its build).  qframelesswindow/linux_utils.py imports
  # QX11Info unconditionally, which breaks ANY import of qframelesswindow.
  #
  # Patch it to a conditional import: when QX11Info is absent,
  # isPlatformX11() returns False and the code falls back to the
  # cross-platform window-manager path -- no loss for Wayland users,
  # and X11 move/resize degrades gracefully.
  postPatch = ''
    substituteInPlace qframelesswindow/utils/linux_utils.py \
      --replace-fail \
      'from PyQt5.QtX11Extras import QX11Info' \
      'try:
    from PyQt5.QtX11Extras import QX11Info
except ImportError:
    class QX11Info:
        @staticmethod
        def isPlatformX11(): return False'
  '';

  pythonImportsCheck = [ "qframelesswindow" ];

  meta = with lib; {
    description = "Frameless window for PyQt5, provides window customization on Windows and Linux";
    homepage = "https://github.com/zhiyiYo/PyQt-Frameless-Window";
    license = licenses.gpl3Only;
  };
}
