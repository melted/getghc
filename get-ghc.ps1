$current_dir = pwd

function get-tarball {
    param([string]$url, [string]$outfile, [string]$hash)
    $exists = Test-Path $outfile
    if(!$exists) {
        Invoke-WebRequest $url -OutFile $outfile -UserAgent "Curl"
        if(Test-Path $outfile) {
            Unblock-File $outfile
        } else {
            Write-Error "failed to get file $url"
            return $false
        }
    }
    $filehash = Get-FileHash $outfile -Algorithm SHA1
    if ($filehash.Hash -ne $hash) {
        rm $outfile
        $res = $filehash.Hash
        Write-Error "Mismatching hashes for $url, expected $hash, got $res"
        return $false
    } else {
        return $true
    }
}

function extract-zip
{
    param([string]$zip, [string] $outdir)
    $has_dir=Test-Path $outdir
    if(!$has_dir) {
        mkdir $outdir
    }
    if(test-path $zip)
    {
        $shell = new-object -com shell.application
        $zipdir = $shell.NameSpace($zip)
        $target = $shell.NameSpace($outdir)
        $target.CopyHere($zipdir.Items())
    }
}


function create-dir {
    param([string]$name)
    $exists = test-path $name
    if(!$exists) {
        mkdir $name
    }
}

function create-dirs {
    create-dir downloads
    create-dir support
}

function install-python() {
    $url="https://www.python.org/ftp/python/2.7.6/python-2.7.6.msi"
    $file="downloads\python.msi"
    $hash="C5D71F339F7EDD70ECD54B50E97356191347D355"
    if(get-tarball $url $file $hash) {
        msiexec /i $file /qn TARGETDIR="$current_dir\python-2.7"
    }
}

function install-ghc32 {
    $url="http://www.haskell.org/ghc/dist/7.6.3/ghc-7.6.3-i386-unknown-mingw32.tar.bz2"
    $file="downloads\ghc32.tar.bz"
    $hash="8729A1D7E73D69CE6CFA6E5519D6710F53A57064"
    if(get-tarball $url $file $hash) {
        .\support\7za x -y $file
        .\support\7za x -y ghc32.tar -omsys32
        rm ghc32.tar
    }
}

function install-msys32() {
    $url="http://sourceforge.net/projects/msys2/files/Base/i686/msys2-base-i686-20131208.tar.xz/download"
    $file="downloads\msys32.tar.xz"
    $hash="6AD1FA798C7B7CA9BFC46F01708689FD54B2BB9B"
    if(get-tarball $url $file $hash) {
        .\support\7za x -y $file
        .\support\7za x -y msys32.tar
        rm msys32.tar
    }
}

function install-ghc64 {
    $url="http://www.haskell.org/ghc/dist/7.6.3/ghc-7.6.3-x86_64-unknown-mingw32.tar.bz2"
    $file="downloads\ghc64.tar.bz2"
    $hash="758AC43AA13474C55F7FC25B9B19E47F93FD7E99"
    if(get-tarball $url $file $hash) {
        .\support\7za x -y $file
        .\support\7za x -y ghc64.tar -omsys64
        rm ghc64.tar
    }
}

function install-msys64() {
    $url="http://sourceforge.net/projects/msys2/files/Base/x86_64/msys2-base-x86_64-20140216.tar.xz/download"
    $file="downloads\msys64.tar.xz"
    $hash="B512C52B3DAE5274262163A126CE43E5EE4CA4BA"
    if(get-tarball $url $file $hash) {
        .\support\7za x -y $file
        .\support\7za x -y msys64.tar
        rm msys64.tar
    }
}

function install-7zip() {
    $url="http://sourceforge.net/projects/sevenzip/files/7-Zip/9.20/7za920.zip/download"
    $file="downloads\7z.zip"
    $hash="9CE9CE89EBC070FEA5D679936F21F9DDE25FAAE0"
    if (get-tarball $url $file $hash) {
        $dir = "$current_dir\support\7z"
        $abs_file = "$current_dir\$file"
        create-dir $dir
        Extract-Zip $abs_file $dir
    }
}


function run-msys-installscrips() {
    .\msys32\bin\mintty.exe .\install.sh
    .\msys64\bin\mintty.exe .\install.sh
    .\msys64\bin\mintty.exe .\ghc.sh # Share the source tree
}

create-dirs
echo "Getting Python"
install-python
echo "Getting 7-zip"
install-7zip
echo "Getting msys32"
install-msys32
echo "Getting bootstrap GHC 32-bit"
install-ghc32
echo "Getting msys64"
install-msys64
echo "Getting bootstrap GHC 64-bit"
install-ghc64
echo "Starting msys configuration"
run-msys-installscrips
