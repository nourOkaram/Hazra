#include <Hazra.h>

class Sandbox : public Hazra::Application
{
public:
	Sandbox()
	{

	}
	~Sandbox()
	{
	}
};

Hazra::Application* Hazra::CreateApplication()
{
	return new Sandbox();
}