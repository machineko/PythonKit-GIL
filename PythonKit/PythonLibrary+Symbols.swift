//===-- PythonLibrary+Symbols.swift ---------------------------*- swift -*-===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2018 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//
//
// This file defines the Python symbols required for the interoperability layer.
//
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// Required Python typealiases and constants.
//===----------------------------------------------------------------------===//

@usableFromInline
typealias PyObjectPointer = UnsafeMutableRawPointer
typealias PyMethodDefPointer = UnsafeMutableRawPointer
typealias PyCCharPointer = UnsafePointer<Int8>
typealias PyBinaryOperation =
    @convention(c) (PyObjectPointer?, PyObjectPointer?) -> PyObjectPointer?
typealias PyUnaryOperation =
    @convention(c) (PyObjectPointer?) -> PyObjectPointer?

let Py_LT: Int32 = 0
let Py_LE: Int32 = 1
let Py_EQ: Int32 = 2
let Py_NE: Int32 = 3
let Py_GT: Int32 = 4
let Py_GE: Int32 = 5

//===----------------------------------------------------------------------===//
// Python library symbols lazily loaded at runtime.
//===----------------------------------------------------------------------===//

@MainActor let Py_Initialize: @convention(c) () -> Void =
    PythonLibrary.loadSymbol(name: "Py_Initialize")

@MainActor let Py_IncRef: @convention(c) (PyObjectPointer?) -> Void =
    PythonLibrary.loadSymbol(name: "Py_IncRef")

@MainActor let Py_DecRef: @convention(c) (PyObjectPointer?) -> Void =
    PythonLibrary.loadSymbol(name: "Py_DecRef")

@MainActor let PyImport_ImportModule: @convention(c) (
    PyCCharPointer) -> PyObjectPointer? =
    PythonLibrary.loadSymbol(name: "PyImport_ImportModule")

@MainActor let PyEval_GetBuiltins: @convention(c) () -> PyObjectPointer =
    PythonLibrary.loadSymbol(name: "PyEval_GetBuiltins")

@MainActor let PyRun_SimpleString: @convention(c) (PyCCharPointer) -> Void =
    PythonLibrary.loadSymbol(name: "PyRun_SimpleString")

@MainActor let PyCFunction_NewEx: @convention(c) (PyMethodDefPointer, UnsafeMutableRawPointer, UnsafeMutableRawPointer?) -> PyObjectPointer =
    PythonLibrary.loadSymbol(name: "PyCFunction_NewEx")

@MainActor let PyInstanceMethod_New: @convention(c) (PyObjectPointer) -> PyObjectPointer =
    PythonLibrary.loadSymbol(name: "PyInstanceMethod_New")

/// The last argument would ideally be of type `@convention(c) (PyObjectPointer?) -> Void`.
/// Due to SR-15871 and the source-breaking nature of potential workarounds, the
/// static typing was removed. The caller must now manually cast a closure to
/// `OpaquePointer` before passing it into `PyCapsule_New`.
@MainActor let PyCapsule_New: @convention(c) (
    UnsafeMutableRawPointer, UnsafePointer<CChar>?,
    OpaquePointer) -> PyObjectPointer =
    PythonLibrary.loadSymbol(name: "PyCapsule_New")

@MainActor let PyCapsule_GetPointer: @convention(c) (PyObjectPointer?, UnsafePointer<CChar>?) -> UnsafeMutableRawPointer =
    PythonLibrary.loadSymbol(name: "PyCapsule_GetPointer")

@MainActor let PyErr_SetString: @convention(c) (PyObjectPointer, UnsafePointer<CChar>?) -> Void =
    PythonLibrary.loadSymbol(name: "PyErr_SetString")

@MainActor let PyErr_Occurred: @convention(c) () -> PyObjectPointer? =
    PythonLibrary.loadSymbol(name: "PyErr_Occurred")

@MainActor let PyErr_Clear: @convention(c) () -> Void =
    PythonLibrary.loadSymbol(name: "PyErr_Clear")

@MainActor let PyErr_Fetch: @convention(c) (
    UnsafeMutablePointer<PyObjectPointer?>,
    UnsafeMutablePointer<PyObjectPointer?>,
    UnsafeMutablePointer<PyObjectPointer?>) -> Void =
    PythonLibrary.loadSymbol(name: "PyErr_Fetch")

@MainActor let PyDict_New: @convention(c) () -> PyObjectPointer? =
    PythonLibrary.loadSymbol(name: "PyDict_New")

@MainActor let PyDict_Contains: @convention(c) (
    PyObjectPointer?, PyObjectPointer?) -> Int32 =
    PythonLibrary.loadSymbol(name: "PyDict_Contains")

