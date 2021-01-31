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
    public function handle($request, Closure $next,$role_type)
    {
        
    
        if(!$request->header('Authorization')){
            return response()->json(['error' => true,'message'=>'Unauthorized','status'=>402,'data'=>[]], 400);
        }
        $header = explode(" ",$request->header('Authorization'));
        $tokenExist =  UserSession::where('token',$header[count($header)-1])->first();
        if(!$tokenExist){
            // return response()->json(['error' => true,'message'=>'Unauthorized','status'=>402,'data'=>[]]);
            return response()->json(['error' => true,'message'=>'Unauthorized','status'=>402,'data'=>[]], 400);
        }
        if(auth()->user()){
            $user = auth()->user();
            $role = UserRole::select('user_roles.role_id','roles.role_name')->
            join('roles','user_roles.role_id','roles.id')->where('user_id',$user->id)->get();
            $user->role = $role;
            if($role[0]->role_id != $role_type){
                return response()->json(['error' => true,'message'=>'Unauthorized','status'=>402,'data'=>[]], 400);
            }
            $request->user = $user;
            $request->token = $header[count($header)-1];
        }else{
            // return response()->json(['error' => true,'message'=>'Unauthorized','status'=>402,'data'=>[]]);
            return response()->json(['error' => true,'message'=>'Unauthorized','status'=>402,'data'=>[]], 400);
           
        }
        return $next($request);
    }
}
