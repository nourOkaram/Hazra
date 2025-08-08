#pragma once
#include "Core.h"

namespace Hazra {
	class HZ_API Application
	{
	public:
		Application();
		virtual ~Application();

		void Run();
	};

	// To be defined in CLIENT
	Application* CreateApplication();
}
