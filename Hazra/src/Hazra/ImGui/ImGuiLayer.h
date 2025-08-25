#pragma once
#include "Hazra/Layer.h"
#include "Hazra/Events/ApplicationEvent.h"
#include "Hazra/Events/MouseEvent.h"
#include "Hazra/Events/KeyEvent.h"

namespace Hazra
{
	class HZ_API ImGuiLayer : public Layer
	{
	public:
		ImGuiLayer();
		~ImGuiLayer();

		virtual void OnAttach() override;
		virtual void OnDetach() override;
		virtual void OnImGuiRender() override;

		void Begin();
		void End();

	private:
		float m_Time = 0.0f;
	};
}