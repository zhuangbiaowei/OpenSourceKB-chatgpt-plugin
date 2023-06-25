=begin
CREATE TABLE copyright (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    text VARCHAR(255),
    url VARCHAR(255)
);
=end
 
# List all open source copyrights
get '/copyrights' do  
    all_copyrights = Copyright.all.collect { |c|
        c.values
    }
    status 200
    all_copyrights.to_json
end

# Create a new open source copyright
post '/copyrights' do
    data = JSON.parse(request.body.read)
    copyright = Copyright.create(data)
    status 201
    copyright.values.to_json
end

# Get a specific open source copyright
get '/copyright/:id' do
    copyright = Copyright[params[:id]]
    halt 404 if copyright.nil?
    copyright.values.to_json
end

# Update a specific open source copyright
put '/copyright/:id' do
    copyright = Copyright[params[:id]]
    halt 404 if copyright.nil?
    data = JSON.parse(request.body.read)
    copyright.update(data)
    status 200
    copyright.values.to_json
end

# Delete a specific open source copyright
delete '/copyright/:id' do
    copyright = Copyright[params[:id]]
    halt 404 if copyright.nil?
    copyright.delete
    status 204
end

path_yaml = <<-CONFIG
  /copyrights:
    get:
      summary: Get all copyrights
      operationId: getCopyrights
      responses:
        '200':
          description: A list of copyrights
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/Copyright'
    post:
      summary: Create a new copyright
      operationId: createCopyright
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/Copyright'
      responses:
        '201':
          description: Copyright created
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Copyright'
  /copyright/{id}:
    get:
      summary: Get a copyright by ID
      operationId: getCopyrightById
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
      responses:
        '200':
          description: A copyright
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Copyright'
    put:
      summary: Update a copyright by ID
      operationId: updateCopyrightById
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
              $ref: '#/components/schemas/Copyright'
      responses:
        '200':
          description: Copyright updated
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Copyright'
    delete:
      summary: Delete a copyright by ID
      operationId: deleteCopyrightById
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
      responses:
        '204':
          description: Copyright deleted
CONFIG

APIConfig.add_path(path_yaml)

componet_yaml = <<-CONFIG
    Copyright:
      type: object
      properties:
        id:
            type: integer
            readOnly: true
        text:
            type: string
        url:
            type: string
      required:
        - text
CONFIG

APIConfig.add_component(componet_yaml)