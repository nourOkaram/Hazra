#include <Hazra.h>

#include "imgui/imgui.h"
class ExampleLayer : public Hazra::Layer
{
public:
	ExampleLayer() : Layer("Example")
	{}

	void OnUpdate() override
	{
		if (Hazra::Input::IsKeyPressed(HZ_KEY_TAB))
		{
			HZ_TRACE("Tab key is pressed (poll)!");
		}
	}

	virtual void OnImGuiRender() override
	{
		ImGui::Begin("Example Layer");
		ImGui::Text("Hello, World!");
		ImGui::End();
	}

	void OnEvent(Hazra::Event& event) override
	{
		if (event.GetEventType() == Hazra::EventType::KeyPressed)
		{
			Hazra::KeyPressedEvent& e = (Hazra::KeyPressedEvent&)event;
			if (e.GetKeyCode() == HZ_KEY_TAB)
			{
				HZ_TRACE("Tab key is pressed (event)!");
			}

			//HZ_TRACE("{0}", (char) e.GetKeyCode());
		}
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