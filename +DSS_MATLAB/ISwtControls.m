classdef (CaseInsensitiveProperties) ISwtControls < DSS_MATLAB.Base
    % ISwtControls: DSS MATLAB interface class to DSS C-API
    % 
    % Properties:
    %    AllNames - Array of strings with all SwtControl names
    %    Count - Number of SwtControl objects
    %    First - Set first object of SwtControl; returns 0 if none.
    %    Name - Get/sets the name of the current active SwtControl
    %    Next - Sets next SwtControl active; returns 0 if no more.
    %    idx - Sets next SwtControl active; returns 0 if no more.
    %    Action - Open or Close the switch. No effect if switch is locked.  However, Reset removes any lock and then closes the switch (shelf state).
    %    Delay - Time delay [s] betwen arming and opening or closing the switch.  Control may reset before actually operating the switch.
    %    IsLocked - The lock prevents both manual and automatic switch operation.
    %    NormalState - Get/set Normal state of switch (see actioncodes) dssActionOpen or dssActionClose
    %    State - Set it to force the switch to a specified state, otherwise read its present state.
    %    SwitchedObj - Full name of the switched element.
    %    SwitchedTerm - Terminal number where the switch is located on the SwitchedObj
    % 
    % Methods:
    %    Reset - 

    properties
        AllNames
        Count
        First
        Name
        Next
        idx
        Action
        Delay
        IsLocked
        NormalState
        State
        SwitchedObj
        SwitchedTerm
    end

    methods (Access = public)
        function obj = ISwtControls(apiutil)
            obj@DSS_MATLAB.Base(apiutil);
        end

        function obj = Reset(obj)
            calllib(obj.libname, 'SwtControls_Reset');
            obj.CheckForError();
        end

    end
    methods

        function result = get.AllNames(obj)
            % Array of strings with all SwtControl names
            result = obj.apiutil.get_string_array('SwtControls_Get_AllNames');
        end

        function result = get.Count(obj)
            % Number of SwtControl objects
            result = calllib(obj.libname, 'SwtControls_Get_Count');
        end

        function result = get.First(obj)
            % Set first object of SwtControl; returns 0 if none.
            result = calllib(obj.libname, 'SwtControls_Get_First');
        end

        function result = get.Name(obj)
            % Get/sets the name of the current active SwtControl
            result = calllib(obj.libname, 'SwtControls_Get_Name');
        end
        function obj = set.Name(obj, Value)
            calllib(obj.libname, 'SwtControls_Set_Name', Value);
            obj.CheckForError();
        end

        function result = get.Next(obj)
            % Sets next SwtControl active; returns 0 if no more.
            result = calllib(obj.libname, 'SwtControls_Get_Next');
        end

        function result = get.idx(obj)
            % Get/set active SwtControl by index;  1..Count
            result = calllib(obj.libname, 'SwtControls_Get_idx');
        end
        function obj = set.idx(obj, Value)
            calllib(obj.libname, 'SwtControls_Set_idx', Value);
            obj.CheckForError();
        end


        function result = get.Action(obj)
            % Open or Close the switch. No effect if switch is locked.  However, Reset removes any lock and then closes the switch (shelf state).
            result = calllib(obj.libname, 'SwtControls_Get_Action');
            obj.CheckForError();
        end
        function obj = set.Action(obj, Value)
            calllib(obj.libname, 'SwtControls_Set_Action', Value);
            obj.CheckForError();
        end

        function result = get.Delay(obj)
            % Time delay [s] betwen arming and opening or closing the switch.  Control may reset before actually operating the switch.
            result = calllib(obj.libname, 'SwtControls_Get_Delay');
            obj.CheckForError();
        end
        function obj = set.Delay(obj, Value)
            calllib(obj.libname, 'SwtControls_Set_Delay', Value);
            obj.CheckForError();
        end

        function result = get.IsLocked(obj)
            % The lock prevents both manual and automatic switch operation.
            result = (calllib(obj.libname, 'SwtControls_Get_IsLocked') ~= 0);
            obj.CheckForError();
        end
        function obj = set.IsLocked(obj, Value)
            calllib(obj.libname, 'SwtControls_Set_IsLocked', Value);
            obj.CheckForError();
        end

        function result = get.NormalState(obj)
            % Get/set Normal state of switch (see actioncodes) dssActionOpen or dssActionClose
            result = calllib(obj.libname, 'SwtControls_Get_NormalState');
            obj.CheckForError();
        end
        function obj = set.NormalState(obj, Value)
            calllib(obj.libname, 'SwtControls_Set_NormalState', Value);
            obj.CheckForError();
        end

        function result = get.State(obj)
            % Set it to force the switch to a specified state, otherwise read its present state.
            result = calllib(obj.libname, 'SwtControls_Get_State');
            obj.CheckForError();
        end
        function obj = set.State(obj, Value)
            calllib(obj.libname, 'SwtControls_Set_State', Value);
            obj.CheckForError();
        end

        function result = get.SwitchedObj(obj)
            % Full name of the switched element.
            result = calllib(obj.libname, 'SwtControls_Get_SwitchedObj');
            obj.CheckForError();
        end
        function obj = set.SwitchedObj(obj, Value)
            calllib(obj.libname, 'SwtControls_Set_SwitchedObj', Value);
            obj.CheckForError();
        end

        function result = get.SwitchedTerm(obj)
            % Terminal number where the switch is located on the SwitchedObj
            result = calllib(obj.libname, 'SwtControls_Get_SwitchedTerm');
            obj.CheckForError();
        end
        function obj = set.SwitchedTerm(obj, Value)
            calllib(obj.libname, 'SwtControls_Set_SwitchedTerm', Value);
            obj.CheckForError();
        end
    end
end