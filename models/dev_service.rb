=begin
CREATE TABLE devService (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255),
    type VARCHAR(255),
    country VARCHAR(255),
    website VARCHAR(255),
    supportPackageFormat VARCHAR(255),
    extInfo TEXT
);
=end

 
# List all dev services
get '/devServices' do  
    page = params['page']
    if page
        page = page.to_i
        all_devServices = DevService.all[(page-1)*10..page*10-1].collect { |a|
           a.values
        }
    else
        all_devServices = DevService.all.collect { |a|
           a.values
        }
    end
    status 200
    all_devServices.to_json
end

# Create a new dev service
post '/devServices' do
    data = JSON.parse(request.body.read)
    devService = DevService.create(data)
    status 201
    devService.values.to_json
end

# Get a specific dev service
get '/devService/:id' do
    devService = DevService[params[:id]]
    halt 404 if devService.nil?
    devService.values.to_json
end

# Update a specific dev service
put '/devService/:id' do
    devService = DevService[params[:id]]
    halt 404 if devService.nil?
    data = JSON.parse(request.body.read)
    devService.update(data)
    status 200
    devService.values.to_json
end

# Delete a specific dev service
delete '/devService/:id' do
    devService = DevService[params[:id]]
    halt 404 if devService.nil?
    devService.delete
    status 204
end

path_yaml = <<-CONFIG
  /devServices:
    get:
      summary: Get all dev services
      operationId: getDevServices
      parameters:
        - name: page
          in: query
          description: The page number to retrieve. Each page contains 10 items.
          schema:
            type: integer
      responses:
        '200':
          description: A list of dev services
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/DevService'
    post:
      summary: Create a new dev service
      operationId: createDevService
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/DevService'
      responses:
        '201':
          description: Dev service created
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/DevService'
  /devService/{id}:
    get:
      summary: Get a dev service by ID
      operationId: getDevServiceById
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
      responses:
        '200':
          description: A dev service
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/DevService'
    put:
      summary: Update a dev service by ID
      operationId: updateDevServiceById
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
              $ref: '#/components/schemas/DevService'
      responses:
        '200':
          description: Dev service updated
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/DevService'
    delete:
      summary: Delete a dev service by ID
      operationId: deleteDevServiceById
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
      responses:
        '204':
          description: Dev service deleted
CONFIG

APIConfig.add_path(path_yaml)

componet_yaml = <<-CONFIG
    DevService:
      type: object
      properties:
        id:
            type: integer
            readOnly: true
        name:
            type: string
        type:
            type: string
        country:
            type: string
        website:
            type: string
        supportPackageFormat:
            type: string
        extInfo:
            type: string
      required:
        - name
CONFIG

APIConfig.add_component(componet_yaml)