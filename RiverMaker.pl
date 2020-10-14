#!/usr/bin/perl

# Randomly-generated river script.

# Here are some settings you may wish to change. :)
$screenwidth=80;
if ($ARGV[0]) {
	$screenwidth=$ARGV[0];
}
$landchar = ".";
$waterchar = "#";
$right_percent = .5; # Initial setting: Goes right on average about 50% of the time.
$up_percent = .25;
# If these 2 percentages add to something greater than 1, the percent chance of going up will just be 1-$right_percent.
# The percent chance of going down is 1-$up_percent-$right_percent, or 0 if that is negative.

$picturematrix = "";
$top_edge= "";
$bottom_edge= "";
$howhigh = 0; # Top is 0. Add 1 for each row down.
$howright= 0; # Left limit is 0. Add 1 for each square right.

for ($i = 0; $i < $screenwidth; $i++) { # Fill these 3 rows with blank land chars.
        $picturematrix .= $landchar;
	$top_edge .= $landchar;
	$bottom_edge .= $landchar; 
}

# They all want newlines on the end, too.
$picturematrix .= "\n";
$top_edge .= "\n";
$bottom_edge .= "\n";

for ($i = 0; $i < $screenwidth; $i++) {
	$howright = $i;
	$r = rand(1);
	if ($r < $right_percent) {	   # Default: 50% chance to go to the right.
                substr($picturematrix, $howright + ($screenwidth+1)*$howhigh, 1) = $waterchar;
	}
	$cumulative_percent = $right_percent+$up_percent;
	if ($r < $cumulative_percent && $r >= $right_percent) {  # Default: 25% chance to go up.
		if ($howhigh == 0) { # Append a new row on to the front of the string / top of the picture.
			$temp = $top_edge;
			$top_edge .= $picturematrix;
			$picturematrix = $top_edge;
			$top_edge = $temp; # Reset it back to a blank land-filled row.
		}
		else {
                        
			$howhigh--;
		}
                substr($picturematrix, $howright + ($screenwidth+1)*$howhigh, 1) = $waterchar;
	}
	if ($r >= $cumulative_percent) {	   # Default: 25% chance to go down.
                if (length($picturematrix) <= ($screenwidth+1)*($howhigh+1)) { # Test if we're on the last line.
		    $picturematrix .= $bottom_edge;
                }
		$howhigh++;
                substr($picturematrix, $howright + ($screenwidth+1)*$howhigh, 1) = $waterchar;
	}
}

print "\n";
print $picturematrix;
print "\n";

