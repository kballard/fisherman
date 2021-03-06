set -l id foo bar
set -l host baz
set -l tld org

function -S setup
    set -g fisher_default_host https://$host.$tld
end

test "validate names"
    $id[1] = (printf "%s\n" $id[1] | __fisher_validate)
end

test "validate uris"
    $fisher_default_host/$id[1]/$id[2] = (
        printf "%s\n" $id[1]/$id[2] | __fisher_validate)
end

test "validate names may end with a number"
    "a0" = (printf "%s\n" a0 | __fisher_validate)
end

test "validate names may start in uppercase"
    -z (printf "%s\n" A | __fisher_validate)
end

test "validate names may not start with a number"
    -z (printf "%s\n" 0abc | __fisher_validate)
end

test "remove `/' from uris"
    $fisher_default_host/$id[1]/$id[2] = (
        printf "%s\n" $id[1]/$id[2]/ | __fisher_validate)
end

test "remove `.git' from uris"
    $fisher_default_host/$id[1]/$id[2] = (
        printf "%s\n" $id[1]/$id[2].git | __fisher_validate)
end

test "file:/// uris"
    ! -z (printf "%s\n" file:///$id[1]/$id[2].git | __fisher_validate)
end

test "id/id uris"
    ! -z (printf "%s\n" $id[1]/$id[2].git | __fisher_validate)
end

test "short owner/repo uris"
    https://github.com/$id[1]/$id[2] = (
        printf "%s\n" github/$id[1]/$id[2] | __fisher_validate)
end

test "short $short:owner/repo uris"
    https://github.com/$id[1]/$id[2] = (
        printf "%s\n" gh:$id[1]/$id[2] | __fisher_validate)
end

test "short bitbucket urls uris"
    https://bitbucket.org/$id[1]/$id[2] = (
        printf "%s\n" bb:$id[1]/$id[2] | __fisher_validate)
end

test "short gitlab urls uris"
    https://gitlab.com/$id[1]/$id[2] = (
        printf "%s\n" gl:$id[1]/$id[2] | __fisher_validate)
end

test "omf: urls"
    https://github.com/oh-my-fish/theme-default = (
        printf "%s\n" omf:theme-default | __fisher_validate)
end

test "omf/ urls"
    https://github.com/oh-my-fish/theme-default = (
        printf "%s\n" omf/theme-default | __fisher_validate)
end

test "urls with a period"
    https://github.com/oh-my-fish/theme-cmorrell.com = (
        printf "%s\n" omf/theme-cmorrell.com | __fisher_validate)
end
