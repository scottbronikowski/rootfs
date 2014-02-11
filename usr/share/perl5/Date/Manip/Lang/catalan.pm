package Date::Manip::Lang::catalan;
# Copyright (c) 2003-2011 Sullivan Beck. All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

########################################################################
########################################################################

=pod

=head1 NAME

Date::Manip::Lang::catalan - Catalan language support.

=head1 SYNPOSIS

This module contains a list of words and expressions supporting
the language. It is not intended to be used directly (other
Date::Manip modules will load it as needed).

=cut

require 5.010000;
use YAML::Syck;

use strict;
use warnings;

our($VERSION);
$VERSION='6.25';

our($Language,@Encodings);
@Encodings = qw(utf-8 iso-8859-1 perl);

my @in    = <DATA>;
$Language = Load(join('',@in));

1;
__DATA__
---
ampm:
  -
    - AM
    - ''
    - A.M.
    - de la matinada
  -
    - PM
    - ''
    - P.M.
    - de la tarda
at:
  - a les
  - ''
  - a
  - al
day_abb:
  -
    - Dll
    - ''
    - dl.
    - dl
  -
    - Dmt
    - ''
    - Dim
    - dt.
    - dt
  -
    - Dmc
    - ''
    - Dic
    - dc.
    - dc
  -
    - Dij
    - ''
    - dj.
    - dj
  -
    - Div
    - ''
    - dv.
    - dv
  -
    - Dis
    - ''
    - ds.
    - ds
  -
    - Diu
    - ''
    - dg.
    - dg
day_char:
  -
    - Dl
    - ''
    - L
  -
    - Dm
    - ''
    - M
    - t
  -
    - Dc
    - ''
    - X
    - c
  -
    - Dj
    - ''
    - J
  -
    - Dv
    - ''
    - V
  -
    - Ds
    - ''
    - S
  -
    - Du
    - ''
    - U
    - g
day_name:
  -
    - Dilluns
  -
    - Dimarts
  -
    - Dimecres
  -
    - Dijous
  -
    - Divendres
  -
    - Dissabte
  -
    - Diumenge
each:
  - cadascuna
  - ''
  - cada
  - cadascun
fields:
  -
    - anys
    - ''
    - a
    - an
    - any
  -
    - mes
    - ''
    - m
    - me
    - ms
  -
    - setmanes
    - ''
    - s
    - se
    - set
    - setm
    - setmana
  -
    - dies
    - ''
    - d
    - dia
  -
    - hores
    - ''
    - h
    - ho
    - hora
  -
    - minuts
    - ''
    - mn
    - min
    - minut
  -
    - segons
    - ''
    - s
    - seg
    - segon
last:
  - darrer
  - ''
  - darrera
  - ultim
  - últim
  - ultima
  - última
  - passat
mode:
  -
    - exactament
    - ''
    - approximadament
  -
    - empresa
month_abb:
  -
    - Gen
    - ''
    - gen.
  -
    - Feb
    - ''
    - febr
    - feb.
    - febr.
  -
    - Mar
    - ''
    - mar.
  -
    - Abr
    - ''
    - abr.
  -
    - Mai
    - ''
    - mai.
  -
    - Jun
    - ''
    - jun.
  -
    - Jul
    - ''
    - jul.
  -
    - Ago
    - ''
    - ag
    - ago.
    - ag.
  -
    - Set
    - ''
    - set.
  -
    - Oct
    - ''
    - oct.
  -
    - Nov
    - ''
    - nov.
  -
    - Des
    - ''
    - Dec
    - des.
    - dec.
month_name:
  -
    - Gener
  -
    - Febrer
  -
    - Marc
    - març
  -
    - Abril
  -
    - Maig
  -
    - Juny
  -
    - Juliol
  -
    - Agost
  -
    - Setembre
  -
    - Octubre
  -
    - Novembre
  -
    - Desembre
nextprev:
  -
    - proper
    - ''
    - seguent
    - següent
  -
    - passat
    - ''
    - proppassat
    - anterior
