import '../extensions_services.dart';
import 'package:example/app/controllers/home/home_controller.dart';

/// Generated by Karee 

extension HomeControllerExtension on HomeController {
	static late final HomeController? service;
	static bool loaded = false;
	void init(){
		HomeControllerExtension.service = this;
		HomeControllerExtension.loaded = true;
		userService = serviceExtensions['UserService']();
		otherService = serviceExtensions['OtherService']();
		parameterService = serviceExtensions['ParameterService']();
	}
	HomeController get self {
		init();
		return this;
	}
}

HomeController get $extendedHomeController {
	if(!HomeControllerExtension.loaded){
		HomeController().self;
	}	return HomeControllerExtension.service!;
}