@MainActor let PyDict_SetItem: @convention(c) (
    PyObjectPointer?, PyObjectPointer, PyObjectPointer) -> Void =
    PythonLibrary.loadSymbol(name: "PyDict_SetItem")

@MainActor let PyObject_GetItem: @convention(c) (
    PyObjectPointer, PyObjectPointer) -> PyObjectPointer? =
    PythonLibrary.loadSymbol(name: "PyObject_GetItem")

@MainActor let PyObject_SetItem: @convention(c) (
    PyObjectPointer, PyObjectPointer, PyObjectPointer) -> Void =
    PythonLibrary.loadSymbol(name: "PyObject_SetItem")

@MainActor let PyObject_DelItem: @convention(c) (
    PyObjectPointer, PyObjectPointer) -> Void =
    PythonLibrary.loadSymbol(name: "PyObject_DelItem")

@MainActor let PyObject_Call: @convention(c) (
    PyObjectPointer, PyObjectPointer,
    PyObjectPointer?) -> PyObjectPointer? =
    PythonLibrary.loadSymbol(name: "PyObject_Call")

@MainActor let PyObject_CallObject: @convention(c) (
    PyObjectPointer, PyObjectPointer) -> PyObjectPointer? =
    PythonLibrary.loadSymbol(name: "PyObject_CallObject")

@MainActor let PyObject_GetAttrString: @convention(c) (
    PyObjectPointer, PyCCharPointer) -> PyObjectPointer? =
    PythonLibrary.loadSymbol(name: "PyObject_GetAttrString")

@MainActor let PyObject_SetAttrString: @convention(c) (
    PyObjectPointer, PyCCharPointer, PyObjectPointer) -> Int32 =
    PythonLibrary.loadSymbol(name: "PyObject_SetAttrString")

@MainActor let PySlice_New: @convention(c) (
    PyObjectPointer?, PyObjectPointer?,
    PyObjectPointer?) -> PyObjectPointer? =
    PythonLibrary.loadSymbol(name: "PySlice_New")

@MainActor let PyTuple_New: @convention(c) (Int) -> PyObjectPointer? =
    PythonLibrary.loadSymbol(name: "PyTuple_New")

@MainActor let PyTuple_SetItem: @convention(c) (
    PyObjectPointer, Int, PyObjectPointer) -> Void =
    PythonLibrary.loadSymbol(name: "PyTuple_SetItem")

@MainActor let PyObject_RichCompare: @convention(c) (
    PyObjectPointer, PyObjectPointer, Int32) -> PyObjectPointer? =
    PythonLibrary.loadSymbol(name: "PyObject_RichCompare")

@MainActor let PyObject_RichCompareBool: @convention(c) (
    PyObjectPointer, PyObjectPointer, Int32) -> Int32 =
    PythonLibrary.loadSymbol(name: "PyObject_RichCompareBool")

@MainActor let PyDict_Next: @convention(c) (
    PyObjectPointer, UnsafeMutablePointer<Int>,
    UnsafeMutablePointer<PyObjectPointer?>,
    UnsafeMutablePointer<PyObjectPointer?>) -> Int32 =
    PythonLibrary.loadSymbol(name: "PyDict_Next")

@MainActor let PyIter_Next: @convention(c) (
    PyObjectPointer) -> PyObjectPointer? =
    PythonLibrary.loadSymbol(name: "PyIter_Next")

@MainActor let PyObject_GetIter: @convention(c) (
    PyObjectPointer) -> PyObjectPointer? =
    PythonLibrary.loadSymbol(name: "PyObject_GetIter")

@MainActor let PyList_New: @convention(c) (Int) -> PyObjectPointer? =
    PythonLibrary.loadSymbol(name: "PyList_New")

@MainActor let PyList_SetItem: @convention(c) (
    PyObjectPointer, Int, PyObjectPointer) -> Int32 =
    PythonLibrary.loadSymbol(name: "PyList_SetItem")

@MainActor let PyBool_FromLong: @convention(c) (Int) -> PyObjectPointer =
    PythonLibrary.loadSymbol(name: "PyBool_FromLong")

@MainActor let PyFloat_AsDouble: @convention(c) (PyObjectPointer) -> Double =
    PythonLibrary.loadSymbol(name: "PyFloat_AsDouble")

@MainActor let PyFloat_FromDouble: @convention(c) (Double) -> PyObjectPointer =
    PythonLibrary.loadSymbol(name: "PyFloat_FromDouble")

@MainActor let PyInt_AsLong: @convention(c) (PyObjectPointer) -> Int =
    PythonLibrary.loadSymbol(
        name: "PyLong_AsLong",
        legacyName: "PyInt_AsLong")

@MainActor let PyInt_FromLong: @convention(c) (Int) -> PyObjectPointer =
    PythonLibrary.loadSymbol(
        name: "PyLong_FromLong",
        legacyName: "PyInt_FromLong")

