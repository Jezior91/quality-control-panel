#Requires -Version 5.0
# ╔══════════════════════════════════════════════════════════════════╗
# ║       TASKLET AGENT CONTROL PANEL v1.0 — Windows Edition        ║
# ║       © 2026 tom (imperiumultrapro2@wp.pl)                       ║
# ║       ID: PANEL-WIN-v1.0 | Data: 2026-06-07                     ║
# ║       TAJEMNICA HANDLOWA — Wszelkie prawa zastrzeżone            ║
# ╚══════════════════════════════════════════════════════════════════╝

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[System.Windows.Forms.Application]::EnableVisualStyles()
[System.Windows.Forms.Application]::SetCompatibleTextRenderingDefault($false)

# ══════════════════════════════════════════════
#  KOLORY
# ══════════════════════════════════════════════
$C_BG      = [Drawing.Color]::FromArgb(13,  13,  20 )
$C_CARD    = [Drawing.Color]::FromArgb(22,  22,  35 )
$C_CARD2   = [Drawing.Color]::FromArgb(30,  30,  50 )
$C_ACCENT  = [Drawing.Color]::FromArgb(99,  102, 241)
$C_GREEN   = [Drawing.Color]::FromArgb(34,  197, 94 )
$C_RED     = [Drawing.Color]::FromArgb(239, 68,  68 )
$C_YELLOW  = [Drawing.Color]::FromArgb(234, 179, 8  )
$C_TEXT    = [Drawing.Color]::White
$C_SUB     = [Drawing.Color]::FromArgb(148, 163, 184)
$C_BORDER  = [Drawing.Color]::FromArgb(45,  45,  65 )

# ══════════════════════════════════════════════
#  CZCIONKI
# ══════════════════════════════════════════════
$F_TITLE  = New-Object Drawing.Font("Segoe UI", 18, [Drawing.FontStyle]::Bold)
$F_HEAD   = New-Object Drawing.Font("Segoe UI", 10, [Drawing.FontStyle]::Bold)
$F_NORM   = New-Object Drawing.Font("Segoe UI",  9)
$F_SMALL  = New-Object Drawing.Font("Segoe UI",  8)
$F_MONO   = New-Object Drawing.Font("Consolas",  8)

