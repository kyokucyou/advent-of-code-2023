#!/usr/bin/perl

use strict;

my $sum = 0;
while (<>) {
    my @nums = /\d+/g;
    my @wins = splice @nums, 1, 10;
    my @has = splice @nums, 1;
    my $score = 0.5;
    for my $num (@wins) {
        $num == $_ and $score *= 2 for @has;
    }
    $sum += int $score;
}
print "$sum\n";