@MainActor let PyInt_AsUnsignedLongMask: @convention(c) (PyObjectPointer) -> UInt =
    PythonLibrary.loadSymbol(
        name: "PyLong_AsUnsignedLongMask",
        legacyName: "PyInt_AsUnsignedLongMask")

@MainActor let PyInt_FromSize_t: @convention(c) (UInt) -> PyObjectPointer =
    PythonLibrary.loadSymbol(
        name: "PyLong_FromUnsignedLong",
        legacyName: "PyInt_FromSize_t")

@MainActor let PyString_AsString: @convention(c) (PyObjectPointer) -> PyCCharPointer? =
    PythonLibrary.loadSymbol(
        name: "PyUnicode_AsUTF8",
        legacyName: "PyString_AsString")

@MainActor let PyString_FromStringAndSize: @convention(c) (
    PyCCharPointer?, Int) -> (PyObjectPointer?) =
    PythonLibrary.loadSymbol(
        name: "PyUnicode_DecodeUTF8",
        legacyName: "PyString_FromStringAndSize")

@MainActor let PyBytes_FromStringAndSize: @convention(c) (
    PyCCharPointer?, Int) -> (PyObjectPointer?) =
    PythonLibrary.loadSymbol(
        name: "PyBytes_FromStringAndSize",
        legacyName: "PyString_FromStringAndSize")

@MainActor let PyBytes_AsStringAndSize: @convention(c) (
    PyObjectPointer,
    UnsafeMutablePointer<UnsafeMutablePointer<CChar>?>?,
    UnsafeMutablePointer<Int>?) -> CInt =
    PythonLibrary.loadSymbol(
        name: "PyBytes_AsStringAndSize",
        legacyName: "PyString_AsStringAndSize")

@MainActor let _Py_ZeroStruct: PyObjectPointer =
    PythonLibrary.loadSymbol(name: "_Py_ZeroStruct")

@MainActor let _Py_TrueStruct: PyObjectPointer =
    PythonLibrary.loadSymbol(name: "_Py_TrueStruct")

@MainActor let PyBool_Type: PyObjectPointer =
    PythonLibrary.loadSymbol(name: "PyBool_Type")

@MainActor let PySlice_Type: PyObjectPointer =
    PythonLibrary.loadSymbol(name: "PySlice_Type")

@MainActor let PyNumber_Add: PyBinaryOperation =
    PythonLibrary.loadSymbol(name: "PyNumber_Add")

@MainActor let PyNumber_Subtract: PyBinaryOperation =
    PythonLibrary.loadSymbol(name: "PyNumber_Subtract")

@MainActor let PyNumber_Multiply: PyBinaryOperation =
    PythonLibrary.loadSymbol(name: "PyNumber_Multiply")

@MainActor let PyNumber_TrueDivide: PyBinaryOperation =
    PythonLibrary.loadSymbol(name: "PyNumber_TrueDivide")

@MainActor let PyNumber_InPlaceAdd: PyBinaryOperation =
    PythonLibrary.loadSymbol(name: "PyNumber_InPlaceAdd")

@MainActor let PyNumber_InPlaceSubtract: PyBinaryOperation =
    PythonLibrary.loadSymbol(name: "PyNumber_InPlaceSubtract")

@MainActor let PyNumber_InPlaceMultiply: PyBinaryOperation =
    PythonLibrary.loadSymbol(name: "PyNumber_InPlaceMultiply")

@MainActor let PyNumber_InPlaceTrueDivide: PyBinaryOperation =
    PythonLibrary.loadSymbol(name: "PyNumber_InPlaceTrueDivide")

@MainActor let PyNumber_Negative: PyUnaryOperation =
    PythonLibrary.loadSymbol(name: "PyNumber_Negative")

@MainActor let PyNumber_And: PyBinaryOperation =
    PythonLibrary.loadSymbol(name: "PyNumber_And")

@MainActor let PyNumber_Or: PyBinaryOperation =
    PythonLibrary.loadSymbol(name: "PyNumber_Or")

@MainActor let PyNumber_Xor: PyBinaryOperation =
    PythonLibrary.loadSymbol(name: "PyNumber_Xor")

@MainActor let PyNumber_InPlaceAnd: PyBinaryOperation =
    PythonLibrary.loadSymbol(name: "PyNumber_InPlaceAnd")

@MainActor let PyNumber_InPlaceOr: PyBinaryOperation =
    PythonLibrary.loadSymbol(name: "PyNumber_InPlaceOr")

@MainActor let PyNumber_InPlaceXor: PyBinaryOperation =
    PythonLibrary.loadSymbol(name: "PyNumber_InPlaceXor")

@MainActor let PyNumber_Invert: PyUnaryOperation =
    PythonLibrary.loadSymbol(name: "PyNumber_Invert")
