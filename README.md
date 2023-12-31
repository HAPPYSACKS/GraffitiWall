# GraffitiWall

## Introduction
The Virtual Graffiti Wall app is an innovative augmented reality (AR) application that allows users to create, share, and view virtual graffiti in real-world locations. Using ARKit, this app overlays digital artwork onto physical surfaces, fostering a unique form of creative expression and community interaction.
## Features
- **AR Image Placement**: Users can select from a range of images and place them onto vertical surfaces in the real world.
- **Dynamic Image Selection**: A grid view UI for selecting different images to place in the AR scene.
- **Real-time AR Interaction**: Utilizes ARKit for real-time plane detection and image anchoring in the user's environment.
- **AR Graffiti Creation: Users can create digital graffiti and place it on real-world surfaces.
- **Location-Based Artwork: Graffiti is anchored to specific locations, viewable by others passing by.
- **Community Interaction: Users can view, add to, or modify existing virtual graffiti, enhancing community engagement.

## Installation
To install GraffitiWall, clone the repository and open the project in Xcode:

```bash
git clone https://github.com/your-username/GraffitiWall.git
cd GraffitiWall
open GraffitiWall.xcodeproj
```

## Important
- The AR is unrefined and akward. It needs a bit of calibration, so you need to explore the surroundings a little bit and be in a well-lit area. 

- Debug mode is on by default. If you want to remove the green and blue lines comment out this line of code `self.debugOptions = [.showFeaturePoints, .showWorldOrigin, .showAnchorGeometry]` which can be found in `CustomARView.swift`.

## Adding Images
- Have the folder navigator thingy out and have all the folders expanded.
- Click on `Assets`
- At the bottom of the image list, there should be a `+` icon. Click on this icon
- Click import and import your desired image.
- Then goto the `ImageSelectionViewModel.swift` file and add the image's name without the file extension. (ex. krabs.png -> krabs)
- Make sure to use a png file because jpg files can't support transparency.
