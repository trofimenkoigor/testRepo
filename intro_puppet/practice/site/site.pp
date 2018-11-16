node 'command' {
	file { 'motd':
		path => '/etc/motd',
		ensure => present,
		content => 'Puppet MOTD'
	}
}