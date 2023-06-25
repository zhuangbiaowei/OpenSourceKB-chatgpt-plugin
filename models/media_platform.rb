=begin
CREATE TABLE mediaPlatform (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255),
    type VARCHAR(255),
    description VARCHAR(255),
    website VARCHAR(255)
);
=end
 
# List all media platforms
get '/mediaPlatforms' do  
    page = params['page']
    if page
        page = page.to_i
        all_media_platforms = MediaPlatform.all[(page-1)*10..page*10-1].collect { |mp|
            mp.values
        }
    else
        all_media_platforms = MediaPlatform.all.collect { |mp|
            mp.values
        }
    end
    status 200
    all_media_platforms.to_json
end

# Create a new media platform
post '/mediaPlatforms' do
    data = JSON.parse(request.body.read)
    media_platform = MediaPlatform.create(data)
    status 201
    media_platform.values.to_json
end

# Get a specific media platform
get '/mediaPlatform/:id' do
    media_platform = MediaPlatform[params[:id]]
    halt 404 if media_platform.nil?
    media_platform.values.to_json
end

# Update a specific media platform
put '/mediaPlatform/:id' do
    media_platform = MediaPlatform[params[:id]]
    halt 404 if media_platform.nil?
    data = JSON.parse(request.body.read)
    media_platform.update(data)
    status 200
    media_platform.values.to_json
end

# Delete a specific media platform
delete '/mediaPlatform/:id' do
    media_platform = MediaPlatform[params[:id]]
    halt 404 if media_platform.nil?
    media_platform.delete
    status 204
end

path_yaml = <<-CONFIG
  /mediaPlatforms:
    get:
      summary: Get all media platforms
      operationId: getMediaPlatforms
      parameters:
        - name: page
          in: query
          description: The page number to retrieve. Each page contains 10 items.
          schema:
            type: integer
      responses:
        '200':
          description: A list of media platforms
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/MediaPlatform'
    post:
      summary: Create a new media platform
      operationId: createMediaPlatform
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/MediaPlatform'
      responses:
        '201':
          description: Media platform created
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/MediaPlatform'
  /mediaPlatform/{id}:
    get:
      summary: Get a media platform by ID
      operationId: getMediaPlatformById
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
      responses:
        '200':
          description: A media platform
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/MediaPlatform'
    put:
      summary: Update a media platform by ID
      operationId: updateMediaPlatformById
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
              $ref: '#/components/schemas/MediaPlatform'
      responses:
        '200':
          description: Media platform updated
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/MediaPlatform'
    delete:
      summary: Delete a media platform by ID
      operationId: deleteMediaPlatformById
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
      responses:
        '204':
          description: Media platform deleted
CONFIG

APIConfig.add_path(path_yaml)

componet_yaml = <<-CONFIG
    MediaPlatform:
      type: object
      properties:
        id:
            type: integer
            readOnly: true
        name:
            type: string
        type:
            type: string
        description:
            type: string
        website:
            type: string
      required:
        - name
CONFIG

APIConfig.add_component(componet_yaml)