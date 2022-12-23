set modular_path $HOME/.config/fish/modular

set fish_function_path (find $modular_path -depth 2 -type d -name functions) $fish_function_path
set fish_complete_path (find $modular_path -depth 2 -type d -name completions) $fish_complete_path

for file in (find $modular_path -path "*/conf.d/*.fish" -depth 3 -type f)
    builtin source $file 2> /dev/null
end

