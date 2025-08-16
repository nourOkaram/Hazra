#pragma once
#ifdef HZ_PLATFORM_WINDOWS
#include "Hazra/Application.h"
extern Hazra::Application* Hazra::CreateApplication();

int main(int argc, char** argv)
{
	Hazra::Log::Init();
	HZ_CORE_WARN("Initialized Log!");
	int a = 5;
	HZ_INFO("Hello! Var={0}", a);

	auto app = Hazra::CreateApplication();
	app->Run();
	delete app;
	return 0;
}
#endif