# ══════════════════════════════════════════════
#  DANE AGENTÓW
# ══════════════════════════════════════════════
$global:Agents = @(
    [pscustomobject]@{Idx=1;  Label="Kontrola Jakosci"; Cat="Jakosc";      ID="QA-AGENT-v1.0";          Active=$true; Color=[Drawing.Color]::FromArgb(99,102,241); Desc="Weryfikacja outputu wszystkich agentow. Wykrywa bledy logiczne, faktyczne i jezykowe."},
    [pscustomobject]@{Idx=2;  Label="Kombinator";       Cat="Analiza";     ID="KOMBINATOR-AGENT-v1.0";  Active=$true; Color=[Drawing.Color]::FromArgb(168,85,247);  Desc="Kreatywne rozwiazywanie problemow. Nieoczywiste podejscia i innowacje."},
    [pscustomobject]@{Idx=3;  Label="Mechanik";         Cat="Przemysl";    ID="MECHANIK-AGENT-v1.0";    Active=$true; Color=[Drawing.Color]::FromArgb(249,115,22);  Desc="Diagnostyka usterek maszyn i pojazdow. Planowanie napraw i serwisu."},
    [pscustomobject]@{Idx=4;  Label="Slusarz";          Cat="Przemysl";    ID="SLUSARZ-AGENT-v1.0";     Active=$true; Color=[Drawing.Color]::FromArgb(234,179,8);   Desc="Obrobka metalu, plany technologiczne, tolerancje i technologie."},
    [pscustomobject]@{Idx=5;  Label="Spawacz";          Cat="Przemysl";    ID="SPAWACZ-AGENT-v1.0";     Active=$true; Color=[Drawing.Color]::FromArgb(239,68,68);   Desc="Spawanie, dobor metod i parametrow, instrukcje WPS."},
    [pscustomobject]@{Idx=6;  Label="Koder";            Cat="IT";          ID="KODER-AGENT-v1.0";       Active=$true; Color=[Drawing.Color]::FromArgb(20,184,166);  Desc="Programowanie w kazdym jezyku. Debugging, architektura, code review."},
    [pscustomobject]@{Idx=7;  Label="BHP";              Cat="Bezpiecz.";   ID="BHP-AGENT-v1.0";         Active=$true; Color=[Drawing.Color]::FromArgb(34,197,94);   Desc="Ocena ryzyka zawodowego, instrukcje bezpieczenstwa, dokumentacja."},
    [pscustomobject]@{Idx=8;  Label="Tester";           Cat="IT";          ID="TESTER-AGENT-v1.0";      Active=$true; Color=[Drawing.Color]::FromArgb(59,130,246);  Desc="Testy jednostkowe, integracyjne, E2E, wydajnosciowe. Raporty bledow."},
    [pscustomobject]@{Idx=9;  Label="Pentester";        Cat="Cybersec";    ID="PENTESTER-AGENT-v1.0";   Active=$true; Color=[Drawing.Color]::FromArgb(239,68,68);   Desc="Testy penetracyjne, analiza podatnosci, raporty bezpieczenstwa."},
    [pscustomobject]@{Idx=10; Label="Hacker";           Cat="Cybersec";    ID="HACKER-AGENT-v1.0";      Active=$true; Color=[Drawing.Color]::FromArgb(180,30,30);   Desc="Ekspert ofensywny. Exploity, reverse engineering, malware analysis."},
    [pscustomobject]@{Idx=11; Label="Antywirus";        Cat="Cybersec";    ID="ANTYWIRUS-AGENT-v1.0";   Active=$true; Color=[Drawing.Color]::FromArgb(16,185,129);  Desc="Analiza malware, sygnatury YARA/Sigma, incident response, forensics."},
    [pscustomobject]@{Idx=12; Label="Informatyk";       Cat="IT";          ID="INFORMATYK-AGENT-v1.0";  Active=$true; Color=[Drawing.Color]::FromArgb(99,102,241);  Desc="Administracja systemami, sieci, chmura, DevOps, bazy danych."},
    [pscustomobject]@{Idx=13; Label="Strazak";          Cat="Ratownictwo"; ID="STRAZAK-AGENT-v1.0";     Active=$true; Color=[Drawing.Color]::FromArgb(239,68,68);   Desc="Ochrona przeciwpozarowa, HAZMAT, ewakuacje, planowanie ppoz."},
    [pscustomobject]@{Idx=14; Label="Medyk";            Cat="Ratownictwo"; ID="MEDYK-AGENT-v1.0";       Active=$true; Color=[Drawing.Color]::FromArgb(236,72,153);  Desc="Diagnostyka, farmakologia, medycyna ratunkowa, wszystkie specjalizacje."},
    [pscustomobject]@{Idx=15; Label="Ratownik";         Cat="Ratownictwo"; ID="RATOWNIK-AGENT-v1.0";    Active=$true; Color=[Drawing.Color]::FromArgb(245,158,11);  Desc="KPP/PRM, ratownictwo specjalistyczne, triage, zarzadzanie kryzysowe."}
)

$global:TaskletURL  = "https://tasklet.ai"
$global:LogList     = [System.Collections.Generic.List[string]]::new()
$global:ToggleBtns  = @{}
$global:DotCtrls    = @{}

function Write-Log {
    param([string]$msg)
    $line = "[$(Get-Date -Format 'HH:mm:ss')] $msg"
    $global:LogList.Add($line)
    if ($global:LogBox -and -not $global:LogBox.IsDisposed) {
        $global:LogBox.AppendText("$line`r`n")
        $global:LogBox.ScrollToCaret()
    }
}

