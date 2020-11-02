<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Support\Facades\Auth;
use App\Models\UserSession;
use App\Models\UserRole;
use App\Helpers\CustomHelper as Helper;
class authUser
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    {
    
        if(!$request->header('Authorization')){
            return response()->json(['error' => true,'message'=>'Unauthorized','status'=>402,'data'=>[]]);
        }
        $header = explode(" ",$request->header('Authorization'));
        $tokenExist =  UserSession::where('token',$header[count($header)-1])->first();
        if(!$tokenExist){
            // return response()->json(['error' => true,'message'=>'Unauthorized','status'=>402,'data'=>[]]);
            return response()->json(['error' => true,'message'=>'Unauthorized','status'=>402,'data'=>[]], 401);
        }
        if(auth()->user()){
            $user = auth()->user();
            $role = UserRole::select('user_roles.role_id','roles.role_name')->
            join('roles','user_roles.role_id','roles.id')->where('user_id',$user->id)->get();
            $user->role = $role;
            $request->user = $user;
            $request->token = $header[count($header)-1];
        }else{
            // return response()->json(['error' => true,'message'=>'Unauthorized','status'=>402,'data'=>[]]);
            return response()->json(['error' => true,'message'=>'Unauthorized','status'=>402,'data'=>[]], 401);
           
        }
        return $next($request);
    }
}
