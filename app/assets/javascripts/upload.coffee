ready ->
  
  uploadArea = $('#upload_area')
  fileInput = $('#file_input')
  canvas = $('#select_pixel canvas')[0]
  
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
        displayImage(file, canvas)
        
  fileInput.on 'change', (event) ->
    console.log 'file selected'
    if file = validateFiles this.files
      displayImage(file, canvas)
      
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

displayImage = (file, canvas) ->
  # load image
  fileReader = new FileReader()
  fileReader.readAsDataURL file
  fileReader.onload = ->
    image = new Image()
    image.onload = ->
      # display image
      $(canvas).css 'display', 'block'
      [canvas.width, canvas.height] = [400, 400] #[image.width, image.height]
      isLandscape = this.width >= this.height
      scale = if isLandscape then canvas.width / this.width else canvas.height / this.height
      canvas.getContext('2d').drawImage(
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
    image.src = fileReader.result