function New-Lbl {
    param($t,$x,$y,$w,$h,$f,$c)
    $l = New-Object Windows.Forms.Label
    $l.Text=$t; $l.Location=[Drawing.Point]::new($x,$y); $l.Size=[Drawing.Size]::new($w,$h)
    $l.Font=$f; $l.ForeColor=$c; $l.BackColor=[Drawing.Color]::Transparent
    return $l
}

function New-Btn {
    param($t,$x,$y,$w,$h,$bg,$fg)
    $b = New-Object Windows.Forms.Button
    $b.Text=$t; $b.Location=[Drawing.Point]::new($x,$y); $b.Size=[Drawing.Size]::new($w,$h)
    $b.FlatStyle="Flat"; $b.FlatAppearance.BorderSize=0
    $b.BackColor=$bg; $b.ForeColor=$fg; $b.Font=$F_HEAD; $b.Cursor="Hand"
    return $b
}

# ══════════════════════════════════════════════
#  GŁÓWNY FORMULARZ
# ══════════════════════════════════════════════
$form = New-Object Windows.Forms.Form
$form.Text          = "Tasklet Agent Control Panel v1.0  —  © 2026 tom"
$form.Size          = [Drawing.Size]::new(1120,760)
$form.MinimumSize   = [Drawing.Size]::new(900,650)
$form.StartPosition = "CenterScreen"
$form.BackColor     = $C_BG
$form.ForeColor     = $C_TEXT

# ── Header ──────────────────────────────────
$header = New-Object Windows.Forms.Panel
$header.Dock = "Top"; $header.Height = 68; $header.BackColor = $C_CARD
$header.Controls.Add((New-Lbl "TASKLET AGENT CONTROL PANEL" 20 8  700 38 $F_TITLE $C_TEXT))
$header.Controls.Add((New-Lbl "© 2026 tom  |  imperiumultrapro2@wp.pl  |  PANEL-WIN-v1.0  |  Tajemnica Handlowa" 22 48 800 16 $F_SMALL $C_SUB))
$form.Controls.Add($header)

# ── Status bar ──────────────────────────────
$sbar = New-Object Windows.Forms.Panel
$sbar.Dock = "Bottom"; $sbar.Height = 26; $sbar.BackColor = $C_CARD
$global:SbarLbl = New-Lbl "  Tasklet Agent Panel v1.0  |  15/15 agentow aktywnych  |  © 2026 tom" 0 4 900 18 $F_SMALL $C_SUB
$sbar.Controls.Add($global:SbarLbl)
$form.Controls.Add($sbar)

# ── Tabs ────────────────────────────────────
$tabs = New-Object Windows.Forms.TabControl
$tabs.Dock = "Fill"; $tabs.Font = $F_HEAD
$tabs.DrawMode = "OwnerDrawFixed"; $tabs.ItemSize = [Drawing.Size]::new(145,36)
$tabs.SizeMode = "Fixed"; $tabs.Padding = [Drawing.Point]::new(12,6)

$tabs.Add_DrawItem({
    param($s,$e)
    $tab  = $s.TabPages[$e.Index]
    $rect = $e.Bounds
    $sel  = ($e.Index -eq $s.SelectedIndex)
    $bg   = if($sel){$C_ACCENT}else{$C_CARD}
    $fg   = if($sel){[Drawing.Color]::White}else{$C_SUB}
    $e.Graphics.FillRectangle((New-Object Drawing.SolidBrush $bg), $rect)
    $sf   = New-Object Drawing.StringFormat
    $sf.Alignment = "Center"; $sf.LineAlignment = "Center"
    $e.Graphics.DrawString($tab.Text, $F_HEAD, (New-Object Drawing.SolidBrush $fg), [Drawing.RectangleF]$rect, $sf)
})
$form.Controls.Add($tabs)
$form.Controls.SetChildIndex($tabs,   0)
$form.Controls.SetChildIndex($header, 0)
$form.Controls.SetChildIndex($sbar,   0)
$header.BringToFront()

# ══════════════════════════════════════════════
#  TAB 1 — DASHBOARD
# ══════════════════════════════════════════════
$tDash = New-Object Windows.Forms.TabPage "DASHBOARD"
$tDash.BackColor = $C_BG; $tabs.TabPages.Add($tDash)

