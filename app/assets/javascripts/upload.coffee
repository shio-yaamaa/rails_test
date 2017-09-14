uploadArea = if uploadArea? then uploadArea else null
fileInput = if fileInput? then fileInput else null
colorPickerButton = if colorPickerButton? then colorPickerButton else null
uploadedImageDetail = if uploadedImageDetail? then uploadedImageDetail else null
validateError = if validateError? then validateError else null
canvas = if canvas? then canvas else null
context = if context? then context else null

colorInfo = if colorInfo? then colorInfo else null
colorSample = if colorSample? then colorSample else null
colorSampleText = if colorSampleText? then colorSampleText else null
colorTable = if colorTable? then colorTable else null

colorPickerImageSrc = if colorPickerImageSrc? then colorPickerImageSrc else null
uploadedImage = if uploadedImage? then uploadedImage else new Image()
drawImageParameters = if drawImageParameters? then drawImageParameters else null
pixelsData = null

COLOR_ELEMENTS = [
  {name: 'r', max: 255},
  {name: 'g', max: 255},
  {name: 'b', max: 255},
  {name: 'h', max: 360},
  {name: 's', max: 100},
  {name: 'v', max: 100}
]

LOCATION_MARKER_LENGTH = 15 # inner
LOCATION_MARKER_WIDTH = 1 # inner
LOCATION_MARKER_MARGIN = 2 # outer - inner

ready ->
  # todo: just for capture
  $('body').css('height', '2000px')
  
  uploadArea = $('#upload_area')
  fileInput = $('#file_input')
  colorPickerButton = $('#color_picker_button')
  uploadedImageDetail = $('#uploaded_image_detail')
  validateError = $('#upload_validate_error')
  canvas = $('#uploaded_image_detail canvas')[0]
  context = canvas.getContext('2d')
  
  # for updating color_info
  colorInfo = $('#color_info')
  colorSample = colorInfo.find('#color_sample')
  colorSampleText = colorInfo.find('#color_sample_text')
  colorTable = colorInfo.find('table')
  
  uploadedImage.onload = ->
    # show detail
    $(uploadedImageDetail).css 'display', 'block'
    
    # display image
    [canvas.width, canvas.height] = [400, 400]
    isLandscape = this.width >= this.height
    scale = if isLandscape then canvas.width / this.width else canvas.height / this.height
    drawImageParameters = [
      this,
      0,
      0,
      this.width,
      this.height,
      if isLandscape then 0 else (canvas.width - this.width * scale) / 2,
      if isLandscape then (canvas.height - this.height * scale) / 2 else 0,
      if isLandscape then canvas.width else this.width * scale,
      if isLandscape then this.height * scale else canvas.height
    ]
    context.drawImage( # todo: use spread operator if possible
      drawImageParameters[0],
      drawImageParameters[1], drawImageParameters[2], drawImageParameters[3], drawImageParameters[4],
      drawImageParameters[5], drawImageParameters[6], drawImageParameters[7], drawImageParameters[8]
    )
    
    # save pixels data
    pixelsData = context.getImageData(0, 0, canvas.width, canvas.height).data
  
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
    if file = validateFiles this.files
      displayImage(file, canvas)
  
  colorPickerButton.on 'click', (event) ->
    uploadedImage.src = 'assets/color_picker.png'
  
  $(canvas).on 'click', (event) ->
    rect = event.target.getBoundingClientRect()
    [x, y] = [event.clientX - rect.left, event.clientY - rect.top]
    ripple context, x, y, 0, 0.4
    rgbAtPixel = getRgbAtPixel canvas, pixelsData, x, y
    colorInfo.css 'display', 'block'
    updateColorInfo(
      rgb2hex(rgbAtPixel),
      nameThatColor(rgbAtPixel),
      rgbAtPixel,
      rgb2hsv(rgbAtPixel),
      darkLevel(rgbAtPixel)
    )
    $.get('upload/show_similar_hattoris', {rgb: rgbAtPixel})
      
