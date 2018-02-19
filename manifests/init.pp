# chrome
#
# Installs Chrome Browser for Windows
#
# @author
#
# Luis Mayorga <lmayorga@lm3corp.com>
# @version google chrome version
# @packagename defaults to chocolatey package name https://chocolatey.org
class chrome(
            String $version     = undef,
            String $packagename = 'googlechrome',
            String $ensure      = 'present'
            ) {

  $ensure_state = {
    'present'     => {
      'directory' => 'directory',
      'package'   => $version,
    },
    'absent'      => {
      'directory' => 'absent',
      'package'   => 'absent',
    },
  }

  case $::operatingsystemrelease {

    '7','2008','2008 R2','2012','2012 R2','2016': {

    package { "${packagename}-${version}":
      ensure   => $ensure_state[$ensure]['package'],
      name     => $packagename,
      provider => 'chocolatey',
      }

    service { 'gupdate':
      ensure  => stopped,
      enable  => false,
      require => Package["${packagename}-${version}"]
    }

    service { 'gupdatem':
      ensure  => stopped,
      enable  => false,
      require => Package["${packagename}-${version}"]
    }

    registry_key { 'gupdate-regkey':
      ensure  => present,
      path    => 'HKLM\SOFTWARE\Policies\Google\Update',
      require => Service['gupdate']
    }

    file { 'C:\Program Files (x86)\Google\Update':
      ensure  => absent,
      force   => true,
      require => Service['gupdate'],
    }

    ##TODO: The following registry keys apply for Chrome 64 bit
    registry_value { 'HKLM\SOFTWARE\Policies\Google\Update\UpdateDefault':
      ensure  => present,
      type    => dword,
      data    => '0',
      require => Registry_key['gupdate-regkey']
    }

    registry_value { 'HKLM\SOFTWARE\Policies\Google\Update\AutoUpdateCheckPeriodMinutes':
      ensure  => present,
      type    => dword,
      data    => '0',
      require => Registry_key['gupdate-regkey']
    }

    registry_value { 'HKLM\SOFTWARE\Policies\Google\Update\DisableAutoUpdateChecksCheckboxValue':
      ensure  => present,
      type    => dword,
      data    => '1',
      require => Registry_key['gupdate-regkey']
    }

    registry_value { 'HKLM\SOFTWARE\Policies\Google\Update\Update{8A69D345-D564-463C-AFF1-A69D9E530F96}':
      ensure  => present,
      type    => dword,
      data    => '0',
      require => Registry_key['gupdate-regkey']
    }

    }

    '2012 R2 CORE': {
      notify { 'This operating system is not supported by this module' : }
    }

    default: {
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
    }
  }
}