# Statystyki bar
$statBar = New-Object Windows.Forms.Panel
$statBar.Location = [Drawing.Point]::new(10,10); $statBar.Size = [Drawing.Size]::new(1070,65)
$statBar.BackColor = $C_CARD
$tDash.Controls.Add($statBar)

$statItems = @(
    @{V="15"; L="AGENTOW LACZNIE"; X=20;  VC=$C_ACCENT},
    @{V="15"; L="AKTYWNYCH";       X=200; VC=$C_GREEN},
    @{V="0";  L="NIEAKTYWNYCH";    X=380; VC=$C_RED},
    @{V="6";  L="KATEGORII";       X=560; VC=$C_YELLOW},
    @{V="1.0";L="WERSJA PANELU";   X=740; VC=$C_TEXT}
)
foreach($s in $statItems){
    $statBar.Controls.Add((New-Lbl $s.V  $s.X  5  160 32 $F_TITLE $s.VC))
    $statBar.Controls.Add((New-Lbl $s.L  $s.X  40 160 18 $F_SMALL $C_SUB))
}

# Scroll z kartami
$dashScroll = New-Object Windows.Forms.Panel
$dashScroll.Location = [Drawing.Point]::new(10,85); $dashScroll.Size = [Drawing.Size]::new(1070,545)
$dashScroll.AutoScroll = $true; $dashScroll.BackColor = $C_BG
$tDash.Controls.Add($dashScroll)

$CW=346; $CH=105; $GAP=8; $col=0; $row=0

foreach($a in $global:Agents){
    $cx = $col*($CW+$GAP); $cy = $row*($CH+$GAP)
    $card = New-Object Windows.Forms.Panel
    $card.Location=[Drawing.Point]::new($cx,$cy); $card.Size=[Drawing.Size]::new($CW,$CH)
    $card.BackColor=$C_CARD; $card.Tag=$a

    $bar2=New-Object Windows.Forms.Panel; $bar2.Location="0,0"; $bar2.Size="5,$CH"; $bar2.BackColor=$a.Color
    $card.Controls.Add($bar2)

    $dot=New-Object Windows.Forms.Panel; $dot.Location=[Drawing.Point]::new(300,10); $dot.Size=[Drawing.Size]::new(12,12)
    $dot.BackColor=$C_GREEN; $card.Controls.Add($dot)
    $global:DotCtrls[$a.ID] = $dot

    $card.Controls.Add((New-Lbl "#$($a.Idx)"   15 8   30  15 $F_SMALL $C_SUB))
    $card.Controls.Add((New-Lbl $a.Label       15 24  280 22 $F_HEAD  $C_TEXT))
    $card.Controls.Add((New-Lbl "[$($a.Cat)]"  15 48  150 16 $F_SMALL $a.Color))
    $card.Controls.Add((New-Lbl $a.Desc        15 66  315 28 $F_SMALL $C_SUB))
    $card.Controls.Add((New-Lbl $a.ID         210 88  130 14 $F_MONO  $C_BORDER))

    $card.Add_MouseEnter({$this.BackColor=$C_CARD2})
    $card.Add_MouseLeave({$this.BackColor=$C_CARD})

    $dashScroll.Controls.Add($card)
    $col++; if($col -ge 3){$col=0;$row++}
}

# ══════════════════════════════════════════════
#  TAB 2 — LAUNCHER
# ══════════════════════════════════════════════
$tLaunch = New-Object Windows.Forms.TabPage "LAUNCHER"
$tLaunch.BackColor = $C_BG; $tabs.TabPages.Add($tLaunch)

$tLaunch.Controls.Add((New-Lbl "LAUNCHER AGENTOW" 20 12 600 32 $F_TITLE $C_TEXT))
$tLaunch.Controls.Add((New-Lbl "Kliknij agenta aby otworzyc Tasklet w przegladarce" 22 48 600 18 $F_SMALL $C_SUB))

