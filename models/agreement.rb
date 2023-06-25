=begin
CREATE TABLE agreement (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    identifier VARCHAR(255),
    type VARCHAR(255),
    name VARCHAR(255),
    text VARCHAR(255),
    url VARCHAR(255)
);
=end

# List all agreements
get '/agreements' do
    page = params['page']
    if page
      page = page.to_i
      all_agreements = Agreement.all[(page-1)*10..page*10-1].collect { |a|
        a.values
      }
    else
      all_agreements = Agreement.all.collect { |a|
          a.values
      }
    end
    status 200
    all_agreements.to_json
end

# Create a new agreement
post '/agreements' do
    data = JSON.parse(request.body.read)
    agreement = Agreement.create(data)
    status 201
    agreement.values.to_json
end

# Get a specific agreement
get '/agreement/:id' do
    agreement = Agreement[params[:id]]
    halt 404 if agreement.nil?
    agreement.values.to_json
end

# Update a specific agreement
put '/agreement/:id' do
    agreement = Agreement[params[:id]]
    halt 404 if agreement.nil?
    data = JSON.parse(request.body.read)
    agreement.update(data)
    status 200
    agreement.values.to_json
end

# Delete a specific agreement
delete '/agreement/:id' do
    agreement = Agreement[params[:id]]
    halt 404 if agreement.nil?
    agreement.delete
    status 204
end

path_yaml = <<-CONFIG
  /agreements:
    get:
      summary: Get all agreements
      operationId: getAgreements
      parameters:
        - name: page
          in: query
          description: The page number to retrieve. Each page contains 10 items.
          schema:
            type: integer
      responses:
        '200':
          description: A list of agreements
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/Agreement'
    post:
      summary: Create a new agreement
      operationId: createAgreement
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/Agreement'
      responses:
        '201':
          description: Agreement created
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Agreement'
  /agreement/{id}:
    get:
      summary: Get an agreement by ID
      operationId: getAgreementById
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
      responses:
        '200':
          description: An agreement
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Agreement'
    put:
      summary: Update an agreement by ID
      operationId: updateAgreementById
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
              $ref: '#/components/schemas/Agreement'
      responses:
        '200':
          description: Agreement updated
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Agreement'
    delete:
      summary: Delete an agreement by ID
      operationId: deleteAgreementById
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
      responses:
        '204':
          description: Agreement deleted
CONFIG

APIConfig.add_path(path_yaml)

componet_yaml = <<-CONFIG
    Agreement:
      type: object
      properties:
        id:
            type: integer
            readOnly: true
        identifier:
            type: string
        type:
            type: string
        name:
            type: string
        text:
            type: string
        url:
            type: string
      required:
        - identifier
        - type
        - name
        - text
        - url
CONFIG

APIConfig.add_component(componet_yaml)