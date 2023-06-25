=begin
CREATE TABLE mirror (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    type VARCHAR(255),
    language VARCHAR(255),
    website VARCHAR(255),
    supportTool VARCHAR(255)
);
=end

 
# List all open source mirrors
get '/mirrors' do  
    all_mirrors = Mirror.all.collect { |m|
        m.values
    }
    status 200
    all_mirrors.to_json
end

# Create a new open source mirror
post '/mirrors' do
    data = JSON.parse(request.body.read)
    mirror = Mirror.create(data)
    status 201
    mirror.values.to_json
end

# Get a specific open source mirror
get '/mirror/:id' do
    mirror = Mirror[params[:id]]
    halt 404 if mirror.nil?
    mirror.values.to_json
end

# Update a specific open source mirror
put '/mirror/:id' do
    mirror = Mirror[params[:id]]
    halt 404 if mirror.nil?
    data = JSON.parse(request.body.read)
    mirror.update(data)
    status 200
    mirror.values.to_json
end

# Delete a specific open source mirror
delete '/mirror/:id' do
    mirror = Mirror[params[:id]]
    halt 404 if mirror.nil?
    mirror.delete
    status 204
end

path_yaml = <<-CONFIG
  /mirrors:
    get:
      summary: Get all mirrors
      operationId: getMirrors
      responses:
        '200':
          description: A list of mirrors
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/Mirror'
    post:
      summary: Create a new mirror
      operationId: createMirror
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/Mirror'
      responses:
        '201':
          description: Mirror created
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Mirror'
  /mirror/{id}:
    get:
      summary: Get a mirror by ID
      operationId: getMirrorById
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
      responses:
        '200':
          description: A mirror
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Mirror'
    put:
      summary: Update a mirror by ID
      operationId: updateMirrorById
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
              $ref: '#/components/schemas/Mirror'
      responses:
        '200':
          description: Mirror updated
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Mirror'
    delete:
      summary: Delete a mirror by ID
      operationId: deleteMirrorById
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
      responses:
        '204':
          description: Mirror deleted
CONFIG

APIConfig.add_path(path_yaml)

componet_yaml = <<-CONFIG
    Mirror:
      type: object
      properties:
        id:
            type: integer
            readOnly: true
        type:
            type: string
        language:
            type: string
        website:
            type: string
        supportTool:
            type: string
      required:
        - type
        - language
        - website
CONFIG

APIConfig.add_component(componet_yaml)