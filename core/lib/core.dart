library core;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core/interceptor/app_interceptor.dart';
import 'package:core/interceptor/token_interceptor.dart';
import 'package:data/api/api.dart';
import 'package:data/repositories/repositories.dart';
import 'package:dio/dio.dart';
import 'package:domain/api/api.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_android/shared_preferences_android.dart';
import 'package:shared_preferences_ios/shared_preferences_ios.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'app_logger/app_logger.dart';
part 'base_bloc/base_bloc.dart';
part 'base_bloc/internet_connection_helper.dart';
part 'di/di.dart';
part 'exceptions/exceptions.dart';
part 'resources/core_constants.dart';
part 'resources/list_extension.dart';
