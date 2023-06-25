=begin
CREATE TABLE patent (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title VARCHAR(255),
    application_no VARCHAR(255),
    publication_date VARCHAR(255),
    country VARCHAR(255),
    url VARCHAR(255)
);
=end

 
# List all patents
get '/patents' do  
    page = params['page']
    if page
        page = page.to_i
        all_patents = Patent.all[(page-1)*10..page*10-1].collect { |p|
            p.values
        }
    else
        all_patents = Patent.all.collect { |p|
            p.values
        }
    end
    status 200
    all_patents.to_json
end

# Create a new patent
post '/patents' do
    data = JSON.parse(request.body.read)
    patent = Patent.create(data)
    status 201
    patent.values.to_json
end

# Get a specific patent
get '/patent/:id' do
    patent = Patent[params[:id]]
    halt 404 if patent.nil?
    patent.values.to_json
end

# Update a specific patent
put '/patent/:id' do
    patent = Patent[params[:id]]
    halt 404 if patent.nil?
    data = JSON.parse(request.body.read)
    patent.update(data)
    status 200
    patent.values.to_json
end

# Delete a specific patent
delete '/patent/:id' do
    patent = Patent[params[:id]]
    halt 404 if patent.nil?
    patent.delete
    status 204
end

path_yaml = <<-CONFIG
  /patents:
    get:
      summary: Get all patents
      operationId: getPatents
      parameters:
        - name: page
          in: query
          description: The page number to retrieve. Each page contains 10 items.
          schema:
            type: integer
      responses:
        '200':
          description: A list of patents
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/Patent'
    post:
      summary: Create a new patent
      operationId: createPatent
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/Patent'
      responses:
        '201':
          description: Patent created
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Patent'
  /patent/{id}:
    get:
      summary: Get a patent by ID
      operationId: getPatentById
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
      responses:
        '200':
          description: A patent
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Patent'
    put:
      summary: Update a patent by ID
      operationId: updatePatentById
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
              $ref: '#/components/schemas/Patent'
      responses:
        '200':
          description: Patent updated
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Patent'
    delete:
      summary: Delete a patent by ID
      operationId: deletePatentById
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
      responses:
        '204':
          description: Patent deleted
CONFIG

APIConfig.add_path(path_yaml)

componet_yaml = <<-CONFIG
    Patent:
      type: object
      properties:
        id:
            type: integer
            readOnly: true
        title:
            type: string
        application_no:
            type: string
        publication_date:
            type: string
        country:
            type: string
        url:
            type: string
      required:
        - title
        - application_no
        - publication_date
        - country
        - url
CONFIG

APIConfig.add_component(componet_yaml)


