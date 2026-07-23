{ ... }:

{
  xdg.configFile."khal/config".text = ''
    [calendars]

    [[private]]
    path = /home/morstar/.local/share/khal/calendars/private
    type = calendar

    [locale]
    timeformat = %H:%M
    dateformat = %Y-%m-%d
    longdateformat = %Y-%m-%d
    datetimeformat = %Y-%m-%d %H:%M
    longdatetimeformat = %Y-%m-%d %H:%M

    [default]
    default_calendar = private
  '';
}
