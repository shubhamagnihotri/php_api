<?php

namespace App\Traits;
use GuzzleHttp\Client;
use Log;
use App\Exceptions\InvalidResponseStructureException;
use Session;
use Helper;

trait APITrait {

    /**
     * Calling Backend Micro service Helper method
     *
     * @param String $apiMethod Api method name
     * @param String $requestUrl Api URL
     * @param Array  $formData request data
     * @param Integer $authorization  0 means no authorized , 1 means authorized
     *
     */
    public function httpRequest($apiMethod, $requestUrl, $formData=array(), $authorization = 0)
    {
        $guzzleClient = new Client([
            'base_uri' => $this->baseUri,
            'exceptions' => false,
            'http_errors' => false,
            'verify' => false
        ]);

        $headerData['Content-Type'] = "application/json";

        if($authorization == 1) {
            $headerData['x-auth-token'] = Helper::getSessionToken();
        }
        try {
            $response = $guzzleClient->request($apiMethod, $requestUrl, ['headers' => $headerData, 'body' => json_encode($formData)]);
            if ($this->checkApiReponseStructure) {
                $responseArray = $this->checkAPIResponseStructure($response->getBody()->getContents());
                $responseData['body'] = $responseArray['body'];
                $responseData['type'] = $responseArray['type'];
                $responseData['status'] = $responseArray['status'];
            } else {
                $responseData['body'] = $apiResponseArray = json_decode($response->getBody()->getContents(), true);
                $responseData['status'] = $response->getStatusCode();
            }
        } catch (\Exception $e) {
            $responseData['body'] = [
                'message' => 'error.500',
                'content' => []
            ];
            $responseData['status'] = 500;
        }

        return $responseData;
    }

    /**
     * Function to check API response structure
     *
     * @param [array] $apiResponse
     * @return void
     */
    public function checkAPIResponseStructure($apiResponse)   {
        $expectedResponseStructure = config('app-config.apiResponseStructure');
        $apiResponseArray = json_decode($apiResponse , true);
        if(is_array($apiResponseArray)) {
            if(empty(array_diff_key($apiResponseArray, $expectedResponseStructure)) && empty(array_diff_key($expectedResponseStructure, $apiResponseArray))) {
                return $apiResponseArray;
            }
        }
        echo '<pre>';print_r($apiResponse);exit;
        Log::info('InvalidResponseStructureException => '. print_r($apiResponse, true));
        throw new InvalidResponseStructureException;
    }
}
