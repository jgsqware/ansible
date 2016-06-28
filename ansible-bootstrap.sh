siteBootstrap() {
    echo "Create site.yml"
    touch site.yml
    echo "---\n# main plays\n- include: all_roles.yml" > site.yml

    echo "Create all_roles.yml"
    touch all_roles.yml
    echo "---\n- hosts: default\n  any_errors_fatal: true\n\troles:\n    - dummy" > all_roles.yml
}

roleBootstrap() {
    echo "Create roles folder"
    mkdir roles

    echo "Create dummy role"
    mkdir roles/dummy
    mkdir roles/dummy/tasks
    mkdir roles/dummy/vars

    echo "Create dummy vars main.yml"
    touch roles/dummy/vars/main.yml
    echo "key: value" > roles/dummy/vars/main.yml

    echo "Create dummy tasks main.yml"
    touch roles/dummy/tasks/main.yml
    echo "---\n\n  - include: prerequisite.yml" > roles/dummy/tasks/main.yml

    echo "Create dummy tasks prerequisite.yml"
    touch roles/dummy/tasks/prerequisite.yml
    echo "---\n\n  - name: Prerequisite Task" > roles/dummy/tasks/prerequisite.yml
}

environmentBootstrap() {
    echo "Create $1 environment"
    mkdir -p environments/$1/group_vars/all

    echo "Create $1 group vars"
    touch environments/$1/group_vars/all/vars.yml
    echo "key: value" > environments/$1/group_vars/all/vars.yml

    echo "Create $1 inventory"
    touch environments/$1/inventory
    echo "[default]\ndefault  ansible_host=127.0.0.1 ansible_user=root" > environments/$1/inventory

}

environmentsBootstrap(){
    echo "Create environments folder"
    mkdir environments

    environmentBootstrap dev
    environmentBootstrap qa
    environmentBootstrap prod
}

echo "##################################"
echo "#  Ansible project bootstrapper  #" 
echo "##################################"
echo 

siteBootstrap
roleBootstrap
environmentsBootstrap