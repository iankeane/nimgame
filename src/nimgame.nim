import raylib

proc main() =
  # Initialization
  const screenWidth = 800
  const screenHeight = 450

  initWindow(screenWidth, screenHeight, "raylib [models] example - M3D model loading")

  # Define the camera to look into our 3d world
  var camera: Camera = Camera(
    position: Vector3(x: 1.5, y: 1.5, z: 1.5),  # Camera position
    target: Vector3(x: 0.0, y: 0.4, z: 0.0),    # Camera looking at point
    up: Vector3(x: 0.0, y: 1.0, z: 0.0),        # Camera up vector (rotation towards target)
    fovy: 45.0,                                 # Camera field-of-view Y
    projection: Perspective              # Camera projection type
  )

  let position = Vector3(x: 0.0, y: 0.0, z: 0.0)  # Set model position

  var modelFileName = "src/assets/cesium_man.m3d"
  var drawMesh = true
  var drawSkeleton = true
  var animPlaying = false

  # Load model
  var model = loadModel(modelFileName)

  # Load animations
  var animsCount = 0
  var animFrameCounter = int32(0)
  var animId = 0
  var anims = loadModelAnimations(modelFileName)

  disableCursor()  # Limit cursor to relative movement inside the window
  setTargetFPS(60) # Set our game to run at 60 frames-per-second

  # Main game loop
  while not windowShouldClose():
    # Update
    updateCamera(camera, FirstPerson)

    if animsCount > 0:
      # Play animation when spacebar is held down (or step one frame with N)
      if isKeyDown(Space) or isKeyPressed(N):
        inc animFrameCounter

        if animFrameCounter >= anims[animId].frameCount:
          animFrameCounter = 0

        updateModelAnimation(model, anims[animId], animFrameCounter)
        animPlaying = true

      # Select animation by pressing C
      if isKeyPressed(C):
        animFrameCounter = 0
        inc animId

        if animId >= animsCount:
          animId = 0
        updateModelAnimation(model, anims[animId], 0)
        animPlaying = true

    # Toggle skeleton drawing
    if isKeyPressed(B):
      drawSkeleton = not drawSkeleton

    # Toggle mesh drawing
    if isKeyPressed(M):
      drawMesh = not drawMesh

    # Draw
    beginDrawing()
    clearBackground(RAYWHITE)

    beginMode3D(camera)
    # Draw 3d model with texture
    if drawMesh:
      drawModel(model, position, 1.0, WHITE)

    # # Draw the animated skeleton
    # if drawSkeleton:
    #   for i in 0..<model.boneCount - 1:
    #     if not animPlaying or animsCount == 0:
    #       drawCube(model.bindPose[i].translation, 0.04, 0.04, 0.04, RED)
    #       if model.bones[i].parent >= 0:
    #         drawLine3D(model.bindPose[i].translation, model.bindPose[model.bones[i].parent].translation, RED)
    #     else:
    #       drawCube(anims[animId].framePoses[animFrameCounter][i].translation, 0.05, 0.05, 0.05, RED)
    #       if anims[animId].bones[i].parent >= 0:
    #         drawLine3D(anims[animId].framePoses[animFrameCounter][i].translation, anims[animId].framePoses[animFrameCounter][anims[animId].bones[i].parent].translation, RED)

    drawGrid(10, 1.0)
    endMode3D()

    drawText("PRESS SPACE to PLAY MODEL ANIMATION", 10, screenHeight - 80, 10, MAROON)
    drawText("PRESS N to STEP ONE ANIMATION FRAME", 10, screenHeight - 60, 10, DARKGRAY)
    drawText("PRESS C to CYCLE THROUGH ANIMATIONS", 10, screenHeight - 40, 10, DARKGRAY)
    drawText("PRESS M to toggle MESH, B to toggle SKELETON DRAWING", 10, screenHeight - 20, 10, DARKGRAY)
    drawText("(c) CesiumMan model by KhronosGroup", screenWidth - 210, screenHeight - 20, 10, GRAY)

    endDrawing()

  # De-Initialization
  # unloadModelAnimations(anims, animsCount)
  # unloadModel(model)
  closeWindow()

main()
