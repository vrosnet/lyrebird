
class HapticBehavior extends Marionette.Behavior

  ui:
    'hapticInput': '[data-haptic]'

  events:
    'click @ui.hapticInput': 'onHapticClick'

  onHapticClick: ->
    plugins?.deviceFeedback.haptic()
    plugins?.deviceFeedback.acoustic()

# # # # #

module.exports = HapticBehavior
