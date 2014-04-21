$current_dir = pwd

function get-tarball {
    param([string]$url, [string]$outfile, [string]$hash)
    $exists = Test-Path $outfile
    if(!$exists) {
        Invoke-WebRequest $url -OutFile $outfile -UserAgent "Curl"
        if(Test-Path $outfile) {
            Unblock-File $outfile
        } else {
            echo "failed to get file $url"
            return $false
        }
    }
    $filehash = Get-FileHash $outfile -Algorithm SHA1
    if ($filehash.Hash -ne $hash) {
        rm $outfile
        echo "Mismatching hashes for $url, expected $hash, got $filehash.Hash"
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
}

function install-msys32() {
}

function install-ghc64 {
}

function install-msys64() {
}

function install-7zip() {
}


function run-msys-installscrips() {

}

function create-buildscripts() {
    
}

create-dirs
install-python


