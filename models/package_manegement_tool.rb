=begin
CREATE TABLE packageManegementTool (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255),
    language VARCHAR(255),
    platform VARCHAR(255),
    website VARCHAR(255),
    project VARCHAR(255),
    packageFormat VARCHAR(255)
);
=end

 
# List all package management tools
get '/packageManagementTools' do  
    page = params['page']
    if page
        page = page.to_i
        all_tools = PackageManagementTool.all[(page-1)*10..page*10-1].collect { |t|
            t.values
        }
    else
        all_tools = PackageManagementTool.all.collect { |t|
            t.values
        }
    end
    status 200
    all_tools.to_json
end

# Create a new package management tool
post '/packageManagementTools' do
    data = JSON.parse(request.body.read)
    tool = PackageManagementTool.create(data)
    status 201
    tool.values.to_json
end

# Get a specific package management tool
get '/packageManagementTool/:id' do
    tool = PackageManagementTool[params[:id]]
    halt 404 if tool.nil?
    tool.values.to_json
end

# Update a specific package management tool
put '/packageManagementTool/:id' do
    tool = PackageManagementTool[params[:id]]
    halt 404 if tool.nil?
    data = JSON.parse(request.body.read)
    tool.update(data)
    status 200
    tool.values.to_json
end

# Delete a specific package management tool
delete '/packageManagementTool/:id' do
    tool = PackageManagementTool[params[:id]]
    halt 404 if tool.nil?
    tool.delete
    status 204
end

path_yaml = <<-CONFIG
  /packageManagementTools:
    get:
      summary: Get all package management tools
      operationId: getPackageManagementTools
      parameters:
        - name: page
          in: query
          description: The page number to retrieve. Each page contains 10 items.
          schema:
            type: integer
      responses:
        '200':
          description: A list of package management tools
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/PackageManagementTool'
    post:
      summary: Create a new package management tool
      operationId: createPackageManagementTool
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/PackageManagementTool'
      responses:
        '201':
          description: Package management tool created
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/PackageManagementTool'
  /packageManagementTool/{id}:
    get:
      summary: Get a package management tool by ID
      operationId: getPackageManagementToolById
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
      responses:
        '200':
          description: A package management tool
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/PackageManagementTool'
    put:
      summary: Update a package management tool by ID
      operationId: updatePackageManagementToolById
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
              $ref: '#/components/schemas/PackageManagementTool'
      responses:
        '200':
          description: Package management tool updated
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/PackageManagementTool'
    delete:
      summary: Delete a package management tool by ID
      operationId: deletePackageManagementToolById
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
      responses:
        '204':
          description: Package management tool deleted
CONFIG

APIConfig.add_path(path_yaml)

componet_yaml = <<-CONFIG
    PackageManagementTool:
      type: object
      properties:
        id:
            type: integer
            readOnly: true
        name:
            type: string
        language:
            type: string
        platform:
            type: string
        website:
            type: string
        project:
            type: string
        packageFormat:
            type: string
      required:
        - name
CONFIG

APIConfig.add_component(componet_yaml)