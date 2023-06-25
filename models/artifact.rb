=begin
CREATE TABLE artifact (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255),
    packageFormat VARCHAR(255),
    description VARCHAR(255),
    version VARCHAR(255),
    author VARCHAR(255),
    contributors VARCHAR(255),
    product VARCHAR(255),
    filename VARCHAR(255),
    size VARCHAR(255),
    gav VARCHAR(255),
    mirrors VARCHAR(255)
);
=end

 
# List all artifacts
get '/artifacts' do
    page = params['page']
    if page
      page = page.to_i
      all_artifacts = Artifact.all[(page-1)*10..page*10-1].collect { |a|
        a.values
      }
    else
      all_artifacts = Artifact.all.collect { |a|
        a.values
      }
    end
    status 200
    all_artifacts.to_json
end

# Create a new artifact
post '/artifacts' do
    data = JSON.parse(request.body.read)
    artifact = Artifact.create(data)
    status 201
    artifact.values.to_json
end

# Get a specific artifact
get '/artifact/:id' do
    artifact = Artifact[params[:id]]
    halt 404 if artifact.nil?
    artifact.values.to_json
end

# Update a specific artifact
put '/artifact/:id' do
    artifact = Artifact[params[:id]]
    halt 404 if artifact.nil?
    data = JSON.parse(request.body.read)
    artifact.update(data)
    status 200
    artifact.values.to_json
end

# Delete a specific artifact
delete '/artifact/:id' do
    artifact = Artifact[params[:id]]
    halt 404 if artifact.nil?
    artifact.delete
    status 204
end

path_yaml = <<-CONFIG
  /artifacts:
    get:
      summary: Get all artifacts
      operationId: getArtifacts
      parameters:
        - name: page
          in: query
          description: The page number to retrieve. Each page contains 10 items.
          schema:
            type: integer      
      responses:
        '200':
          description: A list of artifacts
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/Artifact'
    post:
      summary: Create a new artifact
      operationId: createArtifact
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/Artifact'
      responses:
        '201':
          description: Artifact created
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Artifact'
  /artifact/{id}:
    get:
      summary: Get an artifact by ID
      operationId: getArtifactById
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
      responses:
        '200':
          description: An artifact
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Artifact'
    put:
      summary: Update an artifact by ID
      operationId: updateArtifactById
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
              $ref: '#/components/schemas/Artifact'
      responses:
        '200':
          description: Artifact updated
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Artifact'
    delete:
      summary: Delete an artifact by ID
      operationId: deleteArtifactById
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
      responses:
        '204':
          description: Artifact deleted
CONFIG

APIConfig.add_path(path_yaml)

componet_yaml = <<-CONFIG
    Artifact:
      type: object
      properties:
        id:
            type: integer
            readOnly: true
        name:
            type: string
        packageFormat:
            type: string
        description:
            type: string
        version:
            type: string
        author:
            type: string
        contributors:
            type: string
        product:
            type: string
        filename:
            type: string
        size:
            type: string
        gav:
            type: string
        mirrors:
            type: string
      required:
        - name
CONFIG

APIConfig.add_component(componet_yaml)