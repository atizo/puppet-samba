#
# samba module
#
# Copyright 2008, Puzzle ITC GmbH
# Copyright 2010, Atizo AG
# Marcel Härry haerry+puppet(at)puzzle.ch
# Simon Josi simon.josi+puppet(at)atizo.com
#
# This program is free software; you can redistribute 
# it and/or modify it under the terms of the GNU 
# General Public License version 3 as published by 
# the Free Software Foundation.
#

class samba {
  package{[ 'samba', 'samba-client' ]:
    ensure => present,
  }
  service{'samba':
    name => 'smb',
    ensure => running,
    enable => true,
    hasstatus => true,
    require => Package['samba'],
  }
  file{'/etc/samba/smb.conf':
    source => [
      "puppet://$server/modules/site-samba/$fqdn/smb.conf",
      "puppet://$server/modules/site-samba/$operatingsystem/smb.conf",
      "puppet://$server/modules/site-samba/smb.conf",
      "puppet://$server/modules/samba/$operatingsystem/smb.conf",
      "puppet://$server/modules/samba/smb.conf",
    ],
    require => Package['samba'],
    notify => Service['samba'],
    owner => root, group => 0, mode => 0644;
  }
}
