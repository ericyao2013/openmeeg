SET(CHECK_CXX_FEATURE_PREFIX "")
MARK_AS_ADVANCED(CHECK_CXX_FEATURE_PREFIX)

MACRO(CHECK_CXX_FEATURE feature file message)
    MESSAGE(STATUS "Check whether the compiler ${message}")
    TRY_COMPILE(RESULT ${CMAKE_BINARY_DIR}
        #${CMAKE_ROOT}/Modules/TestForSTDNamespace.cxx
        ${CMAKE_CURRENT_SOURCE_DIR}/macros/cxx_tests/${file}
        COMPILE_DEFINITIONS "${CHECK_CXX_FEATURE_DEFINITIONS}"
        OUTPUT_VARIABLE OUTPUT)

    IF (RESULT)
        SET (FOUND "found")
        SET (STATUS "passed")
        SET(CHECK_CXX_FEATURE_DEFINITIONS "${CHECK_CXX_FEATURE_DEFINITIONS} -D${feature}")
    ELSE()
        SET (FOUND "not found")
        SET (STATUS "failed")
    ENDIF()
    MESSAGE(STATUS "Check whether the compiler ${message} - ${FOUND}")
    SET("${CHECK_CXX_FEATURE_PREFIX}${feature}" ${RESULT} CACHE INTERNAL "Does the compiler ${message}")
    FILE(APPEND ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeOutput.log
         "Determining if the CXX compiler ${message} ${STATUS} with "
         "the following output:\n${OUTPUT}\n\n")
ENDMACRO()

MACRO(CHECK_CXX_GENERAL)
    CHECK_CXX_FEATURE(HAVE_NAMESPACES namespaces.cpp "implements namespaces")
    CHECK_CXX_FEATURE(HAVE_EXCEPTIONS exceptions.cpp "supports exceptions")
    CHECK_CXX_FEATURE(HAVE_RTTI rtti.cpp "supports Run-Time Type Identification")
    CHECK_CXX_FEATURE(HAVE_MEMBER_CONSTANTS member_constants.cpp "supports member constants")
    CHECK_CXX_FEATURE(HAVE_OLD_FOR_SCOPING old_for_scoping.cpp "accepts the old for scoping rules")
ENDMACRO()

MACRO(CHECK_CXX_KEYWORDS)
    CHECK_CXX_FEATURE(HAVE_EXPLICIT      explicit.cpp      "supports the explicit keyword")
    CHECK_CXX_FEATURE(HAVE_MUTABLE       mutable.cpp       "supports the mutable keyword")
    CHECK_CXX_FEATURE(HAVE_TYPENAME      typename.cpp      "recognizes typename")
    CHECK_CXX_FEATURE(HAVE_NCEG_RESTRICT nceg_restrict.cpp "supports the Numerical C Extensions Group restrict keyword")
    CHECK_CXX_FEATURE(HAVE_RESTRICT_EGCS restrict_egcs.cpp "recognizes the '__restrict__' keyword")
    CHECK_CXX_FEATURE(HAVE_BOOL          bool.cpp          "recognizes bool as a built-in type")
ENDMACRO()

MACRO(CHECK_CXX_TYPE_CASTS)
    CHECK_CXX_FEATURE(HAVE_CONST_CAST       const_cast.cpp       "supports const_cast<>")
    CHECK_CXX_FEATURE(HAVE_STATIC_CAST      static_cast.cpp      "supports static_cast<>")
    CHECK_CXX_FEATURE(HAVE_REINTERPRET_CAST reinterpret_cast.cpp "supports reinterpret_cast<>")
    CHECK_CXX_FEATURE(HAVE_DYNAMIC_CAST     dynamic_cast.cpp     "supports dynamic_cast<>")
ENDMACRO()

