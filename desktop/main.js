const { app, BrowserWindow, dialog, ipcMain } = require('electron');
const { autoUpdater } = require('electron-updater');
const path = require('path');

function createWindow () {
  const win = new BrowserWindow({
    width: 480,
    height: 700,
    minWidth: 420,
    minHeight: 640,
    resizable: true,
    title: 'Akış',
    icon: path.join(__dirname, 'build', 'icon.ico'),
    backgroundColor: '#3B5B58',
    webPreferences: {
      contextIsolation: true,
      nodeIntegration: false,
      preload: path.join(__dirname, 'preload.js')
    }
  });

  win.setMenuBarVisibility(false); // üst menü çubuğunu (Dosya/Düzen/...) gizler, sade görünüm
  win.loadFile('index.html');
  return win;
}

// Giriş başarılı olunca renderer bu mesajı gönderir, pencereyi ana uygulama boyutuna büyütürüz.
ipcMain.on('resize-main-window', (event) => {
  const win = BrowserWindow.fromWebContents(event.sender);
  if (!win) return;
  win.setMinimumSize(900, 600);
  win.setSize(1280, 860);
  win.center();
});

app.whenReady().then(() => {
  createWindow();
  app.on('activate', () => {
    if (BrowserWindow.getAllWindows().length === 0) createWindow();
  });

  // Açılışta sessizce güncelleme kontrolü yapar; yeni sürüm bulunursa indirir
  // ve indirme bitince kullanıcıya sorup yeniden başlatır.
  autoUpdater.checkForUpdatesAndNotify().catch(() => { /* internet yoksa sessiz geç */ });
});

autoUpdater.on('update-downloaded', () => {
  dialog.showMessageBox({
    type: 'info',
    title: 'Güncelleme Hazır',
    message: 'Akış uygulamasının yeni bir sürümü indirildi. Şimdi yeniden başlatılsın mı?',
    buttons: ['Şimdi Yeniden Başlat', 'Daha Sonra']
  }).then((result) => {
    if (result.response === 0) autoUpdater.quitAndInstall();
  });
});

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') app.quit();
});

