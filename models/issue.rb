=begin
CREATE TABLE issue (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title VARCHAR(255),
    description VARCHAR(255),
    refs VARCHAR(255),
    created VARCHAR(255),
    modified VARCHAR(255),
    product VARCHAR(255),
    project VARCHAR(255),
    version VARCHAR(255)
);
=end

 
# List all open source issues
get '/issues' do  
    all_issues = Issue.all.collect { |i|
        i.values
    }
    status 200
    all_issues.to_json
end

# Create a new open source issue
post '/issues' do
    data = JSON.parse(request.body.read)
    issue = Issue.create(data)
    status 201
    issue.values.to_json
end

# Get a specific open source issue
get '/issue/:id' do
    issue = Issue[params[:id]]
    halt 404 if issue.nil?
    issue.values.to_json
end

# Update a specific open source issue
put '/issue/:id' do
    issue = Issue[params[:id]]
    halt 404 if issue.nil?
    data = JSON.parse(request.body.read)
    issue.update(data)
    status 200
    issue.values.to_json
end

# Delete a specific open source issue
delete '/issue/:id' do
    issue = Issue[params[:id]]
    halt 404 if issue.nil?
    issue.delete
    status 204
end

path_yaml = <<-CONFIG
  /issues:
    get:
      summary: Get all issues
      operationId: getIssues
      responses:
        '200':
          description: A list of issues
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/Issue'
    post:
      summary: Create a new issue
      operationId: createIssue
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/Issue'
      responses:
        '201':
          description: Issue created
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Issue'
  /issue/{id}:
    get:
      summary: Get an issue by ID
      operationId: getIssueById
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
      responses:
        '200':
          description: An issue
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Issue'
    put:
      summary: Update an issue by ID
      operationId: updateIssueById
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
              $ref: '#/components/schemas/Issue'
      responses:
        '200':
          description: Issue updated
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Issue'
    delete:
      summary: Delete an issue by ID
      operationId: deleteIssueById
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
      responses:
        '204':
          description: Issue deleted
CONFIG

APIConfig.add_path(path_yaml)

componet_yaml = <<-CONFIG
    Issue:
      type: object
      properties:
        id:
            type: integer
            readOnly: true
        title:
            type: string
        description:
            type: string
        refs:
            type: string
        created:
            type: string
        modified:
            type: string
        product:
            type: string
        project:
            type: string
        version:
            type: string
      required:
        - title
CONFIG

APIConfig.add_component(componet_yaml)

