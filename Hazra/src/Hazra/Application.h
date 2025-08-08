#pragma once
#include "Core.h"

namespace Hazra {
	class HAZRA_API Application
	{
	public:
		Application();
		virtual ~Application();

		void Run();
	};

	// To be defined in CLIENT
	Application* CreateApplication();
}
