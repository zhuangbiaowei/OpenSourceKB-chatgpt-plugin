=begin
CREATE TABLE version (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    product VARCHAR(255),
    version VARCHAR(255),
    agreement VARCHAR(255),
    patent VARCHAR(255),
    copyright VARCHAR(255),
    purl VARCHAR(255),
    swid VARCHAR(255),
    platform VARCHAR(255),
    releaseDate VARCHAR(255)
);
=end

 
# List all versions
get '/versions' do  
    page = params['page']
    if page
        page = page.to_i
        all_versions = Version.all[(page-1)*10..page*10-1].collect { |v|
           v.values
        }
    else
        all_versions = Version.all.collect { |v|
            v.values
        }
    end
    status 200
    all_versions.to_json
end

# Create a new version
post '/versions' do
    data = JSON.parse(request.body.read)
    version = Version.create(data)
    status 201
    version.values.to_json
end

# Get a specific version
get '/version/:id' do
    version = Version[params[:id]]
    halt 404 if version.nil?
    version.values.to_json
end

# Update a specific version
put '/version/:id' do
    version = Version[params[:id]]
    halt 404 if version.nil?
    data = JSON.parse(request.body.read)
    version.update(data)
    status 200
    version.values.to_json
end

# Delete a specific version
delete '/version/:id' do
    version = Version[params[:id]]
    halt 404 if version.nil?
    version.delete
    status 204
end

path_yaml = <<-CONFIG
  /versions:
    get:
      summary: Get all versions
      operationId: getVersions
      parameters:
        - name: page
          in: query
          description: The page number to retrieve. Each page contains 10 items.
          schema:
            type: integer
      responses:
        '200':
          description: A list of versions
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/Version'
    post:
      summary: Create a new version
      operationId: createVersion
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/Version'
      responses:
        '201':
          description: Version created
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Version'
  /version/{id}:
    get:
      summary: Get a version by ID
      operationId: getVersionById
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
      responses:
        '200':
          description: A version
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Version'
    put:
      summary: Update a version by ID
      operationId: updateVersionById
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
              $ref: '#/components/schemas/Version'
      responses:
        '200':
          description: Version updated
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Version'
    delete:
      summary: Delete a version by ID
      operationId: deleteVersionById
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
      responses:
        '204':
          description: Version deleted
CONFIG

APIConfig.add_path(path_yaml)

componet_yaml = <<-CONFIG
    Version:
      type: object
      properties:
        id:
            type: integer
            readOnly: true
        product:
            type: string
        version:
            type: string
        agreement:
            type: string
        patent:
            type: string
        copyright:
            type: string
        purl:
            type: string
        swid:
            type: string
        platform:
            type: string
        releaseDate:
            type: string
      required:
        - product
        - version
CONFIG

APIConfig.add_component(componet_yaml)


