<?php

namespace App\Traits\Helpers;
trait ResponseHelperTrait
{
    /**
     * Function to construct response object to return to GUI
     * @param error     true|false
     * @param message   string
     * @param status    $status (400, for validation error, 401 for senarios
     *                  error, 200 for success )
     * @param data      data is array for gettong response data
     * @return array
     */
    public static function constructResponse($error,$message,$status,$data)
    {
        $responseArray = [];

        $responseArray['error'] = $error;
        $responseArray['message'] = $message;
        $responseArray['status']= $status;
        $responseArray['data'] = $data;
        return $responseArray;
    }

    
}
