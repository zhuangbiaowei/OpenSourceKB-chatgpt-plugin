=begin
CREATE TABLE branch (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255),
    repo VARCHAR(255),
    commitId VARCHAR(255),
    protected VARCHAR(255)
);
=end

 
# List all open source branches
get '/branches' do
    page = params['page']
    if page
      page = page.to_i
      all_branches = Branch.all[(page-1)*10..page*10-1].collect { |b|
        b.values
      }
    else
      all_branches = Branch.all.collect { |b|
          b.values
      }
    end
    status 200
    all_branches.to_json
end

# Create a new open source branch
post '/branches' do
    data = JSON.parse(request.body.read)
    branch = Branch.create(data)
    status 201
    branch.values.to_json
end

# Get a specific open source branch
get '/branch/:id' do
    branch = Branch[params[:id]]
    halt 404 if branch.nil?
    branch.values.to_json
end

# Update a specific open source branch
put '/branch/:id' do
    branch = Branch[params[:id]]
    halt 404 if branch.nil?
    data = JSON.parse(request.body.read)
    branch.update(data)
    status 200
    branch.values.to_json
end

# Delete a specific open source branch
delete '/branch/:id' do
    branch = Branch[params[:id]]
    halt 404 if branch.nil?
    branch.delete
    status 204
end

path_yaml = <<-CONFIG
  /branches:
    get:
      summary: Get all branches
      operationId: getBranches
      parameters:
        - name: page
          in: query
          description: The page number to retrieve. Each page contains 10 items.
          schema:
            type: integer
      responses:
        '200':
          description: A list of branches
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/Branch'
    post:
      summary: Create a new branch
      operationId: createBranch
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/Branch'
      responses:
        '201':
          description: Branch created
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Branch'
  /branch/{id}:
    get:
      summary: Get a branch by ID
      operationId: getBranchById
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
      responses:
        '200':
          description: A branch
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Branch'
    put:
      summary: Update a branch by ID
      operationId: updateBranchById
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
              $ref: '#/components/schemas/Branch'
      responses:
        '200':
          description: Branch updated
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Branch'
    delete:
      summary: Delete a branch by ID
      operationId: deleteBranchById
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
      responses:
        '204':
          description: Branch deleted
CONFIG

APIConfig.add_path(path_yaml)

componet_yaml = <<-CONFIG
    Branch:
      type: object
      properties:
        id:
            type: integer
            readOnly: true
        name:
            type: string
        repo:
            type: string
        commitId:
            type: string
        protected:
            type: string
      required:
        - name
CONFIG

APIConfig.add_component(componet_yaml)

