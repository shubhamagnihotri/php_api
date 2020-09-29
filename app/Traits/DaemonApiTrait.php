<?php

namespace App\Traits;

use GuzzleHttp\Client;
use App\Exceptions\InvalidResponseStructureException;
use Session;
use Helper;
use Log;

trait DaemonApiTrait
{

    /**
     * Calling NTTPC Daemon API
     *
     * @param String $apiMethod Api method name
     * @param String $requestUrl Api URL
     * @param Array  $formData request data
     * @param Integer $authorization  0 means no authorized , 1 means authorized
     *
     */
    public function daemonHttpRequest($formData = array(), $apiMethod = 'POST', $requestUrl = '')
    {
        $guzzleClient = new Client([
            'base_uri' => $this->baseUri,
            'exceptions' => false,
            'http_errors' => false,
            'verify' => false,
        ]);

        $authParams = [config('app-config.daemon_id'), config('app-config.daemon_password')];
        try {
            $response = $guzzleClient->request($apiMethod, $requestUrl, ['auth' => $authParams, 'form_params' => $formData]);
            $responseArray['status'] = $response->getStatusCode();
            $responseArray['content'] = $response->getBody()->getContents();
            Log::info(['formData' => $formData, 'response' => $responseArray]);
        } catch (\Exception $e) {
            $responseArray['body'] = [
                'message' => 'error.500',
                'content' => []
            ];
            $responseArray['status'] = 500;
        }

        return $responseArray;
    }

    /**
     * Function to get Daemon API response type
     *
     * @param Array $reponse
     * @return void
     */
    public function getDaemonApiResponseType($reponse)
    {
        if ($reponse['status'] == 200 && $reponse['content'] == 0) {
            return 'success';
        }
        return 'failure';
    }
}
