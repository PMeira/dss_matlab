classdef (CaseInsensitiveProperties) IReclosers < DSS_MATLAB.Base
    % IReclosers: DSS MATLAB interface class to DSS C-API
    % 
    % Properties:
    %    AllNames - Array of strings with all Recloser names
    %    Count - Number of Recloser objects
    %    First - Set first object of Recloser; returns 0 if none.
    %    Name - Get/sets the name of the current active Recloser
    %    Next - Sets next Recloser active; returns 0 if no more.
    %    idx - Sets next Recloser active; returns 0 if no more.
    %    GroundInst - Ground (3I0) instantaneous trip setting - curve multipler or actual amps.
    %    GroundTrip - Ground (3I0) trip multiplier or actual amps
    %    MonitoredObj - Full name of object this Recloser to be monitored.
    %    MonitoredTerm - Terminal number of Monitored object for the Recloser
    %    NumFast - Number of fast shots
    %    PhaseInst - Phase instantaneous curve multipler or actual amps
    %    PhaseTrip - Phase trip curve multiplier or actual amps
    %    RecloseIntervals - Array of Doubles: reclose intervals, s, between shots.
    %    Shots - Number of shots to lockout (fast + delayed)
    %    SwitchedObj - Full name of the circuit element that is being switched by the Recloser.
    %    SwitchedTerm - Terminal number of the controlled device being switched by the Recloser
    % 
    % Methods:
    %    Close - 
    %    Open - 

    properties
        AllNames
        Count
        First
        Name
        Next
        idx
        GroundInst
        GroundTrip
        MonitoredObj
        MonitoredTerm
        NumFast
        PhaseInst
        PhaseTrip
        RecloseIntervals
        Shots
        SwitchedObj
        SwitchedTerm
    end

    methods (Access = public)
        function obj = IReclosers(apiutil)
            obj@DSS_MATLAB.Base(apiutil);
        end

        function obj = Close(obj)
            calllib(obj.libname, 'Reclosers_Close');
            obj.CheckForError();
        end

        function obj = Open(obj)
            calllib(obj.libname, 'Reclosers_Open');
            obj.CheckForError();
        end

    end
    methods

        function result = get.AllNames(obj)
            % Array of strings with all Recloser names
            result = obj.apiutil.get_string_array('Reclosers_Get_AllNames');
        end

        function result = get.Count(obj)
            % Number of Recloser objects
            result = calllib(obj.libname, 'Reclosers_Get_Count');
        end

        function result = get.First(obj)
            % Set first object of Recloser; returns 0 if none.
            result = calllib(obj.libname, 'Reclosers_Get_First');
        end

        function result = get.Name(obj)
            % Get/sets the name of the current active Recloser
            result = calllib(obj.libname, 'Reclosers_Get_Name');
        end
        function obj = set.Name(obj, Value)
            calllib(obj.libname, 'Reclosers_Set_Name', Value);
            obj.CheckForError();
        end

        function result = get.Next(obj)
            % Sets next Recloser active; returns 0 if no more.
            result = calllib(obj.libname, 'Reclosers_Get_Next');
        end

        function result = get.idx(obj)
            % Get/set active Recloser by index;  1..Count
            result = calllib(obj.libname, 'Reclosers_Get_idx');
        end
        function obj = set.idx(obj, Value)
            calllib(obj.libname, 'Reclosers_Set_idx', Value);
            obj.CheckForError();
        end


        function result = get.GroundInst(obj)
            % Ground (3I0) instantaneous trip setting - curve multipler or actual amps.
            result = calllib(obj.libname, 'Reclosers_Get_GroundInst');
            obj.CheckForError();
        end
        function obj = set.GroundInst(obj, Value)
            calllib(obj.libname, 'Reclosers_Set_GroundInst', Value);
            obj.CheckForError();
        end

        function result = get.GroundTrip(obj)
            % Ground (3I0) trip multiplier or actual amps
            result = calllib(obj.libname, 'Reclosers_Get_GroundTrip');
            obj.CheckForError();
        end
        function obj = set.GroundTrip(obj, Value)
            calllib(obj.libname, 'Reclosers_Set_GroundTrip', Value);
            obj.CheckForError();
        end

        function result = get.MonitoredObj(obj)
            % Full name of object this Recloser to be monitored.
            result = calllib(obj.libname, 'Reclosers_Get_MonitoredObj');
            obj.CheckForError();
        end
        function obj = set.MonitoredObj(obj, Value)
            calllib(obj.libname, 'Reclosers_Set_MonitoredObj', Value);
            obj.CheckForError();
        end

        function result = get.MonitoredTerm(obj)
            % Terminal number of Monitored object for the Recloser
            result = calllib(obj.libname, 'Reclosers_Get_MonitoredTerm');
            obj.CheckForError();
        end
        function obj = set.MonitoredTerm(obj, Value)
            calllib(obj.libname, 'Reclosers_Set_MonitoredTerm', Value);
            obj.CheckForError();
        end

        function result = get.NumFast(obj)
            % Number of fast shots
            result = calllib(obj.libname, 'Reclosers_Get_NumFast');
            obj.CheckForError();
        end
        function obj = set.NumFast(obj, Value)
            calllib(obj.libname, 'Reclosers_Set_NumFast', Value);
            obj.CheckForError();
        end

        function result = get.PhaseInst(obj)
            % Phase instantaneous curve multipler or actual amps
            result = calllib(obj.libname, 'Reclosers_Get_PhaseInst');
            obj.CheckForError();
        end
        function obj = set.PhaseInst(obj, Value)
            calllib(obj.libname, 'Reclosers_Set_PhaseInst', Value);
            obj.CheckForError();
        end

        function result = get.PhaseTrip(obj)
            % Phase trip curve multiplier or actual amps
            result = calllib(obj.libname, 'Reclosers_Get_PhaseTrip');
            obj.CheckForError();
        end
        function obj = set.PhaseTrip(obj, Value)
            calllib(obj.libname, 'Reclosers_Set_PhaseTrip', Value);
            obj.CheckForError();
        end

        function result = get.RecloseIntervals(obj)
            % (read-only) Array of Doubles: reclose intervals, s, between shots.
            calllib(obj.libname, 'Reclosers_Get_RecloseIntervals_GR');
            obj.CheckForError();
            result = obj.apiutil.get_float64_gr_array();
        end

        function result = get.Shots(obj)
            % Number of shots to lockout (fast + delayed)
            result = calllib(obj.libname, 'Reclosers_Get_Shots');
            obj.CheckForError();
        end
        function obj = set.Shots(obj, Value)
            calllib(obj.libname, 'Reclosers_Set_Shots', Value);
            obj.CheckForError();
        end

        function result = get.SwitchedObj(obj)
            % Full name of the circuit element that is being switched by the Recloser.
            result = calllib(obj.libname, 'Reclosers_Get_SwitchedObj');
            obj.CheckForError();
        end
        function obj = set.SwitchedObj(obj, Value)
            calllib(obj.libname, 'Reclosers_Set_SwitchedObj', Value);
            obj.CheckForError();
        end

        function result = get.SwitchedTerm(obj)
            % Terminal number of the controlled device being switched by the Recloser
            result = calllib(obj.libname, 'Reclosers_Get_SwitchedTerm');
            obj.CheckForError();
        end
        function obj = set.SwitchedTerm(obj, Value)
            calllib(obj.libname, 'Reclosers_Set_SwitchedTerm', Value);
            obj.CheckForError();
        end
    end
end