# URL row
$urlPnl = New-Object Windows.Forms.Panel
$urlPnl.Location=[Drawing.Point]::new(20,72); $urlPnl.Size=[Drawing.Size]::new(860,36); $urlPnl.BackColor=$C_CARD
$urlPnl.Controls.Add((New-Lbl "URL:" 10 8 45 20 $F_NORM $C_SUB))
$global:TxtUrl = New-Object Windows.Forms.TextBox
$global:TxtUrl.Location=[Drawing.Point]::new(58,7); $global:TxtUrl.Size=[Drawing.Size]::new(790,22)
$global:TxtUrl.BackColor=[Drawing.Color]::FromArgb(28,28,45); $global:TxtUrl.ForeColor=$C_TEXT
$global:TxtUrl.BorderStyle="None"; $global:TxtUrl.Font=$F_MONO; $global:TxtUrl.Text=$global:TaskletURL
$global:TxtUrl.Add_TextChanged({$global:TaskletURL=$global:TxtUrl.Text})
$urlPnl.Controls.Add($global:TxtUrl); $tLaunch.Controls.Add($urlPnl)

$lScroll = New-Object Windows.Forms.Panel
$lScroll.Location=[Drawing.Point]::new(20,118); $lScroll.Size=[Drawing.Size]::new(1060,512)
$lScroll.AutoScroll=$true; $lScroll.BackColor=$C_BG
$tLaunch.Controls.Add($lScroll)

$li=0
foreach($a in $global:Agents){
    $lrow=[int][Math]::Floor($li/2); $lcol=$li%2
    $lx=$lcol*530; $ly=$lrow*58

    $lp=New-Object Windows.Forms.Panel; $lp.Location=[Drawing.Point]::new($lx,$ly); $lp.Size=[Drawing.Size]::new(520,52); $lp.BackColor=$C_CARD; $lp.Tag=$a
    $lb2=New-Object Windows.Forms.Panel; $lb2.Location="0,0"; $lb2.Size="5,52"; $lb2.BackColor=$a.Color; $lp.Controls.Add($lb2)
    $lp.Controls.Add((New-Lbl $a.Label 15  6 300 22 $F_HEAD $C_TEXT))
    $lp.Controls.Add((New-Lbl $a.ID   15 28 250 16 $F_MONO $C_SUB))

    $btnL=New-Btn "URUCHOM" 405 9 100 34 $a.Color [Drawing.Color]::White
    $btnL.Tag=$a
    $btnL.Add_Click({
        $ag=$this.Tag
        Start-Process $global:TaskletURL
        Write-Log "Uruchomiono: $($ag.Label) [$($ag.ID)]"
    })
    $lp.Controls.Add($btnL)
    $lp.Add_MouseEnter({$this.BackColor=$C_CARD2})
    $lp.Add_MouseLeave({$this.BackColor=$C_CARD})
    $lScroll.Controls.Add($lp)
    $li++
}

# ══════════════════════════════════════════════
#  TAB 3 — PANEL KONTROLNY
# ══════════════════════════════════════════════
$tCtrl = New-Object Windows.Forms.TabPage "PANEL KONTROLNY"
$tCtrl.BackColor = $C_BG; $tabs.TabPages.Add($tCtrl)

$tCtrl.Controls.Add((New-Lbl "PANEL KONTROLNY" 20 12 600 32 $F_TITLE $C_TEXT))

$btnAllOn  = New-Btn "AKTYWUJ WSZYSTKICH"     20  55 210 32 $C_GREEN [Drawing.Color]::White
$btnAllOff = New-Btn "DEZAKTYWUJ WSZYSTKICH" 240  55 220 32 $C_RED   [Drawing.Color]::White
$tCtrl.Controls.AddRange(@($btnAllOn,$btnAllOff))

$ctrlScroll = New-Object Windows.Forms.Panel
$ctrlScroll.Location=[Drawing.Point]::new(20,100); $ctrlScroll.Size=[Drawing.Size]::new(1060,525)
$ctrlScroll.AutoScroll=$true; $ctrlScroll.BackColor=$C_BG
$tCtrl.Controls.Add($ctrlScroll)

