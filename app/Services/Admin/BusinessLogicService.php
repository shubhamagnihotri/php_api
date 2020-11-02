<?php
namespace App\Services\Admin;
use App\Models\Consultant;
use App\Models\User;
use App\Models\Files;
use App\Models\QuesAnswerConsultant;
use App\Models\ConsultationProducts;
use App\Models\ConsultationNotes;
use App\Helpers\CustomHelper as Helper;
use Illuminate\Support\Facades\DB;
class BusinessLogicService
{
    public function __construct()
    {
    }

    public function getConsultationQueue($formData){
        $Consultant = Consultant::select('consultations.*','users.fname','users.lname','users.email','users.ethinicity')->join('users','users.id','consultations.user_id')
        ->where('consultations.consultant_status',$formData['consultantion_status'])->orderBy('consultations.id','desc');
        if(isset($formData['search_by_text'])){
            $Consultant= $Consultant->where('users.fname','like','%'.$formData['search_by_text'].'%')
            ->orWhere('users.lname','like','%'.$formData['search_by_text'].'%')
            ->orWhere('consultations.id','like','%'.$formData['search_by_text'].'%');
        }
        if(isset($formData['page'])){
          
            $start_limit = ($formData['page'])*$formData['no_of_record'];
            $Consultant = $Consultant->offset($start_limit)->limit($formData['no_of_record']);
        }
        $Consultant=$Consultant->get();
        $count =Consultant::join('users','users.id','consultations.user_id')
        ->where('consultations.consultant_status',$formData['consultantion_status'])->orderBy('consultations.id','desc')->get()->count();
        
        return Helper::constructResponse(false,'',200,['Consultant'=>$Consultant,'count'=>$count]);
    }

    public function getConsultationFullDetail($id){
        Consultant::where('id',$id)->where('consultant_status',1)->update([
            'consultant_status'=>2
        ]);
        $Consultant = DB::table('consultations')->select('consultations.*','users.fname','users.lname','users.email','users.ethinicity','users.gender','country_states.state_name','countries.country_name','users.zip_code')->join('users','users.id','consultations.user_id')->join('countries','users.country','countries.id')->join('country_states','country_states.id','users.state')
        ->where('consultations.id',$id)->orderBy('consultations.id','desc')->first();
        if( isset($Consultant->id)){
           $files= Files::where('consultation_id',$Consultant->id)->get();
           $Consultant->files=$files;
           $Consultant->ques_answer=array();
           $get_ques_answer_of_consultation = QuesAnswerConsultant::where('consultant_id',$Consultant->id)->orderBy('ques_id','asc')->orderBy('option_id','asc')->get();
           $index =0;
           foreach($get_ques_answer_of_consultation as $a=>$value){
               $is_present = false;
            if(count($Consultant->ques_answer) > 0){
                foreach($Consultant->ques_answer as $key=>$ques_ans){
                    if(array_search($value['ques_id'],$ques_ans)){
                        $is_present = true;
                       $Consultant->ques_answer[$key]['ques_answer'][] = $value['answer_for_admin'];
                    }
                  }
                  if(!$is_present){
                      $Consultant->ques_answer[$index]= array('ques_id'=>$value['ques_id'],
                    'ques_title'=>$value['question_for_admin'],'ques_answer'=>[$value['answer_for_admin']]);
                  }
                  $index++;
             }else{
                $Consultant->ques_answer= array(array('ques_id'=>$value['ques_id'],
                'ques_title'=>$value['question_for_admin'],'ques_answer'=>[$value['answer_for_admin']]));
             }
           }
        }else{
            $Consultant['files']=[];
            $Consultant['ques_answer']=[];
        }
        return Helper::constructResponse(false,'',200,['Consultant'=>$Consultant]);
    }

    public function generateCar($formdata,$id){
        $consultation = Consultant::where('id',$id)->first(); 
        if($consultation->consultant_status == '3'){
            return Helper::constructResponse(true,'Car already generated',401,[]);
        }
        if($consultation->consultant_status == '0'){
            return Helper::constructResponse(true,'Consulation deatils not submitted successfully',401,[]);
        }
        $generate_car = Consultant::where('id',$id)->update([
            'car_report_response'=>$formdata['car_report_response'],
            'car_admin_remarks'=>$formdata['car_admin_remarks'],
            'consultant_status'=>3
        ]);
        // dd($form['products'] && count($form['products']) > 0);
        if(isset($formdata['products']) && count($formdata['products']) > 0){
         
            $form_prodcuts = $formdata['products'];
            ConsultationProducts::where('consulation_id',$id)->delete();
            foreach($form_prodcuts as $form_product){
                $product = new ConsultationProducts();
                $product->consulation_id = $id;
                $product->product_id = $form_product; 
                $product->save();
            }
        }
        if($generate_car){
            return Helper::constructResponse(false,'Car generated successfully',401,[]);
        }else{
            return Helper::constructResponse(false,'Car not generated successfully',401,[]);
        }
    }

    public function addConsultationNotes($formdata,$id){
        $inserted_data = [
            'consultation_id'=>$id,
            'note_type'=>$formdata['note_type'],
            'condition_id'=>$formdata['condition_id'],
            'consultation_note'=>$formdata['consultation_note'],
        ];
        ConsultationNotes::insert($inserted_data);
        return Helper::constructResponse(false,'Notes added successfully',401,[]);
    }


}
