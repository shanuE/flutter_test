uniform shader content;

half4 main(float2 fragCoord) {
  half4 color = content.eval(fragCoord);
  return half4(1.0 - color.rgb, color.a);
}
