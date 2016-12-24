pixelsData = null

ready ->
  
  uploadArea = $('#upload_area')
  fileInput = $('#file_input')
  uploadedImageDetail = $('#uploaded_image_detail')
  canvas = $('#uploaded_image_detail canvas')[0]
  
  uploadArea
    .on 'dragover', (event) ->
      event.preventDefault()
      $(this).addClass 'dragover'
      
    .on 'dragleave', (event) ->
      event.preventDefault()
      $(this).removeClass 'dragover'
      
    .on 'drop', (event) ->
      event.preventDefault()
      $(this).removeClass 'dragover'
      
      if file = validateFiles event.originalEvent.dataTransfer.files
        displayImage(file, uploadedImageDetail, canvas)
        
  fileInput.on 'change', (event) ->
    if file = validateFiles this.files
      displayImage(file, uploadedImageDetail, canvas)
  
  $(canvas).on 'click', (event) ->
    rect = event.target.getBoundingClientRect()
    [x, y] = [event.clientX - rect.left, event.clientY - rect.top]
    getColorAtPixel(canvas, pixelsData, x, y)
      
validateFiles = (files) ->
  if !files || files.length == 0
    return false
  
  if files.length > 1
    console.log '単一のファイルを選択してください'
    return false
  
  if files[0].type.split('/')[0] != 'image'
    console.log '画像以外のファイルは無効です'
    return false
  
  return files[0]

displayImage = (file, detail, canvas) ->
  # load image
  fileReader = new FileReader()
  fileReader.readAsDataURL file
  fileReader.onload = ->
    image = new Image()
    image.onload = ->
      # show detail
      $(detail).css 'display', 'block'
      
      context = canvas.getContext('2d')
      
      # display image
      [canvas.width, canvas.height] = [400, 400]
      isLandscape = this.width >= this.height
      scale = if isLandscape then canvas.width / this.width else canvas.height / this.height
      context.drawImage(
        this,
        0,
        0,
        this.width,
        this.height,
        if isLandscape then 0 else (canvas.width - this.width * scale) / 2,
        if isLandscape then (canvas.height - this.height * scale) / 2 else 0,
        if isLandscape then canvas.width else this.width * scale,
        if isLandscape then this.height * scale else canvas.height
      )
      
      # save pixels data
      pixelsData = context.getImageData(0, 0, canvas.width, canvas.height).data
      
    image.src = fileReader.result

getColorAtPixel = (canvas, pixelsData, x, y) ->
  [x, y] = [Math.round x, Math.round y]
  base = (canvas.width * y + x) * 4
  alpha = pixelsData[base + 3]
  r = pixelsData[base + 0] + (255 - alpha)
  g = pixelsData[base + 1] + (255 - alpha)
  b = pixelsData[base + 2] + (255 - alpha)
  console.log "R: #{r}, G: #{g}, B: #{b}, A: #{alpha}"