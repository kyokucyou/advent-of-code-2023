#!/usr/bin/perl

use strict;

my %allowed = (
    red   => 12,
    green => 13,
    blue  => 14
);
my ($sum, $id) = (0, 1);
while (<>) {
    my $valid = 1;
    while (/(\d+) (red|green|blue)/g) {
        if ($allowed{$2} < $1) {
            $valid = 0;
            last;
        }
    }
    $sum += $id if $valid;
    ++$id;
}
print "$sum\n";
