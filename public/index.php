<?php

use GuzzleHttp\Psr7\ServerRequest;
use Moon\Moon\AppFactory;

require __DIR__ . '/../bootstrap/app.php';

(function () {
    $container = require __DIR__ . '/../bootstrap/container.php';
    $app = AppFactory::buildFromContainer($container);
    $router = new \Moon\Moon\Router();
    $router->get('/[{name}]', function (ServerRequest $request) {

        return "Hello {$request->getAttribute('name', 'World')}";
    });
    $app->run($router->pipelines());
})();