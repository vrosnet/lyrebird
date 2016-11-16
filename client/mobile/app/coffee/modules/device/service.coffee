DeviceCollection = require './collection'

# # # # #

class DeviceService extends Marionette.Service

  radioRequests:
    'device model': 'model'
    'device collection': 'collection'

  radioEvents:
    'device refresh': 'refresh'

  initialize: ->
    @collectionCache = new DeviceCollection()

  refresh: ->

    # Throttles multiple calls to refresh
    return if @scanning

    # Resets collection
    @collectionCache.reset([])

    # Success callback
    onDeviceFound = (device) =>
      @collectionCache.add device

    # Error callback
    onScanError = () ->
      console.log 'ERROR FETCHING DEVICES'
      return

    # Starts scan
    ble.startScan([], onDeviceFound, onScanError)

    onScanComplete = =>
      console.log 'Scan complete'
      @scanning = false

    onStopFail = => console.log 'StopScan failure'

    # Stops scan after 5 seconds
    @scanning = true
    setTimeout(ble.stopScan, 5000, onScanComplete, onStopFail)


  model: (id) ->
    return new Promise (resolve,reject) =>
      resolve(@collectionCache.get(id))

  # TODO - a lot of this should be abstracted into the bluetooth service
  collection: ->

    return new Promise (resolve,reject) =>

      # Invokes refresh with respect to this collection
      @refresh()

      # Returns collection, async
      return resolve(@collectionCache)

# # # # #

module.exports = new DeviceService()