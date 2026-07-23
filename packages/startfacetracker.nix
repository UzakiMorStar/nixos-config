{ writeShellApplication, openseeface }:

writeShellApplication {
  name = "startfacetracker";
  runtimeInputs = [ openseeface ];
  text = builtins.readFile ../scripts/start_face_tracker.sh;
}
