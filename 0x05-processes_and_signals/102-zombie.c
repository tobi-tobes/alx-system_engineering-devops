#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>

/**
 * infinite_while - an infinite while loop
 *
 * Return: 0
 */
int infinite_while(void)
{
	while (1)
	{
		sleep(1);
	}
	return (0);
}

/**
 * main - creates zombie processes
 *
 * Return: 0
 */
int main(void)
{
	pid_t child_pid;
	int counter = 0;

	while (counter < 5)
	{
		child_pid = fork();
		if (child_pid == -1)
			return (1);
		if (child_pid == 0)
			return (0);
		printf("Zombie process created, PID: %d\n", child_pid);
		counter++;
	}
	infinite_while();
	return (0);
}
