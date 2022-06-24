# I used to have a program called lamp that controlled backlight, so naming this
# after it was easier than a 'proper' name.
function lamp
sudo fish -c "echo '$argv' > /sys/class/backlight/intel_backlight/brightness"
end
