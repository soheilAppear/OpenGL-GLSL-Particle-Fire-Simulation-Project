#version 150 // GLSL 150 = OpenGL 3.2

out vec4 fragColor;
//in vec2 out_TexCoord;
//in vec2 out_TexCoord2;

in float percentTravel_For_Frag;

float camc_percent_travel_new;

uniform sampler2D weighted_average_calc_in_frag_program;

uniform sampler2D tex;
uniform sampler2D tex2;

void main() 
{
	camc_percent_travel_new = pow(percentTravel_For_Frag,0.5);

	if(true)
	{
		//fragColor =  5 *camc_percent_travel_new * texture(tex2 , gl_PointCoord); // if we want to use only smoke.
		//fragColor = texture(tex , gl_PointCoord);  // if we want to use fire
		  fragColor = (((((1.2 -camc_percent_travel_new) * texture(tex, gl_PointCoord)) + (24 * (camc_percent_travel_new) * texture(tex2, gl_PointCoord)))/3) /3.5);
	}
	else
	{
		fragColor = vec4(gl_PointCoord,0,1);
	}
}
