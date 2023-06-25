=begin
CREATE TABLE tag (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255),
    repo VARCHAR(255),
    commitId VARCHAR(255),
    zipballUrl VARCHAR(255),
    tarballUrl VARCHAR(255)
);
=end
 
# List all open source tags
get '/tags' do  
    page = params['page']
    if page
        page = page.to_i
        all_tags = Tag.all[(page-1)*10..page*10-1].collect { |t|
           t.values
        }
    else
        all_tags = Tag.all.collect { |t|
            t.values
        }
    end
    status 200
    all_tags.to_json
end

# Create a new open source tag
post '/tags' do
    data = JSON.parse(request.body.read)
    tag = Tag.create(data)
    status 201
    tag.values.to_json
end

# Get a specific open source tag
get '/tag/:id' do
    tag = Tag[params[:id]]
    halt 404 if tag.nil?
    tag.values.to_json
end

# Update a specific open source tag
put '/tag/:id' do
    tag = Tag[params[:id]]
    halt 404 if tag.nil?
    data = JSON.parse(request.body.read)
    tag.update(data)
    status 200
    tag.values.to_json
end

# Delete a specific open source tag
delete '/tag/:id' do
    tag = Tag[params[:id]]
    halt 404 if tag.nil?
    tag.delete
    status 204
end

path_yaml = <<-CONFIG
  /tags:
    get:
      summary: Get all tags
      operationId: getTags
      parameters:
        - name: page
          in: query
          description: The page number to retrieve. Each page contains 10 items.
          schema:
            type: integer
      responses:
        '200':
          description: A list of tags
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/Tag'
    post:
      summary: Create a new tag
      operationId: createTag
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/Tag'
      responses:
        '201':
          description: Tag created
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Tag'
  /tag/{id}:
    get:
      summary: Get a tag by ID
      operationId: getTagById
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
      responses:
        '200':
          description: A tag
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Tag'
    put:
      summary: Update a tag by ID
      operationId: updateTagById
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
              $ref: '#/components/schemas/Tag'
      responses:
        '200':
          description: Tag updated
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Tag'
    delete:
      summary: Delete a tag by ID
      operationId: deleteTagById
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
      responses:
        '204':
          description: Tag deleted
CONFIG

APIConfig.add_path(path_yaml)

componet_yaml = <<-CONFIG
    Tag:
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
        zipballUrl:
            type: string
        tarballUrl:
            type: string
      required:
        - name
CONFIG

APIConfig.add_component(componet_yaml)