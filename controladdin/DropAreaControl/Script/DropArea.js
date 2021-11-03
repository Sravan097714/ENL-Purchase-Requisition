/*
http://html5demos.com/file-api
http://www.html5rocks.com/en/tutorials/file/dndfiles/
http://www.typescriptlang.org
How to handle warnings for proprietary/custom properties of built-in objects in TypeScript
http://stackoverflow.com/questions/12703266/how-to-handle-warnings-for-proprietary-custom-properties-of-built-in-objects-in/12703866#12703866
Ignore Typescript Errors “property does not exist on value of type” - 'override' the type system
http://stackoverflow.com/questions/18083389/ignore-typescript-errors-property-does-not-exist-on-value-of-type
*/
function Init() {
    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('AddInReady', null);
    initializeControlAddIn();
}

var Upload = (function () {
    function Upload(newName, newFile) {
        this.newName = newName;
        this.newFile = newFile;
        this.name = newName;
        this.file = newFile;
        this.data = null;
        this.length = 0;
        this.totalLength = 0;
    }
    return Upload;
})();

var UploadQueue = (function () {
    function UploadQueue() {
        this.currentData = null;
        this.uploadQueue = new Array();
    }
    UploadQueue.prototype.IndexOfName = function (name) {
        var length = this.uploadQueue.length;
        var upload;
        var pos = -1;

        this.uploadQueue.forEach(function (u, i) {
            if (u.name == name) {
                pos = i;
                return;
            }
        });

        return pos;
    };

    UploadQueue.prototype.FindUpload = function (name) {
        var index = this.IndexOfName(name);

        if (index >= 0) {
            return this.uploadQueue[index];
        }

        return null;
    };

    UploadQueue.prototype.RemoveUpload = function (name) {
        var index = this.IndexOfName(name);

        if (index >= 0) {
            this.uploadQueue.splice(index, 1);
        }
    };

    UploadQueue.prototype.Push = function (upload) {
        this.uploadQueue.push(upload);
    };

    UploadQueue.prototype.StartSendData = function () {
        if (this.uploadQueue.length > 0) {
            this.uploadInProgress = true;
            var upload = this.uploadQueue[0];

            updateStatus(upload.name + ' (' + this.uploadQueue.length + ')', 'success');

            var reader = new FileReader();

            // Save file and upload reference for use in events
            reader.upload = upload;

            reader.onabort = function (event) {
                alert('File read cancelled');
            };

            reader.onloadstart = function (event) {
                updateProgress('Loading', 'loading', -1);
            };

            reader.onprogress = function (event) {
                if (event.lengthComputable) {
                    var percentLoaded = Math.round((event.loaded / event.total) * 100);

                    if (percentLoaded < 100) {
                        updateProgress('Loading', 'loading', percentLoaded);
                    }
                }
            };

            reader.onloadend = function (event) {
                var data = event.target.result;

                if (data != null) {
                    this.upload.data = data;
                    this.upload.length = data.length;
                    this.upload.totalLength = data.length;
                }

                // Ensure that the progress bar displays 100% at the end.
                updateProgress('', '', 100);


                Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('FileDropBegin', [this.upload.name]);
            };

            reader.onload = function (event) {
            };

            reader.readAsDataURL(upload.file);
        } else {
            Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('AllFilesUploaded', null);
            this.uploadInProgress = false;
            updateStatus('Ready!', 'success');
        }
    };

    UploadQueue.prototype.SendData = function () {
        if (this.currentData != null) {
            Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('FileDrop', [this.currentData]);
        } else {
            Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('FileDropEnd', null);
            this.StartSendData();
        }
    };

    UploadQueue.prototype.ReadyForData = function (name) {
        var upload = this.FindUpload(name);

        if (upload != null) {
            if (upload.length > 0) {
                var currentLength = (upload.length > 16384) ? 16384 : upload.length;
                this.currentData = upload.data.substr(0, currentLength);
                upload.data = (upload.length > currentLength) ? upload.data.substr(currentLength) : "";
                upload.length -= currentLength;

                var percentUploaded = Math.round(((upload.totalLength - upload.length) / upload.totalLength) * 100);
                updateProgress('Uploading', 'loading', percentUploaded);

                setTimeout("uploadQueue.SendData();", 10);

                return;
            }
        }

        this.currentData = null;
        this.RemoveUpload(name);
        updateProgress('', '', 0);

        setTimeout("uploadQueue.SendData();", 10);
    };
    return UploadQueue;
})();

var uploadQueue = new UploadQueue();

function ReadyForData(name) {
    uploadQueue.ReadyForData(name);
}

function onDragOver(e) {
    this.className = 'hover';
    return false;
}

function onDragLeave(e) {
    this.className = '';
    return false;
}

function onDragEnd(e) {
    this.className = '';
    return false;
}

function onDrop(e) {
    this.className = 'drop';
    e.preventDefault();

    // Reset progress indicator on new file selection.
    updateProgress('', '', 0);

    var type = e.dataTransfer.types[0];

    if (type === "Text") {
        var content = e.dataTransfer.getData(type);
        alert(content);
    } else if (type === "Files") {
        var files = e.dataTransfer.files;

        for (var i = 0, file; file = files[i]; i++) {
            var upload = new Upload(file.name, file);
            uploadQueue.Push(upload);
        }
    }

    if (!uploadQueue.uploadInProgress) {
        uploadQueue.StartSendData();
    }

    this.className = '';

    return false;
}

function initializeControlAddIn() {
    var iframe = window.frameElement;
    iframe.parentElement.style.display = 'flex';
    iframe.parentElement.style.flexDirection = 'column';
    iframe.parentElement.style.flexGrow = '1';

    iframe.style.removeProperty('height');
    iframe.style.removeProperty('min-height');
    iframe.style.removeProperty('max-height');

    iframe.style.flexGrow = '1';
    iframe.style.flexShrink = '1';
    iframe.style.flexBasis = 'auto';


    var controlAddIn = document.getElementById('controlAddIn');
    var imageUrl = Microsoft.Dynamics.NAV.GetImageResource('ControlAddIns/DropAreaControl/Image/BackgroundImage.png');
    
    var imageTag = "";

    if (imageUrl != "") {
        imageTag = '<p class="centeredImage"><img src="' + imageUrl + '"></p>';
    }

    controlAddIn.innerHTML = '<section id="container">' + '<article>' + '<p id="status">Not supported</p>' + '<div id="droparea">' + imageTag + '</div>' + '<div id="progressbar"><div class="percent">0%</div></div>' + '</article>' + '</section>';

    pageLoaded();
}

function pageLoaded() {
    var dropArea = document.getElementById('droparea');

    if (typeof window.FileReader === 'undefined') {
        updateStatus('', 'fail');
    } else {
        updateStatus('Ready!', 'success');
    }

    dropArea.ondragover = onDragOver;
    dropArea.ondragleave = onDragLeave;
    dropArea.ondragend = onDragEnd;

    dropArea.ondrop = onDrop;
}

function updateProgress(text, classname, percent) {
    document.getElementById('progressbar').className = classname;

    if (percent >= 0) {
        var progress = document.querySelector('.percent');
        progress.style.width = percent + '%';
        progress.textContent = text + ' (' + percent + '%)';
    }
}

function updateStatus(text, classname) {
    var state = document.getElementById('status');
    state.innerHTML = text;
    state.className = classname;
}
//# sourceMappingURL=DropArea.js.map