MACRO(CHECK_CXX_TEMPLATES_FEATURES)
    CHECK_CXX_FEATURE(HAVE_TEMPLATES                                templates.cpp                                "supports basic templates")
    CHECK_CXX_FEATURE(HAVE_PARTIAL_SPECIALIZATION                   partial_specialization.cpp                   "supports partial specialization")
    CHECK_CXX_FEATURE(HAVE_PARTIAL_ORDERING                         partial_ordering.cpp                         "supports partial ordering")
    CHECK_CXX_FEATURE(HAVE_DEFAULT_TEMPLATE_PARAMETERS              default_template_parameters.cpp              "supports default template parameters")
    CHECK_CXX_FEATURE(HAVE_MEMBER_TEMPLATES                         member_templates.cpp                         "supports member templates")
    CHECK_CXX_FEATURE(HAVE_MEMBER_TEMPLATES_OUTSIDE_CLASS           member_templates_outside_class.cpp           "supports member templates outside the class declaration")
    CHECK_CXX_FEATURE(HAVE_FULL_SPECIALIZATION_SYNTAX               full_specialization_syntax.cpp               "recognizes the full specialization syntax")
    CHECK_CXX_FEATURE(HAVE_FUNCTION_NONTYPE_PARAMETERS              function_nontype_parameters.cpp              "supports function templates with non-type parameters")
    CHECK_CXX_FEATURE(HAVE_TEMPLATE_QUALIFIED_BASE_CLASS            template_qualified_base_class.cpp            "supports template-qualified base class specifiers")
    CHECK_CXX_FEATURE(HAVE_TEMPLATE_QUALIFIED_RETURN_TYPE           template_qualified_return_type.cpp           "supports template-qualified return types")
    CHECK_CXX_FEATURE(HAVE_EXPLICIT_TEMPLATE_FUNCTION_QUALIFICATION explicit_template_function_qualification.cpp "supports explicit template function qualification")
    CHECK_CXX_FEATURE(HAVE_TEMPLATES_AS_TEMPLATE_ARGUMENTS          templates_as_template_arguments.cpp          "supports templates as template arguments")
    CHECK_CXX_FEATURE(HAVE_TEMPLATE_KEYWORD_QUALIFIER               template_keyword_qualifier.cpp               "supports use of the template keyword as a qualifier")
    CHECK_CXX_FEATURE(HAVE_TEMPLATE_SCOPED_ARGUMENT_MATCHING        template_scoped_argument_matching.cpp        "supports function matching with argument types which are template scope-qualified")
    CHECK_CXX_FEATURE(HAVE_TYPE_PROMOTION                           type_promotion.cpp                           "support the vector type promotion mechanism")
    CHECK_CXX_FEATURE(HAVE_USE_NUMTRAIT                             use_numtrait.cpp                             "supports numeric traits promotions")
    CHECK_CXX_FEATURE(HAVE_ENUM_COMPUTATIONS                        enum_computations.cpp                        "handles computations inside an enum")
    CHECK_CXX_FEATURE(HAVE_ENUM_COMPUTATIONS_WITH_CAST              enum_computations_with_cast.cpp              "handles (int) casts in enum computations")
ENDMACRO()

MACRO(CHECK_HEADER variable name)
    FIND_PATH(FOUND ${name} "/usr/include;/usr/include/c++")
    IF (FOUND)
        SET(value TRUE)
    ELSE()
        SET(value FALSE)
    ENDIF()
    SET("${CHECK_CXX_FEATURE_PREFIX}${variable}" ${value} CACHE INTERNAL "Whether the header ${name} exists.")
ENDMACRO()

MACRO(CHECK_CXX_STANDARD_LIBRARY)
	CHECK_CXX_FEATURE(HAVE_COMPLEX                       have_complex.cpp                  "has complex<T>")
	CHECK_CXX_FEATURE(HAVE_COMPLEX_FCNS                  have_complex_fcns.cpp             "has standard complex<T> functions")
    CHECK_HEADER(HAVE_CSTRING cstring)
	CHECK_CXX_FEATURE(HAVE_NUMERIC_LIMITS                have_numeric_limits.cpp           "has numeric_limits<T>")
 	CHECK_CXX_FEATURE(HAVE_CLIMITS                       have_climits.cpp                  "has <climits> header")
	CHECK_CXX_FEATURE(HAVE_VALARRAY                      have_valarray.cpp                 "has valarray<T>")
	CHECK_CXX_FEATURE(HAVE_COMPLEX_MATH1                 have_complex_math1.cpp            "has complex math functions")
	CHECK_CXX_FEATURE(HAVE_COMPLEX_MATH2                 have_complex_math2.cpp            "has more complex math functions")
	CHECK_CXX_FEATURE(HAVE_IEEE_MATH                     have_ieee_math.cpp                "supports IEEE math library")
	CHECK_CXX_FEATURE(HAVE_SYSTEM_V_MATH                 have_system_v_math.cpp            "supports System V math library")
	CHECK_CXX_FEATURE(HAVE_MATH_FN_IN_NAMESPACE_STD      math_fn_in_namespace_std.cpp      "has C math functions in namespace std")
 	CHECK_CXX_FEATURE(HAVE_MATH_ABSINT_IN_NAMESPACE_STD  math_absint_in_namespace_std.cpp  "has C math abs(integer type) in namespace std")
 	CHECK_CXX_FEATURE(HAVE_COMPLEX_MATH_IN_NAMESPACE_STD complex_math_in_namespace_std.cpp "supports complex math functions are in namespace std")
	CHECK_CXX_FEATURE(HAVE_ISNAN_IN_NAMESPACE_STD        isnan_in_namespace_std.cpp        "has isnan function in namespace std")
	CHECK_CXX_FEATURE(HAVE_ISNORMAL_IN_NAMESPACE_STD     isnormal_in_namespace_std.cpp     "has isnormal function in namespace std")
	CHECK_CXX_FEATURE(HAVE_STD                           have_std.cpp                      "supports ISO C++ standard library")
	CHECK_CXX_FEATURE(HAVE_STL                           have_stl.cpp                      "supports Standard Template Library")
	CHECK_CXX_FEATURE(HAVE_RUSAGE                        have_rusage.cpp                   "has getrusage() function")
ENDMACRO()

MACRO(CHECK_ALL_CXX_FEATURES)
    SET(CHECK_CXX_FEATURE_PREFIX ${ARGN})
    CHECK_CXX_GENERAL()
    CHECK_CXX_KEYWORDS()
    CHECK_CXX_TYPE_CASTS()
    CHECK_CXX_TEMPLATES_FEATURES()
    CHECK_CXX_STANDARD_LIBRARY()
ENDMACRO()
