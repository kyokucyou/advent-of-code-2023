#!/usr/bin/perl

use strict;

my (@scores, @matching);
while (<>) {
    my @nums = map int, /\d+/g;
    my @wins = splice @nums, 1, 10;
    my @has = splice @nums, 1;
    my $score = 0.5;
    my $matched = 0;
    for my $win (@wins) {
        for my $num (@has) {
            next if $win != $num;
            $score *= 2;
            ++$matched;
            last;
        }
    }
    push @scores, int $score;
    push @matching, $matched;
}
my $cards = $#scores + 1;
my @avail = (1) x $cards;
while (1) {
    my $winning = 0;
    for my $i (0 .. $#avail) {
        next unless $avail[$i];
        for my $j ($i + 1 .. $i + $matching[$i]) {
            $avail[$j] += $avail[$i];
            $cards += $avail[$i];
        }
        $avail[$i] = 0;
    }
    last unless $winning;
}
print "$cards\n";
