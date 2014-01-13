sudo puppet apply "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"/../puppet/manifests/default.pp --modulepath "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"/../puppet/modules
