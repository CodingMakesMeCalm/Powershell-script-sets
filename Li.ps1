##INFO-3099-02 
##Assignment #1
##Number guess
##Yao Li 
##Student number: 0846753
##2019.09.17

##Clear screen
clear-host

##Get random number between 1 to 10
[int32]$random = Get-Random -Maximum 10 -Minimum 1

##Define loop control number (retry times)
$retry = 3

##Define input times
$i = 1

##Winner sign
$win = 0

##Welcome message
Write-Host "Welcome to Number Guess. You have $retry times to guess the number which is between 1 and 10"
Write-Host ""

while ($retry -gt 0)
{
    #Write-Host $retry $i
    ##Begin with first time
    if ($i -eq 1) 
    {
        ##Get input number
        try 
        {
            [int]$inputnum = Read-Host -Prompt "Please type your first time trying number(between 1-10)"
        }
        catch
        {
            Write-Host "Error! Please type an integer number! Try again."
            Write-Host ""
            continue
        }
        ##Compare user input number with $random
        if ($inputnum -eq $random) ##Equal
        {
            Write-Host "Congratulation! You hit the answer at first try."
            $win = 1
            break
        }
        elseif ($inputnum -lt $random) ##Less than
        {
            Write-Host "Oops, you need to try typing a bigger one."
            Write-Host ""
            $retry = $retry - 1
            $i = $i + 1
            continue
        }
        else ##Greater than
        {
            Write-Host "Oops, you need to try typing a smaller one."
            Write-Host ""
            $retry = $retry - 1
            $i = $i + 1
            continue
        }
    }
    else
    {
        ##Get input number
        try 
        {
            [int]$inputnum = Read-Host -Prompt "Please type your $i times trying number(between 1-10)"
        }
        catch
        {
            Write-Host "Error! Please type an integer number! Try again."
            Write-Host ""
            continue
        }
        ##Compare user input number with $random
        if ($inputnum -eq $random) ##Equal
        {
            Write-Host "Congratulation! You hit the answer at $i times try."
            $win = 1
            break
        }
        elseif ($inputnum -lt $random) ##Less than
        {
            Write-Host "Oops, you need to try typing a bigger one."
            Write-Host ""
            $retry = $retry - 1
            $i = $i + 1
            continue
        }
        else ##Greater than
        {
            Write-Host "Oops, you need to try typing a smaller one."
            Write-Host ""
            $retry = $retry - 1
            $i = $i + 1
            continue
        }
    }
}

##End game
if ($win -eq 1)
{
    Write-Host ""
    Write-Host "You win. Game over"
}
else
{
    Write-Host ""
    Write-Host "You lose. Game over"
}