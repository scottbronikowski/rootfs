package Pango::Install::Files;

$self = {
          'inc' => '-pthread -I/usr/include/pango-1.0 -I/usr/include/glib-2.0 -I/usr/lib/arm-linux-gnueabihf/glib-2.0/include   -I./build -pthread -I/usr/include/pango-1.0 -I/usr/include/cairo -I/usr/include/glib-2.0 -I/usr/lib/arm-linux-gnueabihf/glib-2.0/include -I/usr/include/pixman-1 -I/usr/include/freetype2 -I/usr/include/libpng12  ',
          'typemaps' => [
                          'pango-perl.typemap',
                          'pango.typemap'
                        ],
          'deps' => [
                      'Glib',
                      'Cairo'
                    ],
          'libs' => '-pthread -lpango-1.0 -lgobject-2.0 -lgmodule-2.0 -lgthread-2.0 -lrt -lglib-2.0  -pthread -lpangocairo-1.0 -lpango-1.0 -lcairo -lgobject-2.0 -lgmodule-2.0 -lgthread-2.0 -lrt -lglib-2.0  '
        };


# this is for backwards compatiblity
@deps = @{ $self->{deps} };
@typemaps = @{ $self->{typemaps} };
$libs = $self->{libs};
$inc = $self->{inc};

	$CORE = undef;
	foreach (@INC) {
		if ( -f $_ . "/Pango/Install/Files.pm") {
			$CORE = $_ . "/Pango/Install/";
			last;
		}
	}

1;
