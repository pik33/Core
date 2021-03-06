{
Ultibo CP720 (OEM) interface unit.

Copyright (C) 2016 - SoftOz Pty Ltd.

Arch
====

 <All>

Boards
======

 <All>

Licence
=======

 LGPLv2.1 with static linking exception (See COPYING.modifiedLGPL.txt)
 
Credits
=======

 Information for this unit was obtained from:

 
References
==========


CP720 OEM (Arabic)
====================

 Note: This unit automatically includes CP1256ANSI as the matching ANSI code page.

}

{$mode delphi} {Default to Delphi compatible syntax}
{$H+}          {Default to AnsiString}
{$inline on}   {Allow use of Inline procedures}

unit CP720OEM;

interface

uses GlobalConfig,GlobalConst,GlobalTypes,Locale;

{==============================================================================}
{Global definitions}
{$INCLUDE ..\core\GlobalDefines.inc}
        
{==============================================================================}
{const}
 {CP720OEM specific constants}

{==============================================================================}
{type}
 {CP720OEM specific types}

{==============================================================================}
{var}
 {CP720OEM specific variables}

{==============================================================================}
{Initialization Functions}
procedure CP720OEMInit;
 
{==============================================================================}
{CP720OEM Functions}
 
{==============================================================================}
{CP720OEM Helper Functions}
 
{==============================================================================}
{==============================================================================}

implementation

uses CP1256ANSI;

{==============================================================================}
{==============================================================================}
var
 {CP720OEM specific variables}
 CP720OEMInitialized:Boolean;

 CPOEM720:TCodeTable = (
  MaxCharSize:1;
  DefaultChar:(
  $3F,$00);
  LeadByte:(
  $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00);
  Values:(
  $0000,$0001,$0002,$0003,$0004,$0005,$0006,$0007,
  $0008,$0009,$000A,$000B,$000C,$000D,$000E,$000F,
  $0010,$0011,$0012,$0013,$0014,$0015,$0016,$0017,
  $0018,$0019,$001A,$001B,$001C,$001D,$001E,$001F,
  $0020,$0021,$0022,$0023,$0024,$0025,$0026,$0027,
  $0028,$0029,$002A,$002B,$002C,$002D,$002E,$002F,
  $0030,$0031,$0032,$0033,$0034,$0035,$0036,$0037,
  $0038,$0039,$003A,$003B,$003C,$003D,$003E,$003F,
  $0040,$0041,$0042,$0043,$0044,$0045,$0046,$0047,
  $0048,$0049,$004A,$004B,$004C,$004D,$004E,$004F,
  $0050,$0051,$0052,$0053,$0054,$0055,$0056,$0057,
  $0058,$0059,$005A,$005B,$005C,$005D,$005E,$005F,
  $0060,$0061,$0062,$0063,$0064,$0065,$0066,$0067,
  $0068,$0069,$006A,$006B,$006C,$006D,$006E,$006F,
  $0070,$0071,$0072,$0073,$0074,$0075,$0076,$0077,
  $0078,$0079,$007A,$007B,$007C,$007D,$007E,$007F,
  $0080,$0081,$00E9,$00E2,$0084,$00E0,$0086,$00E7,
  $00EA,$00EB,$00E8,$00EF,$00EE,$008D,$008E,$008F,
  $0090,$0651,$0652,$00F4,$00A4,$0640,$00FB,$00F9,
  $0621,$0622,$0623,$0624,$00A3,$0625,$0626,$0627,
  $0628,$0629,$062A,$062B,$062C,$062D,$062E,$062F,
  $0630,$0631,$0632,$0633,$0634,$0635,$00AB,$00BB,
  $2591,$2592,$2593,$2502,$2524,$2561,$2562,$2556,
  $2555,$2563,$2551,$2557,$255D,$255C,$255B,$2510,
  $2514,$2534,$252C,$251C,$2500,$253C,$255E,$255F,
  $255A,$2554,$2569,$2566,$2560,$2550,$256C,$2567,
  $2568,$2564,$2565,$2559,$2558,$2552,$2553,$256B,
  $256A,$2518,$250C,$2588,$2584,$258C,$2590,$2580,
  $0636,$0637,$0638,$0639,$063A,$0641,$00B5,$0642,
  $0643,$0644,$0645,$0646,$0647,$0648,$0649,$064A,
  $2261,$064B,$064C,$064D,$064E,$064F,$0650,$2248,
  $00B0,$2219,$00B7,$221A,$207F,$00B2,$25A0,$00A0)
 );
 
 CP720TO1256:TTransTable = (
  TransID:1256;
  Values:(
  $00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$A4,
  $10,$11,$12,$13,$B6,$A7,$16,$17,$18,$19,$1A,$1B,$1C,$1D,$1E,$1F,
  $20,$21,$22,$23,$24,$25,$26,$27,$28,$29,$2A,$2B,$2C,$2D,$2E,$2F,
  $30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$3A,$3B,$3C,$3D,$3E,$3F,
  $40,$41,$42,$43,$44,$45,$46,$47,$48,$49,$4A,$4B,$4C,$4D,$4E,$4F,
  $50,$51,$52,$53,$54,$55,$56,$57,$58,$59,$5A,$5B,$5C,$5D,$5E,$5F,
  $60,$61,$62,$63,$64,$65,$66,$67,$68,$69,$6A,$6B,$6C,$6D,$6E,$6F,
  $70,$71,$72,$73,$74,$75,$76,$77,$78,$79,$7A,$7B,$7C,$7D,$7E,$7F,
  $5F,$5F,$E9,$E2,$5F,$E0,$5F,$E7,$EA,$EB,$E8,$EF,$EE,$5F,$5F,$5F,
  $5F,$F8,$FA,$F4,$A4,$DC,$FB,$F9,$C1,$C2,$C3,$C4,$A3,$C5,$C6,$C7,
  $C8,$C9,$CA,$CB,$CC,$CD,$CE,$CF,$D0,$D1,$D2,$D3,$D4,$D5,$AB,$BB,
  $5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,
  $5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,
  $5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,
  $D6,$D8,$D9,$DA,$DB,$DD,$B5,$DE,$DF,$E1,$E3,$E4,$E5,$E6,$EC,$ED,
  $5F,$F0,$F1,$F2,$F3,$F5,$F6,$5F,$B0,$5F,$B7,$5F,$5F,$B2,$5F,$A0)
 );
 
{==============================================================================}
{==============================================================================}
{Initialization Functions}
procedure CP720OEMInit;
begin
 {}
 {Check Initialized}
 if CP720OEMInitialized then Exit;

 {Load Default Code Pages}
 LoadPage(CP_OEM_720,@CPOEM720,nil,nil);
 InstallTrans(CP_OEM_720,@CP720TO1256);

 CP720OEMInitialized:=True;
end;

{==============================================================================}
{==============================================================================}
{CP720OEM Functions}

{==============================================================================}
{==============================================================================}
{CP720OEM Helper Functions}

{==============================================================================}
{==============================================================================}

initialization
 CP720OEMInit;
 
{==============================================================================}
 
finalization
 {Nothing}

{==============================================================================}
{==============================================================================}

end.
