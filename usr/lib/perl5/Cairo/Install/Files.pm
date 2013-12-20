package Cairo::Install::Files;

$self = {
          'inc' => '-I. -Ibuild -pthread -I/usr/include/cairo -I/usr/include/glib-2.0 -I/usr/lib/arm-linux-gnueabihf/glib-2.0/include -I/usr/include/pixman-1 -I/usr/include/freetype2 -I/usr/include/libpng12   -pthread -I/usr/include/cairo -I/usr/include/freetype2 -I/usr/include/glib-2.0 -I/usr/lib/arm-linux-gnueabihf/glib-2.0/include -I/usr/include/pixman-1 -I/usr/include/libpng12  ',
          'typemaps' => [
                          'cairo-perl-auto.typemap',
                          'cairo-perl.typemap'
                        ],
          'deps' => [],
          'libs' => '-lcairo   -lcairo -lfreetype  '
        };


# this is for backwards compatiblity
@deps = @{ $self->{deps} };
@typemaps = @{ $self->{typemaps} };
$libs = $self->{libs};
$inc = $self->{inc};

	$CORE = undef;
	foreach (@INC) {
		if ( -f $_ . "/Cairo/Install/Files.pm") {
			$CORE = $_ . "/Cairo/Install/";
			last;
		}
	}

1;
