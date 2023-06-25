=begin
CREATE TABLE community (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255),
    type VARCHAR(255),
    members VARCHAR(255),
    website VARCHAR(255),
    description VARCHAR(255),
    project VARCHAR(255),
    product VARCHAR(255),
    newsletter VARCHAR(255),
    blog VARCHAR(255),
    Media VARCHAR(255)
);
=end

# List all open source communities
get '/communities' do
    page = params['page']
    if page
        page = page.to_i
        all_communities = Community.all[(page-1)*10..page*10-1].collect { |c|
            c.values
        }
    else
        all_communities = Community.all.collect { |c|
            c.values
        }
    end
    status 200
    all_communities.to_json
end

# Create a new open source community
post '/communities' do
    data = JSON.parse(request.body.read)
    community = Community.create(data)
    status 201
    community.values.to_json
end

# Get a specific open source community
get '/community/:id' do
    community = Community[params[:id]]
    halt 404 if community.nil?
    community.values.to_json
end

# Update a specific open source community
put '/community/:id' do
    community = Community[params[:id]]
    halt 404 if community.nil?
    data = JSON.parse(request.body.read)
    community.update(data)
    status 200
    community.values.to_json
end

# Delete a specific open source community
delete '/community/:id' do
    community = Community[params[:id]]
    halt 404 if community.nil?
    community.delete
    status 204
end

path_yaml = <<-CONFIG
  /communities:
    get:
      summary: Get all communities
      operationId: getCommunities
      parameters:
        - name: page
          in: query
          description: The page number to retrieve. Each page contains 10 items.
          schema:
            type: integer
      responses:
        '200':
          description: A list of communities
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/Community'
    post:
      summary: Create a new community
      operationId: createCommunity
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/Community'
      responses:
        '201':
          description: Community created
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Community'
  /community/{id}:
    get:
      summary: Get a community by ID
      operationId: getCommunityById
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
      responses:
        '200':
          description: A community
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Community'
    put:
      summary: Update a community by ID
      operationId: updateCommunityById
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
              $ref: '#/components/schemas/Community'
      responses:
        '200':
          description: Community updated
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Community'
    delete:
      summary: Delete a community by ID
      operationId: deleteCommunityById
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
      responses:
        '204':
          description: Community deleted
CONFIG

APIConfig.add_path(path_yaml)

componet_yaml = <<-CONFIG
    Community:
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
        project:
            type: string
        product:
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