# List all open source peoples
get '/peoples' do  
    all_peoples = People.all.collect { |p|
        p.values
    }
    status 200
    all_peoples.to_json
end

# Create a new open source people
post '/peoples' do
    data = JSON.parse(request.body.read)
    people = People.create(data)
    status 201
    people.values.to_json
end

# Get a specific open source people
get '/people/:id' do
    people = People[params[:id]]
    halt 404 if people.nil?
    people.values.to_json
end

# Update a specific open source people
put '/people/:id' do
    people = People[params[:id]]
    halt 404 if people.nil?
    data = JSON.parse(request.body.read)
    people.update(data)
    status 200
    people.values.to_json
end

# Delete a specific open source people
delete '/people/:id' do
    people = People[params[:id]]
    halt 404 if people.nil?
    people.delete
    status 204
end

path_yaml = <<-CONFIG
  /peoples:
    get:
      summary: Get all people
      operationId: getPeople
      responses:
        '200':
          description: A list of people
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/Person'
    post:
      summary: Create a new person
      operationId: createPerson
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/Person'
      responses:
        '201':
          description: Person created
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Person'
  /people/{id}:
    get:
      summary: Get a person by ID
      operationId: getPersonById
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
      responses:
        '200':
          description: A person
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Person'
    put:
      summary: Update a person by ID
      operationId: updatePersonById
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
              $ref: '#/components/schemas/Person'
      responses:
        '200':
          description: Person updated
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Person'
    delete:
      summary: Delete a person by ID
      operationId: deletePersonById
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
      responses:
        '204':
          description: Person deleted
CONFIG

APIConfig.add_path(path_yaml)

componet_yaml = <<-CONFIG
    Person:
      type: object
      properties:
        id:
            type: integer
            readOnly: true
        name:
            type: string
        nickname:
            type: string
        type:
            type: string
        email:
            type: string
        twitter:
            type: string
        facebook:
            type: string
        weixin:
            type: string
        QQ:
            type: string
        website:
            type: string
        blog:
            type: string
        sex:
            type: string
        country:
            type: string
        city:
            type: string
        company:
            type: string
        community:
            type: string
        project:
            type: string
        fundation:
            type: string
        devService:
            type: string
      required:
        - name
CONFIG

APIConfig.add_component(componet_yaml)