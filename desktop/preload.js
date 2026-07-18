const { contextBridge, ipcRenderer } = require('electron');

// Giriş ekranından ana uygulamaya geçince pencereyi büyütmek için
// güvenli (contextIsolation uyumlu) bir köprü.
contextBridge.exposeInMainWorld('electronAPI', {
  resizeToMain: () => ipcRenderer.send('resize-main-window')
});
