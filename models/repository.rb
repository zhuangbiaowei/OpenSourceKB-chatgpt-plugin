=begin
CREATE TABLE repository (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255),
    vcsType VARCHAR(255),
    repoType VARCHAR(255),
    owner VARCHAR(255),
    project VARCHAR(255),
    url VARCHAR(255),
    devService VARCHAR(255)
);
=end

 
# List all open source repositories
get '/repositories' do  
    all_repositories = Repository.all.collect { |r|
        r.values
    }
    status 200
    all_repositories.to_json
end

# Create a new open source repository
post '/repositories' do
    data = JSON.parse(request.body.read)
    repository = Repository.create(data)
    status 201
    repository.values.to_json
end

# Get a specific open source repository
get '/repository/:id' do
    repository = Repository[params[:id]]
    halt 404 if repository.nil?
    repository.values.to_json
end

# Update a specific open source repository
put '/repository/:id' do
    repository = Repository[params[:id]]
    halt 404 if repository.nil?
    data = JSON.parse(request.body.read)
    repository.update(data)
    status 200
    repository.values.to_json
end

# Delete a specific open source repository
delete '/repository/:id' do
    repository = Repository[params[:id]]
    halt 404 if repository.nil?
    repository.delete
    status 204
end

path_yaml = <<-CONFIG
  /repositories:
    get:
      summary: Get all repositories
      operationId: getRepositories
      responses:
        '200':
          description: A list of repositories
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/Repository'
    post:
      summary: Create a new repository
      operationId: createRepository
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/Repository'
      responses:
        '201':
          description: Repository created
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Repository'
  /repository/{id}:
    get:
      summary: Get a repository by ID
      operationId: getRepositoryById
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
      responses:
        '200':
          description: A repository
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Repository'
    put:
      summary: Update a repository by ID
      operationId: updateRepositoryById
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/Repository'
      responses:
        '200':
          description: Repository updated
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Repository'
    delete:
      summary: Delete a repository by ID
      operationId: deleteRepositoryById
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
      responses:
        '204':
          description: Repository deleted
CONFIG

APIConfig.add_path(path_yaml)

componet_yaml = <<-CONFIG
    Repository:
      type: object
      properties:
        id:
            type: integer
            readOnly: true
        name:
            type: string
        vcsType:
            type: string
        repoType:
            type: string
        owner:
            type: string
        project:
            type: string
        url:
            type: string
        devService:
            type: string
      required:
        - name
CONFIG

APIConfig.add_component(componet_yaml)