validateFiles = (files) ->
  if !files || files.length == 0
    return false
  
  if files.length > 1
    toggleValidateError true, '単一のファイルを選択してください'
    return false
  
  if files[0].type.split('/')[0] != 'image'
    toggleValidateError true, '画像以外のファイルは無効です'
    return false
  
  toggleValidateError false, null
  return files[0]

toggleValidateError = (show, message) ->
  if show
    validateError.css('display', 'block').html(message)
  else
    validateError.css('display', 'none')

displayImage = (file, canvas) ->
  # load image
  fileReader = new FileReader()
  fileReader.readAsDataURL file
  fileReader.onload = ->
    uploadedImage.src = fileReader.result

displayImageAfterRipple = (context) ->
  #context.drawImage(drawImageParameters...)
  context.drawImage( # todo: use spread operator if possible
    drawImageParameters[0],
    drawImageParameters[1], drawImageParameters[2], drawImageParameters[3], drawImageParameters[4],
    drawImageParameters[5], drawImageParameters[6], drawImageParameters[7], drawImageParameters[8]
  )

getRgbAtPixel = (canvas, pixelsData, x, y) ->
  [x, y] = [Math.round(x), Math.round(y)]
  base = (canvas.width * y + x) * 4
  alpha = pixelsData[base + 3]
  [
    pixelsData[base + 0] + (255 - alpha),
    pixelsData[base + 1] + (255 - alpha),
    pixelsData[base + 2] + (255 - alpha)
  ]

updateColorInfo = (hex, color_name, rgb, hsv, dark_level) ->
  colorSample.css 'background-color', "##{hex}"
  colorSampleText.children().eq(0).text "##{hex.toUpperCase()}"
  colorSampleText.children().eq(1).text "#{color_name.name}" # todo: 「色名: 」はとりあえず外しただけ、あとでつける
  rgbhsv = rgb.concat hsv
  COLOR_ELEMENTS.forEach((element, index) ->
    colorTable
      .find("##{element['name']}_bar")
      .css('width', "#{rgbhsv[index] * 100.0 / element['max']}%")
      .parent()
      .next()
      .text rgbhsv[index]
  )
  colorTable.find('#dark_level_bar')
    .css('width', "#{dark_level}%")
    .parent().next().text dark_level.toFixed(2)

ripple = (context, x, y, radius, opacity) ->
  # show the image
  displayImageAfterRipple context
  
  # draw ripple circle
  context.beginPath()
  context.arc x, y, radius, 0, 2 * Math.PI
  context.fillStyle = 'rgba(255, 255, 255, ' + opacity + ')'
  context.fill()
  
  # draw location marker
  # outer (white)
  context.beginPath()
  context.rect( # horizontal
    x - LOCATION_MARKER_LENGTH / 2 - LOCATION_MARKER_MARGIN, y - LOCATION_MARKER_WIDTH / 2 - LOCATION_MARKER_MARGIN,
    LOCATION_MARKER_LENGTH + LOCATION_MARKER_MARGIN * 2, LOCATION_MARKER_WIDTH + LOCATION_MARKER_MARGIN * 2
  )
  context.rect( # vertical
    x - LOCATION_MARKER_WIDTH / 2 - LOCATION_MARKER_MARGIN, y - LOCATION_MARKER_LENGTH / 2 - LOCATION_MARKER_MARGIN,
    LOCATION_MARKER_WIDTH + LOCATION_MARKER_MARGIN * 2, LOCATION_MARKER_LENGTH + LOCATION_MARKER_MARGIN * 2
  )
  context.fillStyle = 'white'
  context.fill()
  # inner (black)
  context.beginPath()
  context.rect( # horizontal
    x - LOCATION_MARKER_LENGTH / 2, y - LOCATION_MARKER_WIDTH / 2,
    LOCATION_MARKER_LENGTH, LOCATION_MARKER_WIDTH
  )
  context.rect( # vertical
    x - LOCATION_MARKER_WIDTH / 2, y - LOCATION_MARKER_LENGTH / 2,
    LOCATION_MARKER_WIDTH, LOCATION_MARKER_LENGTH
  )
  context.fillStyle = 'black'
  context.fill()
  
  if opacity > 0
    setTimeout ripple, 20, context, x, y, radius + 10, if radius < 50 then opacity else opacity - 0.04