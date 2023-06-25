=begin
CREATE TABLE CVE (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    CVEID VARCHAR(255),
    description VARCHAR(255),
    cvss2Score VARCHAR(255),
    cvss3Score VARCHAR(255),
    refs VARCHAR(255),
    cweList VARCHAR(255),
    cpe VARCHAR(255),
    published VARCHAR(255),
    modified VARCHAR(255),
    affectedPackages VARCHAR(255),
    affectedVersions VARCHAR(255)
);
=end

 
# List all CVEs
get '/cves' do  
    page = params['page']
    if page
        page = page.to_i
        all_cves = CVE.all[(page-1)*10..page*10-1].collect { |c|
            c.values
        }
    else
        all_cves = CVE.all.collect { |c|
            c.values
        }
    end
    status 200
    all_cves.to_json
end

# Create a new CVE
post '/cves' do
    data = JSON.parse(request.body.read)
    cve = CVE.create(data)
    status 201
    cve.values.to_json
end

# Get a specific CVE
get '/cve/:id' do
    cve = CVE[params[:id]]
    halt 404 if cve.nil?
    cve.values.to_json
end

# Update a specific CVE
put '/cve/:id' do
    cve = CVE[params[:id]]
    halt 404 if cve.nil?
    data = JSON.parse(request.body.read)
    cve.update(data)
    status 200
    cve.values.to_json
end

# Delete a specific CVE
delete '/cve/:id' do
    cve = CVE[params[:id]]
    halt 404 if cve.nil?
    cve.delete
    status 204
end

path_yaml = <<-CONFIG
  /cves:
    get:
      summary: Get all CVEs
      operationId: getCVEs
      parameters:
        - name: page
          in: query
          description: The page number to retrieve. Each page contains 10 items.
          schema:
            type: integer
      responses:
        '200':
          description: A list of CVEs
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/CVE'
    post:
      summary: Create a new CVE
      operationId: createCVE
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/CVE'
      responses:
        '201':
          description: CVE created
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/CVE'
  /cve/{id}:
    get:
      summary: Get a CVE by ID
      operationId: getCVEById
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
      responses:
        '200':
          description: A CVE
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/CVE'
    put:
      summary: Update a CVE by ID
      operationId: updateCVEById
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
              $ref: '#/components/schemas/CVE'
      responses:
        '200':
          description: CVE updated
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/CVE'
    delete:
      summary: Delete a CVE by ID
      operationId: deleteCVEById
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
      responses:
        '204':
          description: CVE deleted
CONFIG

APIConfig.add_path(path_yaml)

componet_yaml = <<-CONFIG
    CVE:
      type: object
      properties:
        id:
            type: integer
            readOnly: true
        CVEID:
            type: string
        description:
            type: string
        cvss2Score:
            type: string
        cvss3Score:
            type: string
        refs:
            type: string
        cweList:
            type: string
        cpe:
            type: string
        published:
            type: string
        modified:
            type: string
        affectedPackages:
            type: string
        affectedVersions:
            type: string
      required:
        - CVEID
        - description
CONFIG

APIConfig.add_component(componet_yaml)