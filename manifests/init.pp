#
# samba module
#
# Copyright 2008, Puzzle ITC
# Marcel Härry haerry+puppet(at)puzzle.ch
# Simon Josi josi+puppet(at)puzzle.ch
#
# This program is free software; you can redistribute 
# it and/or modify it under the terms of the GNU 
# General Public License version 3 as published by 
# the Free Software Foundation.
#

class samba {
    package{ [ 'samba', 'samba-client' ]:
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
        source => [ "puppet://$server/sitze-samba/$fqdn/smb.conf",
                    "puppet://$server/site-samba/$operatingsystem/smb.conf",
                    "puppet://$server/site-samba/smb.conf",
                    "puppet://$server/samba/$operatingsystem/smb.conf",
                    "puppet://$server/samba/smb.conf" ],
        require => Package['samba'],
        owner => root, group => 0, mode => 0644;
    }
}
