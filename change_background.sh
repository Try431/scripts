sed -i -e 's#~/Pictures/Backgrounds/.*#~/Pictures/Backgrounds/'$1'#' ~/.config/i3/config
feh --bg-scale ~/Pictures/Backgrounds/$1

# TODO 
# Add functionality which changes text/icon color from dark to light given optional second argument
