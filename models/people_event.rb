# List all People Events
get '/peopleEvents' do
    all_people_events = PeopleEvent.all.collect { |pe|
        pe.values
    }
    status 200
    all_people_events.to_json
end

# Create People Event
post '/peopleEvents' do
    data = JSON.parse(request.body.read)
    event = PeopleEvent.create(data)
    status 201
    event.values.to_json
end

# Read a specific people event
get '/peopleEvent/:id' do
    event = PeopleEvent[params[:id]]
    halt 404 if people.nil?
    event.values.to_json
end

# Update a specific people event
put '/peopleEvent/:id' do
    event = PeopleEvent[params[:id]]
    halt 404 if event.nil?
    data = JSON.parse(request.body.read)
    event.update(data)
    status 200
    event.values.to_json
end

# Delete a specific people event
delete '/peopleEvent/:id' do
    event = PeopleEvent[params[:id]]
    halt 404 if event.nil?
    event.delete
    status 204
end

path_yaml = <<-CONFIG
  /peopleEvents:
    get:
      summary: Get all people events
      operationId: getPeopleEvents
      responses:
        '200':
          description: A list of people events
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/PeopleEvent'
    post:
      summary: Create a new people event
      operationId: createPeopleEvent
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/PeopleEvent'
      responses:
        '201':
          description: Created
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/PeopleEvent'
  /peopleEvent/{id}:
    get:
      summary: Get a people event by ID
      operationId: getPeopleEventById
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
      responses:
        '200':
          description: A people event
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/PeopleEvent'
    put:
      summary: Update a people event by ID
      operationId: updatePeopleEventById
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
              $ref: '#/components/schemas/PeopleEvent'
      responses:
        '200':
          description: Updated
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/PeopleEvent'
    delete:
      summary: Delete a people event by ID
      operationId: deletePeopleEventById
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
    PeopleEvent:
      type: object
      properties:
        id:
          type: integer
          readOnly: true
        type:
          type: string
        actor:
          type: string
        project:
          type: string
        community:
          type: string
        issue_id:
          type: string
        extInfo:
          type: string
        devService:
          type: string
      required:
        - type
        - actor
CONFIG

APIConfig.add_component(componet_yaml)