$ci=0
foreach($a in $global:Agents){
    $cy2=$ci*46
    $cp=New-Object Windows.Forms.Panel; $cp.Location=[Drawing.Point]::new(0,$cy2); $cp.Size=[Drawing.Size]::new(1040,42); $cp.BackColor=$C_CARD
    $cb=New-Object Windows.Forms.Panel; $cb.Location="0,0"; $cb.Size="5,42"; $cb.BackColor=$a.Color; $cp.Controls.Add($cb)
    $cp.Controls.Add((New-Lbl "#$($a.Idx)"    12  13  30  16 $F_SMALL $C_SUB))
    $cp.Controls.Add((New-Lbl $a.Label        46  10 200  22 $F_HEAD  $C_TEXT))
    $cp.Controls.Add((New-Lbl "[$($a.Cat)]"  256  13 100  16 $F_SMALL $a.Color))
    $cp.Controls.Add((New-Lbl $a.ID          370  13 200  16 $F_MONO  $C_SUB))

    $tbtn=New-Btn "AKTYWNY" 915 6 110 30 $C_GREEN [Drawing.Color]::White
    $tbtn.Tag=$a
    $tbtn.Add_Click({
        $ag=$this.Tag; $ag.Active=-not $ag.Active
        if($ag.Active){
            $this.Text="AKTYWNY"; $this.BackColor=$C_GREEN
            if($global:DotCtrls[$ag.ID]){$global:DotCtrls[$ag.ID].BackColor=$C_GREEN}
            Write-Log "Aktywowano: $($ag.Label)"
        } else {
            $this.Text="NIEAKTYWNY"; $this.BackColor=$C_RED
            if($global:DotCtrls[$ag.ID]){$global:DotCtrls[$ag.ID].BackColor=$C_RED}
            Write-Log "Dezaktywowano: $($ag.Label)"
        }
        $on=($global:Agents|Where-Object{$_.Active}).Count
        $global:SbarLbl.Text="  Tasklet Agent Panel v1.0  |  $on/15 agentow aktywnych  |  © 2026 tom"
    })
    $cp.Controls.Add($tbtn)
    $global:ToggleBtns[$a.ID]=$tbtn
    $ctrlScroll.Controls.Add($cp)
    $ci++
}

$btnAllOn.Add_Click({
    foreach($a in $global:Agents){
        $a.Active=$true
        if($global:ToggleBtns[$a.ID]){$global:ToggleBtns[$a.ID].Text="AKTYWNY";$global:ToggleBtns[$a.ID].BackColor=$C_GREEN}
        if($global:DotCtrls[$a.ID]){$global:DotCtrls[$a.ID].BackColor=$C_GREEN}
    }
    $global:SbarLbl.Text="  Tasklet Agent Panel v1.0  |  15/15 agentow aktywnych  |  © 2026 tom"
    Write-Log "Aktywowano wszystkich 15 agentow"
})
$btnAllOff.Add_Click({
    foreach($a in $global:Agents){
        $a.Active=$false
        if($global:ToggleBtns[$a.ID]){$global:ToggleBtns[$a.ID].Text="NIEAKTYWNY";$global:ToggleBtns[$a.ID].BackColor=$C_RED}
        if($global:DotCtrls[$a.ID]){$global:DotCtrls[$a.ID].BackColor=$C_RED}
    }
    $global:SbarLbl.Text="  Tasklet Agent Panel v1.0  |  0/15 agentow aktywnych  |  © 2026 tom"
    Write-Log "Dezaktywowano wszystkich agentow"
})

# ══════════════════════════════════════════════
#  TAB 4 — LOG / INFO
# ══════════════════════════════════════════════
$tLog = New-Object Windows.Forms.TabPage "LOG / INFO"
$tLog.BackColor = $C_BG; $tabs.TabPages.Add($tLog)

