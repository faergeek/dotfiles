function add_to_path
    for path in $argv
        not contains $path $PATH && set -gxp PATH $path
    end
end
