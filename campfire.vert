#version 150 // GLSL 150 = OpenGL 3.2

in vec3 in_Position;
//in vec2 in_TexCoord;
//in vec2 in_TexCoord2;

uniform float time;  // top of vertex program
float pointMove;
float localParticleTime;

float timeToLoop = 3;  //(time it takes for a particle to go from bottom to top of fire)
float travelDist = 2;  //(distance between bottom of fire and top of fire).

uniform mat4 ModelView;
uniform mat4 Projection;

//out vec2 out_TexCoord;
//out vec2 out_TexCoord2;

float wiggle_resultsX = 0;
float wiggle_resultsZ = 0;

out float percentTravel_For_Frag;

float wiggle(float vertex_id , float percentTravel)
{
	float wiggle_result_raw1 = vertex_id +  percentTravel + time;
	float wiggle_result_raw2 = vertex_id +  percentTravel + time;
	float wiggle_result_raw3 = vertex_id +  percentTravel + time;

	float final_wiggle_result1 = 0;
	float final_wiggle_result2 = 0;
	float final_wiggle_result3 = 0;

	final_wiggle_result1 = sin(wiggle_result_raw1);
	final_wiggle_result2 = sin(wiggle_result_raw2);
	final_wiggle_result3 = sin(wiggle_result_raw3);

	float weighted_average_results = (final_wiggle_result1 + final_wiggle_result2 + final_wiggle_result3) / 3;

	return weighted_average_results;
}

void main() 
{

	//out_TexCoord = in_TexCoord;
	//out_TexCoord2 = in_TexCoord2;

	localParticleTime = (time + gl_VertexID)/10000;

	
	// Also for making our fire more real with having the "flame" we can run this code : // pointMove = mod(time + timeToLoop * localParticleTime , travelDist);
	pointMove = mod(time + travelDist * localParticleTime , travelDist);
	

	float main_percentTravel = mod(pointMove, travelDist);

	float vr_id_Z = mod(gl_VertexID,40);

	wiggle_resultsX = wiggle(gl_VertexID, main_percentTravel) ;
	wiggle_resultsZ = wiggle(vr_id_Z, main_percentTravel) ;
 
	gl_PointSize = 30 * (1 - main_percentTravel/2.0);

	gl_Position = Projection * ModelView * vec4(in_Position.x + (wiggle_resultsX) * (main_percentTravel/3) , in_Position.y + (pointMove) * pow(main_percentTravel,0.7) , in_Position.z + (wiggle_resultsZ) * (main_percentTravel/3), 1);
	
	percentTravel_For_Frag = main_percentTravel/1.3 ;

	
}