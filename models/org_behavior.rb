=begin
CREATE TABLE orgBehavior (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    org_name VARCHAR(255),
    org_type VARCHAR(255),
    actionName VARCHAR(255),
    type VARCHAR(255),
    description VARCHAR(255),
    beginDate VARCHAR(255),
    endDate VARCHAR(255),
    extInfo TEXT
);
=end
 
# List all org behaviors
get '/orgBehaviors' do  
    page = params['page']
    if page
        page = page.to_i
        all_org_behaviors = OrgBehavior.all[(page-1)*10..page*10-1].collect { |p|
            p.values
        }
    else
        all_org_behaviors = OrgBehavior.all.collect { |p|
            p.values
        }
    end
    status 200
    all_org_behaviors.to_json
end

# Create a new org behavior
post '/orgBehaviors' do
    data = JSON.parse(request.body.read)
    org_behavior = OrgBehavior.create(data)
    status 201
    org_behavior.values.to_json
end

# Get a specific org behavior
get '/orgBehavior/:id' do
    org_behavior = OrgBehavior[params[:id]]
    halt 404 if org_behavior.nil?
    org_behavior.values.to_json
end

# Update a specific org behavior
put '/orgBehavior/:id' do
    org_behavior = OrgBehavior[params[:id]]
    halt 404 if org_behavior.nil?
    data = JSON.parse(request.body.read)
    org_behavior.update(data)
    status 200
    org_behavior.values.to_json
end

# Delete a specific org behavior
delete '/orgBehavior/:id' do
    org_behavior = OrgBehavior[params[:id]]
    halt 404 if org_behavior.nil?
    org_behavior.delete
    status 204
end

path_yaml = <<-CONFIG
  /orgBehaviors:
    get:
      summary: Get all org behaviors
      operationId: getOrgBehaviors
      parameters:
        - name: page
          in: query
          description: The page number to retrieve. Each page contains 10 items.
          schema:
            type: integer
      responses:
        '200':
          description: A list of org behaviors
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/OrgBehavior'
    post:
      summary: Create a new org behavior
      operationId: createOrgBehavior
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/OrgBehavior'
      responses:
        '201':
          description: Org behavior created
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/OrgBehavior'
  /orgBehavior/{id}:
    get:
      summary: Get a org behavior by ID
      operationId: getOrgBehaviorById
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
      responses:
        '200':
          description: A org behavior
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/OrgBehavior'
    put:
      summary: Update a org behavior by ID
      operationId: updateOrgBehaviorById
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
              $ref: '#/components/schemas/OrgBehavior'
      responses:
        '200':
          description: Org behavior updated
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/OrgBehavior'
    delete:
      summary: Delete a org behavior by ID
      operationId: deleteOrgBehaviorById
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
      responses:
        '204':
          description: Org behavior deleted
CONFIG

APIConfig.add_path(path_yaml)

componet_yaml = <<-CONFIG
    OrgBehavior:
      type: object
      properties:
        id:
            type: integer
            readOnly: true
        org_name:
            type: string
        org_type:
            type: string
        actionName:
            type: string
        type:
            type: string
        description:
            type: string
        beginDate:
            type: string
        endDate:
            type: string
        extInfo:
            type: string
      required:
        - org_name
        - actionName
        - type
        - beginDate
        - endDate
CONFIG

APIConfig.add_component(componet_yaml)