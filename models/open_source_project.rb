# List all open source projects
get '/openSourceProjects' do
  page = params['page']
  if page
    page = page.to_i
    all_projects = OpenSourceProject.all[(page-1)*10..page*10-1].collect { |p|
      p.values
    }
  else
    all_projects = OpenSourceProject.all.collect { |p|
      p.values
    }
  end
  status 200
  all_projects.to_json
end

# List all open source projects
get '/openSourceProjects/count' do  
  status 200
  OpenSourceProject.all.count.to_json
end

# Create a new open source project
post '/openSourceProjects' do
  data = JSON.parse(request.body.read)
  project = OpenSourceProject.create(data)
  status 201
  project.values.to_json
end

# Get a specific open source project
get '/openSourceProject/:id' do
  project = OpenSourceProject[params[:id]]
  halt 404 if project.nil?
  project.values.to_json
end

# Update a specific open source project
put '/openSourceProject/:id' do
  project = OpenSourceProject[params[:id]]
  halt 404 if project.nil?
  data = JSON.parse(request.body.read)
  project.update(data)
  status 200
  project.values.to_json
end

# Delete a specific open source project
delete '/openSourceProject/:id' do
  project = OpenSourceProject[params[:id]]
  halt 404 if project.nil?
  project.delete
  status 204
end


path_yaml = <<-CONFIG
  /openSourceProjects:
    get:
      summary: Get all open source projects
      operationId: getOpenSourceProjects
      parameters:
        - name: page
          in: query
          description: The page number to retrieve. Each page contains 10 items.
          schema:
            type: integer
      responses:
        '200':
          description: A list of open source projects
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/OpenSourceProject'
    post:
      summary: Create a new open source project
      operationId: createOpenSourceProject
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/OpenSourceProject'
      responses:
        '201':
          description: Created
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/OpenSourceProject'
  /openSourceProjects/count:
    get:
      summary: Get the total number of open source projects
      operationId: getOpenSourceProjectsCount
      responses:
        '200':
          description: The total number of open source projects
          content:
              application/json:
                schema:
                  type: int        
  /openSourceProject/{id}:
    get:
      summary: Get an open source project by ID
      operationId: getOpenSourceProjectById
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
      responses:
        '200':
          description: An open source project
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/OpenSourceProject'
    put:
      summary: Update an open source project by ID
      operationId: updateOpenSourceProjectById
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
              $ref: '#/components/schemas/OpenSourceProject'
      responses:
        '200':
          description: Updated
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/OpenSourceProject'
    delete:
      summary: Delete an open source project by ID
      operationId: deleteOpenSourceProjectById
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
      responses:
        '204':
          description: Deleted
CONFIG

APIConfig.add_path(path_yaml)

componet_yaml = <<-CONFIG
    OpenSourceProject:
      type: object
      properties:
        id:
          type: integer
          readOnly: true
        name:
          type: string
        description:
          type: string
        website:
          type: string
        product:
          type: string
        community:
          type: string
        foundation:
          type: string
        member:
          type: string
        history:
          type: string
        devService:
          type: string
        bugTracker:
          type: string
        wiki:
          type: string
        source:
          type: string
        mailingList:
          type: string
        forum:
          type: string
        agreement:
          type: string
CONFIG

APIConfig.add_component(componet_yaml)