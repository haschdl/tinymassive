

## Generating video

```bash
ffmpeg -framerate 30 -i "frames/%04d.png" -c:v libx264 -profile:v main -filter:v "crop=78:14:-1:-1" -pix_fmt yuv420p out.mp4
```



With audio:

```bash
ffmpeg -framerate 30 -i "frames/%04d.png" -itsoffset 10 -i data/background.mp3  -c:v libx264 -profile:v main -filter:v "crop=78:14:-1:-1" -pix_fmt yuv420p out.mp4
```





