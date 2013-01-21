module.exports = class Children

    @children: []

    @add: (child) -> 

        @children.push child

    @stop: -> 

        for child in @children

            child.kill()
