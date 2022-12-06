use strict;
use warnings;
use v5.10;
use List::Util qw(sum);

my $score = 0;
my @scoreboard = ();
while(<STDIN>){
    chomp;
    my @input = split(' ', $_);
    my $result = computeScore(@input);

    push @scoreboard, $result;
}

say sum @scoreboard;




sub computeScore {
    my ($a, $b, @others) = @_;
    my $score = 0;

    if ($b eq 'Y') {
        $score += 3;
        if ($a eq 'A') {$score += 1;}
        elsif ($a eq 'B') {$score += 2;}
        elsif ($a eq 'C') {$score += 3;}
    } elsif ($b eq 'X'){
        if ($a eq 'A') {$score += 3;}
        elsif ($a eq 'B') {$score += 1;}
        elsif ($a eq 'C') {$score += 2;}
    } elsif ($b eq 'Z'){
        $score += 6;
        if ($a eq 'A') {$score += 2;}
        elsif ($a eq 'B') {$score += 3;}
        elsif ($a eq 'C') {$score += 1;}
    }
    return $score;
}