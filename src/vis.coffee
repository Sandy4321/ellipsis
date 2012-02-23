class N3Vis
    @lookup = {}    # static lookup table   visId   -> N3Vis
    
    constructor: (@visId) ->
        @states = {}     # lookup table     stateId -> N3State
        @consts = {}     # lookup table     constId -> constVal
        
        return this
        
    stage: (sel, w, h) ->
        if arguments.length == 3
            @stageSelector  = sel
            @stageWidth     = w
            @stageHeight    = h
            
            return this
        else
            d3.select(@stageSelector)            
            
    width: (width) -> 
        if arguments.length == 1
            @stageWidth = width
            
            return this
        else
            @stageWidth
    
    height: (height) -> 
        if arguments.length == 1
            @stageHeight = height

            return this
        else
            @stageHeight
    
    data: (data) ->
        if arguments.length == 1
            @dataObj = data
                        
            return this
        else
            @dataObj
    
    state: (stateId, validValues) ->
        if arguments.length == 2
            @states[stateId] = new N3State(stateId, validValues, @visId)
            
            return this
        else
            @states[stateId]?.get()            

    const: (constId, value) ->
        if arguments.length == 2
            # consts are read only, so only add them if they haven't already
            # been defined
            @consts[constId] = value unless constId of @consts
            
            return this
        else
            @consts[constId]        
            
    render: (@renderFn) ->
        return this
        
n3.vis = (visId) ->
    N3Vis.lookup[visId] or= new N3Vis(visId)