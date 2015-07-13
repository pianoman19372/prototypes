# install required packages
package 'bash'
package 'bash-completion'
package 'command-not-found'

# install rcfile to all desired users
rcfile_helper('bash', 'bashrc')
