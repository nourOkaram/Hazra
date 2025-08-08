#pragma once
#ifdef HAZRA_PLATFORM_WINDOWS

extern Hazra::Application* Hazra::CreateApplication();

int main(int argc, char** argv)
{
	printf("Hazra Engine\n");
	auto app = Hazra::CreateApplication();
	app->Run();
	delete app;
	return 0;
}
#endif