require 'opal'
require 'native'
require 'js'
require 'pathname'
require 'pp'

electron = Native(`require('electron')`)
app = electron[:app]
BrowserWindow = electron[:BrowserWindow]

# Keep a global reference of the window object, if you don't, the window will
# be closed automatically when the JavaScript object is garbage collected.
main_window = nil

# Quit when all windows are closed.
app.on('window-all-closed') do
  # On OS X it is common for applications and their menu bar
  # to stay active until the user quits explicitly with Cmd + Q
  app.quit if `global.process.platform` != 'darwin'
end

# This method will be called when Electron has finished
# initialization and is ready to create browser windows.
app.on('ready') do
  # Create the browser window.
  main_window = Native(JS.new(BrowserWindow, { width: 800, height: 600 }.to_n))

  # and load the index.html of the app.
  main_window.loadURL('file://' + Pathname(`__dirname`).parent.to_s +
    '/index.html')

  # Open the DevTools.
  main_window[:webContents].openDevTools

  # Emitted when the window is closed.
  `console.log(main_window)`
  main_window.on('closed') do
    # Dereference the window object, usually you would store windows
    # in an array if your app supports multi windows, this is the time
    # when you should delete the corresponding element.
    main_window = nil
  end
end
