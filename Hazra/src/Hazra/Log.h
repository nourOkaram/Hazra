#pragma once
#include "Core.h"
#include "spdlog/spdlog.h"
#include "spdlog/fmt/ostr.h"

namespace Hazra
{
	class HZ_API Log
	{
	public:
		static void Init();
		inline static std::shared_ptr<spdlog::logger>& GetCoreLogger() { return s_CoreLogger; }
		inline static std::shared_ptr<spdlog::logger>& GetClientLogger() { return s_ClientLogger; }
	private:
		static std::shared_ptr<spdlog::logger> s_CoreLogger;
		static std::shared_ptr<spdlog::logger> s_ClientLogger;
	};
}

// Core log macros
#define HZ_CORE_TRACE(...)		::Hazra::Log::GetCoreLogger()->trace(__VA_ARGS__)
#define HZ_CORE_INFO(...)		::Hazra::Log::GetCoreLogger()->info(__VA_ARGS__)
#define HZ_CORE_WARN(...)		::Hazra::Log::GetCoreLogger()->warn(__VA_ARGS__)
#define HZ_CORE_ERROR(...)		::Hazra::Log::GetCoreLogger()->error(__VA_ARGS__)
#define HZ_CORE_FATAL(...)		::Hazra::Log::GetCoreLogger()->fatal(__VA_ARGS__)


// Client log macros
#define HZ_TRACE(...)			::Hazra::Log::GetClientLogger()->trace(__VA_ARGS__)
#define HZ_INFO(...)			::Hazra::Log::GetClientLogger()->info(__VA_ARGS__)
#define HZ_WARN(...)			::Hazra::Log::GetClientLogger()->warn(__VA_ARGS__)
#define HZ_ERROR(...)			::Hazra::Log::GetClientLogger()->error(__VA_ARGS__)
#define HZ_FATAL(...)			::Hazra::Log::GetClientLogger()->fatal(__VA_ARGS__)

// if dist build
#ifdef HZ_DIST
#define HZ_CORE_TRACE(...)
#define HZ_CORE_INFO(...)
#define HZ_CORE_WARN(...)
#define HZ_CORE_ERROR(...)
#define HZ_CORE_FATAL(...)

#define HZ_TRACE(...)
#define HZ_INFO(...)
#define HZ_WARN(...)
#define HZ_ERROR(...)
#define HZ_FATAL(...)
#endif