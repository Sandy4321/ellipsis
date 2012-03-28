class N3State
    constructor: (@visId, @stateId, @validValues, @continuous) ->

    get: ->
        @val

    set: (val) ->
        @prevVal = @val
        valid = if @continuous then (val >= @validValues[0] && val <= @validValues[1]) \
                else (@validValues.indexOf(val) != -1)
        
        throw "#{val} not in the list of valid values: #{@validValues}" \
            unless valid
        
        @val = val
        
        @notify()
        
    notify: ->
        N3Vis.lookup[@visId]?.renderFn?();
        N3Trigger.notify(N3Trigger.TYPES.VIS, [@visId, @stateId], @val)