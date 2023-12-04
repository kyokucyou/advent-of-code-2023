#!/usr/bin/perl

use strict;

my @matching;
while (<>) {
    my @nums = map int, /\d+/g;
    my @wins = splice @nums, 1, 10;
    my @has = splice @nums, 1;
    my $matched = 0;
    for my $win (@wins) {
        for my $num (@has) {
            next if $win != $num;
            ++$matched;
            last;
        }
    }
    push @matching, $matched;
}
my $cards = $#matching + 1;
my @avail = (1) x $cards;
my $winning = 0;
for my $i (0 .. $#avail) {
    next unless $avail[$i];
    for my $j ($i + 1 .. $i + $matching[$i]) {
        $avail[$j] += $avail[$i];
    }
    $cards += $avail[$i] * $matching[$i];
}
print "$cards\n";
