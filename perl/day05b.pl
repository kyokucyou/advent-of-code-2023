#!/usr/bin/perl

use strict;

my (@ranges, @maps, @queue);
$/ = '';
while (<>) {
    if (@ranges) {
        my (@map, $mapping);
        while (/(\d+)/g) {
            push @$mapping, int $1;
            if ($mapping->$#* == 2) {
                $mapping->[2] += $mapping->[1];
                push @map, $mapping;
                $mapping = [];
            }
        }
        push @maps, \@map;
    } else {
        my @raw = map int, /\d+/g;
        while (my ($start, $len) = splice @raw, 0, 2) {
            push @ranges, [$start, $start + $len];
        }
    }
}
for my $map (@maps) {
    @queue = @ranges;
    @ranges = ();
    QUEUE: while (@queue) {
        my ($src, $end) = pop(@queue)->@*;
        next if $src == $end;
        for my $mapping (@$map) {
            my ($dst, $msrc, $mend) = @$mapping;
            next if $end <= $msrc || $mend <= $src;
            my $osrc = $src > $msrc ? $src : $msrc;
            my $oend = $end < $mend ? $end : $mend;
            push @queue, [$src, $osrc], [$oend, $end];
            push @ranges, [$osrc - $msrc + $dst, $oend - $msrc + $dst];
            next QUEUE;
        }
        push @ranges, [$src, $end];
    }
}
my $min = pop(@ranges)->[0];
for my $range (@ranges) {
    my ($src, $end) = @$range;
    $min = $src if $src < $min;
}
print "$min\n";
