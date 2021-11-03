controladdin "Drop Area Control AddIn"
{
    StartupScript = 'controladdin/DropAreaControl/Script/start.js';
    Scripts = 'controladdin/DropAreaControl/Script/DropArea.js';
    StyleSheets = 'controladdin/DropAreaControl/StyleSheet/DropArea.css';
    Images = 'controladdin/DropAreaControl/Image/BackgroundImage.png';

    MinimumHeight = 100;
    MinimumWidth = 150;
    HorizontalShrink = true;
    HorizontalStretch = true;

    event AddInReady();
    event FileDropBegin(filename: Text);
    procedure ReadyForData(filename: Text);
    event FileDrop(data: Text);
    event FileDropEnd();
    event AllFilesUploaded();
}