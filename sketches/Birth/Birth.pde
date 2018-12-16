int n_horiz = 1;
int n_verti = 1;

ArrayList<PShader> voronoiShaders = new ArrayList<PShader>();
PGraphics buffer;
int[] palette = new int[]{0xFFE28413, 0xFFF56416, 0xFFDD4B1A, 0xFFEF271B, 0xFFEA1744};

int devScale = 8;
float finalW = 77;
float finalH = 13;
float w, h;

void settings() {
  size(int(finalW * devScale), int(finalH * devScale), P2D);
}
void setup() {
  w = finalW;
  h = finalH;


  buffer = createGraphics(width, height, P2D);
  background(255);
  colorMode(HSB, 1., 1., 1.);

  for (int s = 0; s < n_horiz * n_verti; s++) {
    PShader voronoiShader = loadShader("voronoi.frag");
    voronoiShader.set("iResolution", float(width), float(height));
    voronoiShaders.add(voronoiShader);
  }
}

void draw() {

  int i = 0;
  PShader voronoiShader = voronoiShaders.get(0);
  voronoiShader.set("iTime", (noise(i*24554)*1000 + millis()) / 5000.0);
  voronoiShader.set("n_points", 40.);
  voronoiShader.set("fillRate", 1. );
  int _c =  palette[2];
  //R,G,B with bit shifting
  voronoiShader.set("baseColor", float( _c >> 16 & 0xFF)/255, float(_c >> 8 & 0xFF)/255, float( _c & 0xFF)/255);

  buffer.filter(voronoiShader);
  image(buffer, 0, 0);
}
