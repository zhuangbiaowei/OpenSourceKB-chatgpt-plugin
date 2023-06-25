class APIConfig
    @@paths = []
    @@components = []

    def self.add_path(path)
        @@paths << path
    end

    def self.add_component(component)
        @@components << component
    end

    def self.paths_string
        "paths:\n"+@@paths.join("")
    end

    def self.components_string
        "components:\n  schemas:\n"+@@components.join("")
    end
end