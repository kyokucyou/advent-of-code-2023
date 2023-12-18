#!/usr/bin/perl

use strict;

my @race;
while (<>) {
    s/[^\d]+//g;
    push @race, int;
}
my ($time, $q) = @race;
my $p = -$time;
my $left  = -($p / 2) + sqrt(($p / 2) ** 2 - $q);
my $right = -($p / 2) - sqrt(($p / 2) ** 2 - $q);
print int($left - $right) . "\n";
