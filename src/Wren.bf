using System;

namespace Wren_beef
{
	public enum WrenErrorType
	{
		// A syntax or resolution error detected at compile time.
		WREN_ERROR_COMPILE,

		// The error message for a runtime error.
		WREN_ERROR_RUNTIME,

		// One entry of a runtime error's stack trace.
		WREN_ERROR_STACK_TRACE
	}

	public enum WrenInterpretResult
	{
		WREN_RESULT_SUCCESS,
		WREN_RESULT_COMPILE_ERROR,
		WREN_RESULT_RUNTIME_ERROR
	}

	public enum WrenType
	{
	  WREN_TYPE_BOOL,
	  WREN_TYPE_NUM,
	  WREN_TYPE_FOREIGN,
	  WREN_TYPE_LIST,
	  WREN_TYPE_NULL,
	  WREN_TYPE_STRING,

	  // The object is of a type that isn't accessible by the C API.
	  WREN_TYPE_UNKNOWN
	}

	class Wren
	{
		public function void* ReallocateFn(void* memory, uint64 newSize);
		public function void ForeignMethodFn(WrenVM* vm);
		public function void FinalizerFn(void* data);
		public function char8* ResolveModuleFn(WrenVM* vm, char8* importer, char8* name);
		public function char8* LoadModuleFn(WrenVM* vm, char8* name);
		public function ForeignMethodFn BindForeignMethodFn(WrenVM* vm, char8* module, char8* className, bool isStatic,char8* signature);
		public function void WriteFn(WrenVM* vm, char8* text);

		public function void ErrorFn(WrenVM* vm, WrenErrorType type, char8* module, int line, char8* message);
		public function WrenForeignClassMethods BindForeignClassFn(WrenVM* vm, char8* module, char8* className);



		[CLink]
		private static extern void wrenInitConfiguration(WrenConfiguration* configuration);
		public static void InitConfiguration(WrenConfiguration* configuration)
		{
			wrenInitConfiguration(configuration);
		}

		[CLink]
		private static extern WrenVM* wrenNewVM(WrenConfiguration* configuration);
		public static WrenVM* NewVM(WrenConfiguration* configuration)
		{
			return wrenNewVM(configuration);
		}

		[CLink]
		private static extern void wrenFreeVM(WrenVM* vm);
		public static void FreeVM(WrenVM* vm)
		{
			wrenFreeVM(vm);
		}

		[CLink]
		private static extern void wrenCollectGarbage(WrenVM* vm);
		public static void CollectGarbage(WrenVM* vm)
		{
			wrenCollectGarbage(vm);
		}

		[CLink]
		private static extern WrenInterpretResult wrenInterpret(WrenVM* vm, char8* module, char8* source);
		public static WrenInterpretResult Interpret(WrenVM* vm, char8* module, char8* source)
		{
			return wrenInterpret(vm, module, source);
		}

		[CLink]
		private static extern WrenHandle* wrenMakeCallHandle(WrenVM* vm, char8* signature);
		public static WrenHandle* MakeCallHandle(WrenVM* vm, char8* signature)
		{
			return wrenMakeCallHandle(vm, signature);
		}

		[CLink]
		private static extern WrenInterpretResult wrenCall(WrenVM* vm, WrenHandle* method);
		public static WrenInterpretResult Call(WrenVM* vm, WrenHandle* method)
		{
			return wrenCall(vm, method);
		}

		[CLink]
		private static extern void wrenReleaseHandle(WrenVM* vm, WrenHandle* handle);
		public static void ReleaseHandle(WrenVM* vm, WrenHandle* handle)
		{
			wrenReleaseHandle(vm, handle);
		}

		[CLink]
		private static extern int wrenGetSlotCount(WrenVM* vm);
		public static int GetSlotCount(WrenVM* vm)
		{
			return wrenGetSlotCount(vm);
		}

		[CLink]
		private static extern void wrenEnsureSlots(WrenVM* vm, int numSlots);
		public static void EnsureSlots(WrenVM* vm, int numSlots)
		{
			wrenEnsureSlots(vm, numSlots);
		}

		[CLink]
		private static extern WrenType wrenGetSlotType(WrenVM* vm, int slot);
		public static WrenType GetSlotType(WrenVM* vm, int slot)
		{
			return wrenGetSlotType(vm, slot);
		}

		[CLink]
		private static extern bool wrenGetSlotBool(WrenVM* vm, int slot);
		public static bool GetSlotBool(WrenVM* vm, int slot)
		{
			return wrenGetSlotBool(vm, slot);
		}

		[CLink]
		private static extern char8* wrenGetSlotBytes(WrenVM* vm, int slot, int* length);
		public static char8* GetSlotBytes(WrenVM* vm, int slot, int* length)
		{
			return wrenGetSlotBytes(vm, slot, length);
		}

		[CLink]
		private static extern double wrenGetSlotDouble(WrenVM* vm, int slot);
		public static double GetSlotDouble(WrenVM* vm, int slot)
		{
			return wrenGetSlotDouble(vm, slot);
		}

		[CLink]
		private static extern void* wrenGetSlotForeign(WrenVM* vm, int slot);
		public static void* GetSlotForeign(WrenVM* vm, int slot)
		{
			return wrenGetSlotForeign(vm, slot);
		}