$tLog.Controls.Add((New-Lbl "DZIENNIK ZDARZEN" 20 12 600 32 $F_TITLE $C_TEXT))

$global:LogBox = New-Object Windows.Forms.RichTextBox
$global:LogBox.Location=[Drawing.Point]::new(20,58); $global:LogBox.Size=[Drawing.Size]::new(780,548)
$global:LogBox.BackColor=[Drawing.Color]::FromArgb(8,8,16); $global:LogBox.ForeColor=$C_GREEN
$global:LogBox.Font=$F_MONO; $global:LogBox.ReadOnly=$true; $global:LogBox.BorderStyle="None"
$tLog.Controls.Add($global:LogBox)

# Info panel po prawej
$infoPnl=New-Object Windows.Forms.Panel; $infoPnl.Location=[Drawing.Point]::new(815,58); $infoPnl.Size=[Drawing.Size]::new(255,548); $infoPnl.BackColor=$C_CARD
$tLog.Controls.Add($infoPnl)

$infoTxt = @(
    @{T="TASKLET AGENT PANEL";  F=$F_HEAD;  C=$C_ACCENT},
    @{T="Wersja: 1.0";          F=$F_SMALL; C=$C_SUB},
    @{T="Data: 2026-06-07";     F=$F_SMALL; C=$C_SUB},
    @{T="";                     F=$F_SMALL; C=$C_SUB},
    @{T="WLASCICIEL:";          F=$F_HEAD;  C=$C_ACCENT},
    @{T="tom";                  F=$F_NORM;  C=$C_TEXT},
    @{T="imperiumultrapro2";    F=$F_SMALL; C=$C_SUB},
    @{T="@wp.pl";               F=$F_SMALL; C=$C_SUB},
    @{T="";                     F=$F_SMALL; C=$C_SUB},
    @{T="OCHRONA PRAWNA:";      F=$F_HEAD;  C=$C_ACCENT},
    @{T="Prawo autorskie PL";   F=$F_SMALL; C=$C_SUB},
    @{T="Wlasnosc intelekt.";   F=$F_SMALL; C=$C_SUB},
    @{T="Tajemnica handlowa";   F=$F_SMALL; C=$C_RED},
    @{T="Dyrektywa UE 2016/943";F=$F_SMALL; C=$C_SUB},
    @{T="";                     F=$F_SMALL; C=$C_SUB},
    @{T="AGENCI:";              F=$F_HEAD;  C=$C_ACCENT},
    @{T="15 agentow";           F=$F_SMALL; C=$C_GREEN},
    @{T="6 kategorii";          F=$F_SMALL; C=$C_SUB},
    @{T="Jakosc / Analiza";     F=$F_SMALL; C=$C_SUB},
    @{T="IT / Cybersec";        F=$F_SMALL; C=$C_SUB},
    @{T="Przemysl";             F=$F_SMALL; C=$C_SUB},
    @{T="Ratownictwo";          F=$F_SMALL; C=$C_SUB},
    @{T="";                     F=$F_SMALL; C=$C_SUB},
    @{T="ID: PANEL-WIN-v1.0";   F=$F_MONO;  C=$C_BORDER}
)
$iy=12
foreach($i in $infoTxt){
    $infoPnl.Controls.Add((New-Lbl $i.T 12 $iy 235 18 $i.F $i.C))
    $iy+=20
}

$btnClrLog=New-Btn "WYCZYSC LOG" 20 612 130 28 $C_CARD2 $C_SUB
$btnClrLog.Add_Click({
    $global:LogBox.Clear()
    Write-Log "Log wyczyszczony"
})
$tLog.Controls.Add($btnClrLog)

# ══════════════════════════════════════════════
#  URUCHOM
# ══════════════════════════════════════════════
Write-Log "System uruchomiony — PANEL-WIN-v1.0"
Write-Log "Zaladowano 15 agentow w 6 kategoriach"
Write-Log "Wlasciciel: tom | Tajemnica Handlowa"
Write-Log "Gotowy do pracy."

[Windows.Forms.Application]::Run($form)
