/*
 *      Copyright (C) 2010-2013 Team XBMC
 *      http://xbmc.org
 *
 *  This Program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2, or (at your option)
 *  any later version.
 *
 *  This Program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with XBMC; see the file COPYING.  If not, see
 *  <http://www.gnu.org/licenses/>.
 *
 */

#extension GL_OES_EGL_image_external : require

precision highp float;
uniform samplerExternalOES m_samp0;
uniform samplerExternalOES m_samp1;
varying vec4      m_cord0;
varying vec4      m_cord1;
varying lowp vec4 m_colour;
uniform int       m_method;
uniform int       m_field;
uniform float     m_step;

void main ()
{
  vec2 source;
  source = m_cord0.xy;
  
  float temp1 = mod(source.y, 2.0*m_step);
  float temp2 = source.y - temp1;
  source.y = temp2 + m_step/2.0 - float(m_field)*m_step;
  
  if (temp1 > m_step)
  {
    // Blend missing line
    vec2 above, below;
    above.x = source.x;
    above.y = source.y;
    below.x = source.x;
    below.y = source.y + 2.0*m_step;

    gl_FragColor.rgba = texture2D(m_samp0, above).rgba * 0.5 + texture2D(m_samp0, below).rgba * 0.5;
  }
  else
    gl_FragColor.rgba = texture2D(m_samp0, source).rgba;
}
