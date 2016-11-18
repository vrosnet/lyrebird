KnownDeviceModel = require './model'
KnownDeviceCollection = require './collection'

# # # # #

class KnownDeviceStorage extends Marionette.Service

  radioRequests:
    'known:device collection': 'collection'

  radioEvents:
    'known:device add':     'addDevice'
    'known:device remove':  'removeDevice'

  initialize: ->
    @cached = new KnownDeviceCollection()

  collection: -> # Fetches from localStorage
    return new Promise (resolve,reject) =>
      @cached.on 'sync', => resolve(@cached) # Success callback
      @cached.fetch()

  addDevice: (device) ->
    @cached.create({ id: device.id }, {remote: false})
    device.set('known', true)

  removeDevice: (device) ->
    device.set('known', false)
    @cached.remove(device.id)

# # # # #

module.exports = new KnownDeviceStorage()
