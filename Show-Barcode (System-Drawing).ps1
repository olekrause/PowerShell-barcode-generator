function Show-Barcode {
	param (
		[string]$String
	)

	[reflection.assembly]::LoadWithPartialName( "System.Windows.Forms")
	[reflection.assembly]::LoadWithPartialName( "System.Drawing")
	#	Creates the pen
	$pen = new-object Drawing.Pen Black
	$pen.Width = 2

	#	Creates the form (the window)
	$form = New-Object Windows.Forms.Form
	$form.Text = "Show-Barcode ($String)"
	$form.Width = (($String.length * 11 + 60) + $pen.width) * 2
	$form.Height = 200
	$formGraphics = $form.createGraphics()
	
	$show_array = @()
	
	$start_code = "000000000011010010000"
	$stop_code = "11000111010110000000000"
	$barcode_array = @{
		"checksum" = @(
			"11011001100", "11001101100", "11001100110", "10010011000", "10010001100", "10001001100", "10011001000", "10011000100", "10001100100", "11001001000",
			"11001000100", "11000100100", "10110011100", "10011011100", "10011001110", "10111001100", "10011101100", "10011100110", "11001110010", "11001011100",
			"11001001110", "11011100100", "11001110100", "11101101110", "11101001100", "11100101100", "11100100110", "11101100100", "11100110100", "11100110010",
			"11011011000", "11011000110", "11000110110", "10100011000", "10001011000", "10001000110", "10110001000", "10001101000", "10001100010", "11010001000",
			"11000101000", "11000100010", "10110111000", "10110001110", "10001101110", "10111011000", "10111000110", "10001110110", "11101110110", "11010001110",
			"11000101110", "11011101000", "11011100010", "11011101110", "11101011000", "11101000110", "11100010110", "11101101000", "11101100010", "11100011010",
			"11101111010", "11001000010", "11110001010", "10100110000", "10100001100", "10010110000", "10010000110", "10000101100", "10000100110", "10110010000",
			"10110000100", "10011010000", "10011000010", "10000110100", "10000110010", "11000010010", "11001010000", "11110111010", "11000010100", "10001111010",
			"10100111100", "10010111100", "10010011110", "10111100100", "10011110100", "10011110010", "11110100100", "11110010100", "11110010010", "11011011110",
			"11011110110", "11110110110", "10101111000", "10100011110", "10001011110", "10111101000", "10111100010", "11110101000", "11110100010", "10111011110",
			"10111101110", "11101011110", "11110101110", "11010000100", "11010010000", "11010011100", "11000111010"
		)
		"data"     = @{
			"20" = @("11011001100", "0"); "21" = @("11001101100", "1"); "22" = @("11001100110", "2"); "23" = @("10010011000", "3"); "24" = @("10010001100", "4"); "25" = @("10001001100", "5"); "26" = @("10011001000", "6"); "27" = @("10011000100", "7"); "28" = @("10001100100", "8"); "29" = @("11001001000", "9"); "2A" = @("11001000100", "10"); "2B" = @("11000100100", "11"); "2C" = @("10110011100", "12"); "2D" = @("10011011100", "13"); "2E" = @("10011001110", "14"); "2F" = @("10111001100", "15");
			"30" = @("10011101100", "16"); "31" = @("10011100110", "17"); "32" = @("11001110010", "18"); "33" = @("11001011100", "19"); "34" = @("11001001110", "20"); "35" = @("11011100100", "21"); "36" = @("11001110100", "22"); "37" = @("11101101110", "23"); "38" = @("11101001100", "24"); "39" = @("11100101100", "25"); "3A" = @("11100100110", "26"); "3B" = @("11101100100", "27"); "3C" = @("11100110100", "28"); "3D" = @("11100110010", "29"); "3E" = @("11011011000", "30"); "3F" = @("11011000110", "31");
			"40" = @("11000110110", "32"); "41" = @("10100011000", "33"); "42" = @("10001011000", "34"); "43" = @("10001000110", "35"); "44" = @("10110001000", "36"); "45" = @("10001101000", "37"); "46" = @("10001100010", "38"); "47" = @("11010001000", "39"); "48" = @("11000101000", "40"); "49" = @("11000100010", "41"); "4A" = @("10110111000", "42"); "4B" = @("10110001110", "43"); "4C" = @("10001101110", "44"); "4D" = @("10111011000", "45"); "4E" = @("10111000110", "46"); "4F" = @("10001110110", "47");
			"50" = @("11101110110", "48"); "51" = @("11010001110", "49"); "52" = @("11000101110", "50"); "53" = @("11011101000", "51"); "54" = @("11011100010", "52"); "55" = @("11011101110", "53"); "56" = @("11101011000", "54"); "57" = @("11101000110", "55"); "58" = @("11100010110", "56"); "59" = @("11101101000", "57"); "5A" = @("11101100010", "58"); "5B" = @("11100011010", "59"); "5C" = @("11101111010", "60"); "5D" = @("11001000010", "61"); "5E" = @("11110001010", "62"); "5F" = @("10100110000", "63");
			"60" = @("10100001100", "64"); "61" = @("10010110000", "65"); "62" = @("10010000110", "66"); "63" = @("10000101100", "67"); "64" = @("10000100110", "68"); "65" = @("10110010000", "69"); "66" = @("10110000100", "70"); "67" = @("10011010000", "71"); "68" = @("10011000010", "72"); "69" = @("10000110100", "73"); "6A" = @("10000110010", "74"); "6B" = @("11000010010", "75"); "6C" = @("11001010000", "76"); "6D" = @("11110111010", "77"); "6E" = @("11000010100", "78"); "6F" = @("10001111010", "79");
			"70" = @("10100111100", "80"); "71" = @("10010111100", "81"); "72" = @("10010011110", "82"); "73" = @("10111100100", "83"); "74" = @("10011110100", "84"); "75" = @("10011110010", "85"); "76" = @("11110100100", "86"); "77" = @("11110010100", "87"); "78" = @("11110010010", "88"); "79" = @("11011011110", "89"); "7A" = @("11011110110", "90"); "7B" = @("11110110110", "91"); "7C" = @("10101111000", "92"); "7D" = @("10100011110", "93"); "7E" = @("10001011110", "94");
		}
	}
	
	
	$char_array = $String.ToCharArray()
	$sum = 0
	$counter = 1
	#Checksum
	foreach ($char in $char_array) {
		$char = [System.String]::Format("{0:X2}", [System.Convert]::ToUInt32($char))
		$sum = $sum + ($counter * $barcode_array.data."$char"[1])
		$counter++
	}
	$sum = $sum + 104
	$checksum = $sum % 103
	
	foreach ($char in $char_array) {
		$char = [System.String]::Format("{0:X2}", [System.Convert]::ToUInt32($char))
		$data_array += $barcode_array.data."$char"[0]
	}
	
	$show_array += $start_code
	$show_array += $data_array
	$show_array += $barcode_array.checksum[($checksum)]
	$show_array += $stop_code
	$show_array = $show_array.ToCharArray()

	$form.add_paint({
	
			foreach ($entry in $show_array) {
				if ($entry -eq "1") {
					$X_coord = $X_coord + $pen.Width
			
					$pen.Color = "Black"
					$formGraphics.DrawLine($pen, $X_coord, 0, $X_coord, 190)
				}
				elseif ($entry -eq "0") {
					$X_coord = $X_coord + $pen.Width
			
					$pen.Color = "White"
					$formGraphics.DrawLine($pen, $X_coord, 0, $X_coord, 190)
				}	
			}
		})
	
	$form.ShowDialog()
}