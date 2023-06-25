require 'sequel'

DB = Sequel.connect('sqlite://kb.db')

class OpenSourceProject < Sequel::Model(:openSourceProject)
end

class People < Sequel::Model(:people)
end

class PeopleEvent < Sequel::Model(:peopleEvent)
end

class OpenSourceProduct < Sequel::Model(:openSourceProduct)
end

class Agreement < Sequel::Model(:agreement)
end

class Copyright < Sequel::Model(:copyright)
end

class Patent < Sequel::Model(:patent)
end

class Version < Sequel::Model(:version)
end

class CVE < Sequel::Model(:CVE)
end

class Issue < Sequel::Model(:issue)
end

class Repository < Sequel::Model(:repository)
end

class Branch < Sequel::Model(:branch)
end

class Tag < Sequel::Model(:tag)
end

class Artifact < Sequel::Model(:artifact)
end

class PackageManegementTool < Sequel::Model(:packageManegementTool)
end

class DevService < Sequel::Model(:devService)
end

class Mirror < Sequel::Model(:mirror)
end

class Community < Sequel::Model(:community)
end

class Foundation < Sequel::Model(:foundation)
end

class MediaPlatform < Sequel::Model(:mediaPlatform)
end

class OrgBehavior < Sequel::Model(:orgBehavior)
end