# PowerShell-barcode-generator
Generate Code128 barcodes directly in the console.

![Code128 representation of "PowerShell-barcode-generator"](https://user-images.githubusercontent.com/44164506/206922469-059a6d25-2310-40d9-8a9b-aee946b7ade8.png)

## Why did I build this?

I needed a way to generate barcodes from MAC-addresses without leaving PowerShell. There were a few ways to accomplish this already but I was working with WinPE at the time, which limited my options significantly. So I came up with this solution.

## How does it work?

It does all the normal stuff that you'd expect from a barcode generator (figure out quiet zones, show the actual data, calculate a checksum etc.). I decided to display the data with black and white colored empty spaces. This might seem weird, but it was neccessary for my original use-case (I will explain this further down if you're interested).

## How can you use it?


You just import the function (or copy it into your script):
```PowerShell
 Import-Module [-Path <PATH TO SCRIPT>]
 ```

 And start using it:
 ```PowerShell
 Write-Barcode -String [STRING TO PRINT]
 ```

##
---

## Why on earth am I using colored spaces??

My original plan was, to use the unicode full block (this bad boy right here --> █ ) for all the one's (black lines) in the barcode. This did not work, because **all** my editors kept saving this block as "U+2588" instead of "ASCII 219"! When you use these Unicode characters in your code and do a ```Write-Host``` they come out all scrambled. All my beautiful "█" were turned into "â-^". This happens because PowerSell and command prompt use codepage 437 (you can check this by entering ```mode``` into your command prompt). This codepage only supports single byte ASCII-characters. So my pretty three byte character was turned into three seperate characters.

### Explenation why exactly the block turned into "â-^"

The block coresponds to these three hex values ([source](https://www.fileformat.info/info/unicode/char/2588/index.htm)):
```
0xE2 0x96 0x88
```

Now guess what those translate into ([source](https://www.freecodecamp.org/news/ascii-table-hex-to-ascii-value-character-code-chart-2/))...
```
0xE2	0x96	0x88
 â		 -		^
```