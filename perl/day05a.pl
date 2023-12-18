#!/usr/bin/perl

use strict;

my (@seeds, @maps, @map);
while (<>) {
    if (/\d/) {
        my @nums = map int, /\d+/g;
        if (@seeds) {
            push @map, \@nums;
        } else {
            @seeds = @nums;
        }
    } else {
        if (@map) {
            push @maps, [@map];
            @map = ();
        }
    }
}
push @maps, \@map;
for my $seed (@seeds) {
    for my $map (@maps) {
        for my $range (@$map) {
            my ($dst, $src, $len) = @$range;
            if ($src <= $seed <= $src + $len) {
                $seed = $dst + $seed - $src;
                last;
            }
        }
    }
}
@seeds = sort { $a <=> $b } @seeds;
print "$seeds[0]\n";
