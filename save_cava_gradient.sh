SAVED_GRAD_1=`date +%Y-%m-%d_%H-%M-%S`-`grep "^gradient_color_1" ~/.config/cava/config | cut -d '"' -f2`
echo $SAVED_GRAD_1 >> ~/.config/cava/saved_gradients.txt
SAVED_GRAD_2=`date +%Y-%m-%d_%H-%M-%S`-`grep "^gradient_color_2" ~/.config/cava/config | cut -d '"' -f2`
echo $SAVED_GRAD_2 >> ~/.config/cava/saved_gradients.txt
