=begin
CREATE TABLE openSourceProduct (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255),
    type VARCHAR(255),
    description VARCHAR(255),
    authors VARCHAR(255),
    publisher VARCHAR(255),
    website VARCHAR(255),
    downloadUrl VARCHAR(255),
    components VARCHAR(255),
    language VARCHAR(255),
    project VARCHAR(255)
);
=end

# List all open source products
get '/openSourceProducts' do  
    all_products = OpenSourceProduct.all.collect { |p|
        p.values
    }
    status 200
    all_products.to_json
end

# Create a new open source product
post '/openSourceProducts' do
    data = JSON.parse(request.body.read)
    product = OpenSourceProduct.create(data)
    status 201
    product.values.to_json
end

# Get a specific open source product
get '/openSourceProduct/:id' do
    product = OpenSourceProduct[params[:id]]
    halt 404 if product.nil?
    product.values.to_json
end

# Update a specific open source product
put '/openSourceProduct/:id' do
    product = OpenSourceProduct[params[:id]]
    halt 404 if product.nil?
    data = JSON.parse(request.body.read)
    product.update(data)
    status 200
    product.values.to_json
end

# Delete a specific open source product
delete '/openSourceProduct/:id' do
    product = OpenSourceProduct[params[:id]]
    halt 404 if product.nil?
    product.delete
    status 204
end

path_yaml = <<-CONFIG
  /openSourceProducts:
    get:
      summary: Get all products
      operationId: getProducts
      responses:
        '200':
          description: A list of products
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/OpenSourceProduct'
    post:
      summary: Create a new product
      operationId: createProduct
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/OpenSourceProduct'
      responses:
        '201':
          description: Product created
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/OpenSourceProduct'
  /openSourceProduct/{id}:
    get:
      summary: Get a product by ID
      operationId: getProductById
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
      responses:
        '200':
          description: A product
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/OpenSourceProduct'
    put:
      summary: Update a product by ID
      operationId: updateProductById
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
              $ref: '#/components/schemas/OpenSourceProduct'
      responses:
        '200':
          description: Product updated
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/OpenSourceProduct'
    delete:
      summary: Delete a product by ID
      operationId: deleteProductById
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
      responses:
        '204':
          description: Product deleted
CONFIG

APIConfig.add_path(path_yaml)

componet_yaml = <<-CONFIG
    OpenSourceProduct:
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
        authors:
            type: string
        publisher:
            type: string
        website:
            type: string
        downloadUrl:
            type: string
        components:
            type: string
        language:
            type: string
        project:
            type: string
      required:
        - name
CONFIG

APIConfig.add_component(componet_yaml)
