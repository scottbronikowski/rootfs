package Glib::Install::Files;

$self = {
          'inc' => ' -I. -pthread -I/usr/include/glib-2.0 -I/usr/lib/arm-linux-gnueabihf/glib-2.0/include   -pthread -I/usr/include/glib-2.0 -I/usr/lib/arm-linux-gnueabihf/glib-2.0/include  ',
          'typemaps' => [
                          'typemap'
                        ],
          'deps' => [],
          'libs' => '-pthread -lgobject-2.0 -lgthread-2.0 -lrt -lglib-2.0   -pthread -lgthread-2.0 -lrt -lglib-2.0  '
        };


# this is for backwards compatiblity
@deps = @{ $self->{deps} };
@typemaps = @{ $self->{typemaps} };
$libs = $self->{libs};
$inc = $self->{inc};

	$CORE = undef;
	foreach (@INC) {
		if ( -f $_ . "/Glib/Install/Files.pm") {
			$CORE = $_ . "/Glib/Install/";
			last;
		}
	}

1;
