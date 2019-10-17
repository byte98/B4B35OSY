#include <stdio.h>
#include <stdlib.h>

#define bool char
#define TRUE 1
#define FALSE 0

#define INPUT_BUFFER_SIZE 32

static volatile int WIDTH = 0;
static volatile int COUNT = 0;

struct StickyNote
{
	int distance_from_left;
	int width;
	int height;
}
typedef struct StickyNote sticky_note_t;

struct Result
{
	int visible_out;
	int visible_in;
	int visible_both;
	int unvisible;
}
typedef struct Result result_t;

int main(int argc, char *argv[])
{
	int reti = EXIT_SUCCESS;
	result_t result = {0, 0, 0, 0};
	
	int* situation_out;
	
#ifdef SAFE_MODE
	char line[INPUT_BUFFER_SIZE];
	fgets(line, INPUT_BUFFER_SIZE, stdin);
	if (sscanf(line, "%d %d", &WIDTH, &COUNT ) != 2)
	{
		reti = EXIT_FAILURE;
		fprintf(stderr, "ERROR [%d]: Parsing of first line failed!\n Expected: width<int> count<int>\n Get: %s", __LINE__, line);
	}
#endif // SAFE_MODE
#ifndef SAFE_MODE
	scanf("%d %d", &WIDTH, &COUNT);
#endif // !SAFE_MODE
#ifdef SAFE_MODE
	if (reti == EXIT_SUCCESS)
	{
#endif // SAFE_MODE
	situation_out = (int*)calloc(WIDTH, sizeof(int));
#ifdef SAFE_MODE
	if (situation_out == NULL)
	{
		reti = EXIT_FAILURE;
		fprintf(stderr, "ERROR [%d]: Allocation memory for 'situation_out' failed!", __LINE__);
	}
	if (reti == EXIT_SUCCESS)
	{
#endif // SAFE_MODE
		sticky_note_t* notes = (sticky_note_t*)malloc(COUNT * sizeof(sticky_note_t));
#ifdef SAFE_MODE
		if (notes == NULL)
		{
			reti = EXIT_FAILURE;
			fprintf(stderr, "ERROR [%d]: Allocation memory for 'notes' failed!", __LINE__);
		}
	if (reti == EXIT_SUCCESS)
	{
#endif // SAFE_MODE
	//All memory spaces has been sucessfully allocated
	//Now its time for parse notes data from standart input
		for (int i = 0; i < COUNT; i++)
		{
			sticky_note_t sticky_note;
#ifdef SAFE_MODE
			char data[INPUT_BUFFER_SIZE];
			fgets(data, INPUT_BUFFER_SIZE, stdin);
			if (sscanf(data, "%d %d %d", 
						&sticky_note.distance_from_left,
						&sticky_note.height,
						&sticky_note.width) != 3)
			{
				reti = EXIT_FAILURE;
				fprintf(stderr, "ERROR [%d]: Parsing line (%d) with sticky note data failed!\n Expected: distance_from_left<int> height<int> width<int>\n Get: %s\n", __LINE__, (i + 1), data);
				break;
			}
			if (sticky_note.width > WIDTH)
			{
				reti = EXIT_FAILURE;
				fprintf(stderr, "ERROR [%d]: Wrong input (%d)!\n Maximal allowed width: %d\n Get: %d\n", __LINE__, (i + 1), sticky_note.width);
				break;
			}
#endif // SAFE_MODE
#ifndef SAFE_MODE
			scanf("%d %d %d", 
					&sticky_note.distance_from_left,
					&sticky_note.height,
					&sticky_note.width);
#endif // !SAFE_MODE
			if (reti == EXIT_SUCCESS)
			{
				notes[i] = sticky_note;
			}
		}
#ifdef SAFE_MODE
	}
#endif // SAFE_MODE
#ifdef SAFE_MODE
	}
#endif // SAFE_MODE
#ifdef SAFE_MODE
	}
#endif // SAFE_MODE
}