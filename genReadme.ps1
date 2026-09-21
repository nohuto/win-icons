# github.com/nohuto/win-icons

$folders = 'w7', 'w11'
$lines = @('# Windows icons', '')

foreach ($f in $folders) {
    $lines += "## $f", '', '| - | - | - | - | - |', '| :---: | :---: | :---: | :---: | :---: |'
    $icons = @(dir (Join-Path $PSScriptRoot $f) -Recurse -File -Filter *.ico | sort FullName)

    for ($i = 0; $i -lt $icons.Count; $i += 5) {
        $cells = for ($j = 0; $j -lt 5; $j++) {
            if ($i + $j -ge $icons.Count) { ''; continue }
            $icon = $icons[$i + $j]
            $path = $icon.FullName.Substring($PSScriptRoot.Length + 1).Replace('\', '/')
            $url = ($path.Split('/') | % { [Uri]::EscapeDataString($_) }) -join '/'
            $name = [Net.WebUtility]::HtmlEncode($icon.Name).Replace('|', '&#124;')
            "<a href=`"$url`"><img src=`"$url`" width=`"48`" alt=`"$name`"><br><sub>$name</sub></a>"
        }
        $lines += '| ' + ($cells -join ' | ') + ' |'
    }
    $lines += ''
}

$lines | Set-Content (Join-Path $PSScriptRoot 'README.md') -Encoding UTF8
