# Print-Barcode
Prints the Code128 Barcode of a given string to the console.

![graphic](https://user-images.githubusercontent.com/44164506/206913226-b6cc98e5-77f5-4818-bd66-afa83f4a35b1.png)

## Why did I build this?

I needed a way to generate barcodes from MAC-addresses without leaving the PowerShell. There were a few ways to accomplish this already but I was working with WinPE at the time, which limited my options significantly. So I came up with this solution.

## How does it work?

I tried building this with unicode full blocks ( These fellas right here "█") and spaces, but ran into some codepage issues along the way (the code page 437 converted this unicode character into it's equivalent ASCII characters, it looked like "â-^"). I was unable to resolve this, so now the script prints out a bunch of black and white spaces.

## How do I use it?

You just import the function (or copy it into your script):
```PowerShell
 Import-Module [-Path <PATH TO SCRIPT>]
 ```

 And start using it:
 ```
 Print-Barcode -String [STRING TO PRINT]
 ```