		[CLink]
		private static extern char8* wrenGetSlotString(WrenVM* vm, int slot);
		public static char8* GetSlotString(WrenVM* vm, int slot)
		{
			return wrenGetSlotString(vm, slot);
		}

		[CLink]
		private static extern WrenHandle* wrenGetSlotHandle(WrenVM* vm, int slot);
		public static WrenHandle* GetSlotHandle(WrenVM* vm, int slot)
		{
			return wrenGetSlotHandle(vm, slot);
		}

		[CLink]
		private static extern void wrenSetSlotBool(WrenVM* vm, int slot, bool value);
		public static void SetSlotBool(WrenVM* vm, int slot, bool value)
		{
			wrenSetSlotBool(vm, slot, value);
		}

		[CLink]
		private static extern void wrenSetSlotBytes(WrenVM* vm, int slot, char8* bytes, uint64 length);
		public static void SetSlotBytes(WrenVM* vm, int slot, char8* bytes, uint64 length)
		{
			wrenSetSlotBytes(vm, slot, bytes, length);
		}

		[CLink]
		private static extern void wrenSetSlotDouble(WrenVM* vm, int slot, double value);
		public static void SetSlotDouble(WrenVM* vm, int slot, double value)
		{
			wrenSetSlotDouble(vm, slot, value);
		}

		[CLink]
		private static extern void* wrenSetSlotNewForeign(WrenVM* vm, int slot, int classSlot, uint16 size);
		public static void* SetSlotNewForeign(WrenVM* vm, int slot, int classSlot, uint16 size)
		{
			return wrenSetSlotNewForeign(vm, slot, classSlot, size);
		}

		[CLink]
		private static extern void wrenSetSlotNewList(WrenVM* vm, int slot);
		public static void SetSlotNewList(WrenVM* vm, int slot)
		{
			wrenSetSlotNewList(vm, slot);
		}

		[CLink]
		private static extern void wrenSetSlotNull(WrenVM* vm, int slot);
		public static void SetSlotNull(WrenVM* vm, int slot)
		{
			wrenSetSlotNull(vm, slot);
		}

		[CLink]
		private static extern void wrenSetSlotString(WrenVM* vm, int slot, char8* text);
		public static void SetSlotString(WrenVM* vm, int slot, char8* text)
		{
			wrenSetSlotString(vm, slot, text);
		}

		[CLink]
		private static extern void wrenSetSlotHandle(WrenVM* vm, int slot, WrenHandle* handle);
		public static void SetSlotHandle(WrenVM* vm, int slot, WrenHandle* handle)
		{
			wrenSetSlotHandle(vm, slot, handle);
		}

		[CLink]
		private static extern int wrenGetListCount(WrenVM* vm, int slot);
		public static int GetListCount(WrenVM* vm, int slot)
		{
			return wrenGetListCount(vm, slot);
		}
		
		[CLink]
		private static extern void wrenGetListElement(WrenVM* vm, int listSlot, int index, int elementSlot);
		public static void GetListElement(WrenVM* vm, int listSlot, int index, int elementSlot)
		{
			wrenGetListElement(vm, listSlot, index, elementSlot);
		}

		[CLink]
		private static extern void wrenInsertInList(WrenVM* vm, int listSlot, int index, int elementSlot);
		public static void InsertInList(WrenVM* vm, int listSlot, int index, int elementSlot)
		{
			wrenInsertInList(vm, listSlot, index, elementSlot);
		}

		[CLink]
		private static extern void wrenGetVariable(WrenVM* vm, char8* module, char8* name, int slot);
		public static void GetVariable(WrenVM* vm, char8* module, char8* name, int slot)
		{
			wrenGetVariable(vm, module, name, slot);
		}

		[CLink]
		private static extern void wrenAbortFiber(WrenVM* vm, int slot);
		public static void AbortFiber(WrenVM* vm, int slot)
		{
			wrenAbortFiber(vm, slot);
		}

		[CLink]
		private static extern void* wrenGetUserData(WrenVM* vm);
		public static void* GetUserData(WrenVM* vm)
		{
			return wrenGetUserData(vm);
		}

		[CLink]
		private static extern void wrenSetUserData(WrenVM* vm, void* userData);
		public static void SetUserData(WrenVM* vm, void* userData)
		{
			wrenSetUserData(vm, userData);
		}
		
	}

	struct WrenVM
	{

	}

	struct WrenHandle
	{

	}

	struct WrenForeignClassMethods
	{
		public Wren.ForeignMethodFn allocate;
		public Wren.FinalizerFn finalize;
	}

	struct WrenConfiguration
	{
		public Wren.ReallocateFn reallocateFn;
		public Wren.ResolveModuleFn resolveModuleFn;
		public Wren.LoadModuleFn loadModuleFn;
		public Wren.BindForeignMethodFn bindForeignMethodFn;
		public Wren.BindForeignClassFn bindForeignClassFn;
		public Wren.WriteFn writeFn;
		public Wren.ErrorFn errorFn;

		public uint64 initialHeapSize;
		public uint64 minHeapSize;
		public int heapGrowthPercent;
		public void* userData;
	}
}
