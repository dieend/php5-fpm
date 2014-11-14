name             'php5-fpm'
maintainer       'Brian Stajkowski'
maintainer_email 'stajkowski'
license          'Apache Open License'
description      'Installs/Configures php5-fpm'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.4.0'

supports 'ubuntu', ">= 10.04"
supports 'debian', ">= 6.0"
supports 'centOS', ">= 6.5"
supports 'Redhat'
supports 'Fedora', ">= 20.0"

depends 'ohai',            '~> 2.0'