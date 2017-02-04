# NodeWebKit manifest

manifest =
  name:             'Lyrebird Desktop'
  version:          '0.0.1'
  main:             'index.html'
  'node-main':      './js/server.js'
  # 'chromium-args':  '--enable-logging=stderr'
  window:
    toolbar:  true
    frame:    true
    width:    1280
    height:   800

# # # # #

module.exports = JSON.stringify manifest, null, 2 # Stringifies manifest, indented 2 spaces