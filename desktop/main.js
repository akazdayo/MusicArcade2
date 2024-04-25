const { app, BrowserWindow } = require("electron");

const createWindow = () => {
	const win = new BrowserWindow({
		width: 1920,
		height: 1080,
		frame: false,
		fullscreen: true,
	});

	win.loadFile("../export/html5/bin/index.html");
};

app.whenReady().then(() => {
	createWindow();
});
