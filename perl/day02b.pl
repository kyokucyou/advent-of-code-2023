#!/usr/bin/perl

use strict;

my $sum = 0;
while (<>) {
    my %fewest;
    while (/(\d+) (red|green|blue)/g) {
        $fewest{$2} = $1 if $fewest{$2} < $1;
    }
    my $product = 1;
    $product *= $fewest{$_} for keys %fewest;
    $sum += $product;
}
print "$sum\n";
