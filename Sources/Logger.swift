//
//  Logger.swift
//  PetiteLogger
//
//  Created by Joachim Deelen on 01.06.20.
//  Copyright © 2019 micabo-software UG. All rights reserved.
//

import Foundation

public protocol LoggerImpl: class {

    /// log something generally unimportant (lowest priority)
    static func verbose(_ message: @autoclosure () -> Any, _ file: String, _ function: String, line: Int, context: Any?)

    /// log something which help during debugging (low priority)
    static func debug(_ message: @autoclosure () -> Any, _ file: String, _ function: String, line: Int, context: Any?)

    /// log something which you are really interested but which is not an issue or error (normal priority)
    static func info(_ message: @autoclosure () -> Any, _ file: String, _ function: String, line: Int, context: Any?)

    /// log something which may cause big trouble soon (high priority)
    static func warning(_ message: @autoclosure () -> Any, _ file: String, _ function: String, line: Int, context: Any?)

    /// log something which will keep you awake at night (highest priority)
    static func error(_ message: @autoclosure () -> Any, _ file: String, _ function: String, line: Int, context: Any?)
}

open class Logger: LoggerImpl {

	public class var loggerImpl: LoggerImpl.Type {
		get {
			guard let loggerImpl = _loggerImpl else { return defaultLoggerImpl }
			return loggerImpl
		}
		set {
			_loggerImpl = newValue
		}
	}

	static private var _loggerImpl: LoggerImpl.Type? = nil

	static private let defaultLoggerImpl: LoggerImpl.Type = DefaultLoggerImpl.self

	public class func verbose(_ message: @autoclosure () -> Any, _	file: String = #file, _ function: String = #function, line: Int = #line, context: Any? = nil) {
		loggerImpl.verbose(message(), file, function, line: line, context: context)
	}

    /// log something which help during debugging (low priority)
	public class func debug(_ message: @autoclosure () -> Any, _ file: String = #file, _ function: String = #function, line: Int = #line, context: Any? = nil) {
		loggerImpl.debug(message(), file, function, line: line, context: context)
	}

    /// log something which you are really interested but which is not an issue or error (normal priority)
	public class func info(_ message: @autoclosure () -> Any, _ file: String = #file, _ function: String = #function, line: Int = #line, context: Any? = nil) {
		loggerImpl.info(message(), file, function, line: line, context: context)
	}

    /// log something which may cause big trouble soon (high priority)
	public class func warning(_ message: @autoclosure () -> Any, _ file: String = #file, _ function: String = #function, line: Int = #line, context: Any? = nil) {
		loggerImpl.warning(message(), file, function, line: line, context: context)
	}

    /// log something which will keep you awake at night (highest priority)
	public class func error(_ message: @autoclosure () -> Any, _ file: String = #file, _ function: String = #function, line: Int = #line, context: Any? = nil) {
		loggerImpl.error(message(), file, function, line: line, context: context)
	}
}

private class DefaultLoggerImpl: LoggerImpl {
	class func verbose(_ message: @autoclosure () -> Any, _	file: String = #file, _ function: String = #function, line: Int = #line, context: Any? = nil) {
		log("💜 VERBOSE", message(), file, function, line: line, context: context)
	}

    /// log something which help during debugging (low priority)
	open class func debug(_ message: @autoclosure () -> Any, _ file: String = #file, _ function: String = #function, line: Int = #line, context: Any? = nil) {
		log("💚 DEBUG", message(), file, function, line: line, context: context)
	}

    /// log something which you are really interested but which is not an issue or error (normal priority)
	open class func info(_ message: @autoclosure () -> Any, _ file: String = #file, _ function: String = #function, line: Int = #line, context: Any? = nil) {
		log("💙 INFO", message(), file, function, line: line, context: context)
	}

    /// log something which may cause big trouble soon (high priority)
	open class func warning(_ message: @autoclosure () -> Any, _ file: String = #file, _ function: String = #function, line: Int = #line, context: Any? = nil) {
		log("💛 WARNING", message(), file, function, line: line, context: context)
	}

    /// log something which will keep you awake at night (highest priority)
	open class func error(_ message: @autoclosure () -> Any, _ file: String = #file, _ function: String = #function, line: Int = #line, context: Any? = nil) {
		log("❤️ ERROR", message(), file, function, line: line, context: context)
	}

	private class func log(_ level: String, _ message: @autoclosure () -> Any, _ file: String = #file, _ function: String = #function, line: Int = #line, context: Any? = nil) {
		let file = file.split(separator: "/").last?.split(separator: ".").first ?? Substring(file)
		print("\(dateFormatter.string(from: Date())) \(level) \(file).\(function):\(line) \(message())")
	}

	static let dateFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "HH:mm:ss.SSS"
		return formatter
	}()
}
