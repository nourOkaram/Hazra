#include <Hazra.h>

class ExampleLayer : public Hazra::Layer
{
public:
	ExampleLayer() : Layer("Example")
	{}

	void OnUpdate() override
	{
		HZ_INFO("ExampleLayer::Update");
	}

	void OnEvent(Hazra::Event& event) override
	{
		HZ_TRACE("{0}", event);
	}
};



class Sandbox : public Hazra::Application
{
public:
	Sandbox()
	{
		PushLayer(new ExampleLayer());
	}
	~Sandbox()
	{
	}
};

Hazra::Application* Hazra::CreateApplication()
{
	return new Sandbox();
}