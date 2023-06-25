=begin
CREATE TABLE foundation (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255),
    type VARCHAR(255),
    members VARCHAR(255),
    website VARCHAR(255),
    description VARCHAR(255),
    projects VARCHAR(255),
    products VARCHAR(255),
    newsletter VARCHAR(255),
    blog VARCHAR(255),
    Media VARCHAR(255)
);
=end

# List all open source foundations
get '/foundations' do  
    page = params['page']
    if page
        page = page.to_i
        all_foundations = Foundation.all[(page-1)*10..page*10-1].collect { |f|
            f.values
        }
    else
        all_foundations = Foundation.all.collect { |f|
            f.values
        }
    end
    status 200
    all_foundations.to_json
end

# Create a new open source foundation
post '/foundations' do
    data = JSON.parse(request.body.read)
    foundation = Foundation.create(data)
    status 201
    foundation.values.to_json
end

# Get a specific open source foundation
get '/foundation/:id' do
    foundation = Foundation[params[:id]]
    halt 404 if foundation.nil?
    foundation.values.to_json
end

# Update a specific open source foundation
put '/foundation/:id' do
    foundation = Foundation[params[:id]]
    halt 404 if foundation.nil?
    data = JSON.parse(request.body.read)
    foundation.update(data)
    status 200
    foundation.values.to_json
end

# Delete a specific open source foundation
delete '/foundation/:id' do
    foundation = Foundation[params[:id]]
    halt 404 if foundation.nil?
    foundation.delete
    status 204
end

path_yaml = <<-CONFIG
  /foundations:
    get:
      summary: Get all foundations
      operationId: getFoundations
      parameters:
        - name: page
          in: query
          description: The page number to retrieve. Each page contains 10 items.
          schema:
            type: integer
      responses:
        '200':
          description: A list of foundations
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/Foundation'
    post:
      summary: Create a new foundation
      operationId: createFoundation
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/Foundation'
      responses:
        '201':
          description: Foundation created
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Foundation'
  /foundation/{id}:
    get:
      summary: Get a foundation by ID
      operationId: getFoundationById
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
      responses:
        '200':
          description: A foundation
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Foundation'
    put:
      summary: Update a foundation by ID
      operationId: updateFoundationById
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
              $ref: '#/components/schemas/Foundation'
      responses:
        '200':
          description: Foundation updated
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Foundation'
    delete:
      summary: Delete a foundation by ID
      operationId: deleteFoundationById
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
      responses:
        '204':
          description: Foundation deleted
CONFIG

APIConfig.add_path(path_yaml)

componet_yaml = <<-CONFIG
    Foundation:
      type: object
      properties:
        id:
            type: integer
            readOnly: true
        name:
            type: string
        type:
            type: string
        members:
            type: string
        website:
            type: string
        description:
            type: string
        projects:
            type: string
        products:
            type: string
        newsletter:
            type: string
        blog:
            type: string
        Media:
            type: string
      required:
        - name
CONFIG

APIConfig.add_component(componet_yaml)