nth:
  -
    - 1er
    - ''
    - primer
    - un
  -
    - 2n
    - ''
    - segon
    - dos
  -
    - 3r
    - ''
    - tercer
    - tres
  -
    - 4t
    - ''
    - quart
    - quatre
  -
    - 5e
    - 5è
    - cinque
    - Cinquè
    - cinc
  -
    - 6e
    - 6è
    - sise
    - sisè
    - sis
  -
    - 7e
    - 7è
    - sete
    - setè
    - set
  -
    - 8e
    - 8è
    - vuite
    - vuitè
    - vuit
  -
    - 9e
    - 9è
    - nove
    - novè
    - nou
  -
    - 10e
    - 10è
    - dese
    - desè
    - deu
  -
    - 11e
    - 11è
    - onze
    - onzè
  -
    - 12e
    - 12è
    - dotze
    - dotzè
  -
    - 13e
    - 13è
    - tretze
    - tretzè
  -
    - 14e
    - 14è
    - catorze
    - catorzè
  -
    - 15e
    - 15è
    - quinze
    - quinzè
  -
    - 16e
    - 16è
    - setze
    - setzè
  -
    - 17e
    - 17è
    - dissete
    - dissetè
    - disset
  -
    - 18e
    - 18è
    - divuite
    - divuitè
    - divuit
  -
    - 19e
    - 19è
    - dinove
    - dinovèe
    - dinou
  -
    - 20e
    - 20è
    - vinte
    - vintè
    - vint
  -
    - 21e
    - 21è
    - vint-i-une
    - vint-i-unè
    - vint-i-u
  -
    - 22e
    - 22è
    - vint-i-dose
    - vint-i-dosè
    - vint-i-dos
  -
    - 23e
    - 23è
    - vint-i-trese
    - vint-i-tresè
    - vint-i-tres
  -
    - 24e
    - 24è
    - vint-i-quatre
    - vint-i-quatrè
  -
    - 25e
    - 25è
    - vint-i-cinque
    - vint-i-cinquè
  -
    - 26e
    - 26è
    - vint-i-sise
    - vint-i-sisè
  -
    - 27e
    - 27è
    - vint-i-sete
    - vint-i-setè
  -
    - 28e
    - 28è
    - vint-i-vuite
    - vint-i-vuitè
  -
    - 29e
    - 29è
    - vint-i-nove
    - vint-i-novè
  -
    - 30e
    - 30è
    - trente
    - trentè
    - trenta
  -
    - 31e
    - 31è
    - trenta-une
    - trenta-unè
    - trenta-u
  -
    - 32e
    - 32è
    - trenta-dos
  -
    - 33e
    - 33è
    - trenta-tres
  -
    - 34e
    - 34è
    - trenta-quatre
  -
    - 35e
    - 35è
    - trenta-cinc
  -
    - 36e
    - 36è
    - trenta-sis
  -
    - 37e
    - 37è
    - trenta-set
    - trenta-setè
    - trenta-sete
  -
    - 38e
    - 38è
    - trenta-vuit
  -
    - 39e
    - 39è
    - trenta-nou
  -
    - 40e
    - 40è
    - quaranta
  -
    - 41e
    - 41è
    - quaranta-un
  -
    - 42e
    - 42è
    - quaranta-dos
  -
    - 43e
    - 43è
    - quaranta-tres
  -
    - 44e
    - 44è
    - quaranta-quatre
  -
    - 45e
    - 45è
    - quaranta-cinc
  -
    - 46e
    - 46è
    - quaranta-sis
  -
    - 47e
    - 47è
    - quaranta-set
  -
    - 48e
    - 48è
    - quaranta-vuit
    - quaranta-vuitena
  -
    - 49e
    - 49è
    - quaranta-nou
  -
    - 50e
    - 50è
    - cinquantè
    - cinquante
  -
    - 51e
    - 51è
    - cinquanta-un
  -
    - 52e
    - 52è
    - cinquanta-dos
  -
    - 53e
    - 53è
    - cinquanta-tres
of:
  - de
  - ''
  - d'
offset_date:
  abans d'ahir: -0:0:0:2:0:0:0
  ahir: -0:0:0:1:0:0:0
  demà: +0:0:0:1:0:0:0
  demà passat: +0:0:0:2:0:0:0
  dema: +0:0:0:1:0:0:0
  dema passat: +0:0:0:2:0:0:0
  idag: 0:0:0:0:0:0:0
offset_time:
  avui: 0:0:0:0:0:0:0
  ara: 0:0:0:0:0:0:0
'on':
  - el
times:
  migdia: 12:00:00
  mitjanit: 00:00:00
when:
  -
    - fa
  -
    - d'aqui a
    - d'aquí a
    - mes tard
    - més tard
