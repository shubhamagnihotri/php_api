<?php

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class QuestionaireTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
       
        $this->run_ques();
        
        $this->run_ques_options();
    }
    public function run_ques(){
        DB::table('ques')->delete();
        DB::table('ques')->insert([
            ['id' => 1,'ques_title'=>'Do you spend more than 25 hours a week in working in any of these occupations?','ques_option_type'=>1,'ques_ordering_id'=>1,'ques_parent_option_id'=>0,'is_sub_question'=>0,'ques_status'=>1],
            ['id' => 2,'ques_title'=>'How long has your concern existed?','ques_option_type'=>1,'ques_ordering_id'=>2,'ques_parent_option_id'=>0,'is_sub_question'=>0,'ques_status'=>1],
            ['id' => 3,'ques_title'=>'How would you describe the amount of hair shedding your experience?','ques_option_type'=>1,'ques_ordering_id'=>3,'ques_parent_option_id'=>0,'is_sub_question'=>0,'ques_status'=>1],
            //question 4
            ['id' => 4,'ques_title'=>'How much time do you spend on scalp care?','ques_option_type'=>1,'ques_ordering_id'=>4,'ques_parent_option_id'=>0,'is_sub_question'=>0,'ques_status'=>1],
             //question 5
             ['id' => 5,'ques_title'=>'Have you had any hair or scalp diagnoses from a hair transplant surgeon, dermatologist specializing in scalp or hair?','ques_option_type'=>1,'ques_ordering_id'=>5,'ques_parent_option_id'=>0,'is_sub_question'=>0,'ques_status'=>1],

            //question 5 (1)
            ['id' => 6,'ques_title'=>'What information are you hoping to leave with today?','ques_option_type'=>1,'ques_ordering_id'=>6,'ques_parent_option_id'=>0,'is_sub_question'=>0,'ques_status'=>1],

            //question 5 (label Information (Marketing))
            ['id' => 7,'ques_title'=>'On selecting Option -1 User will redirected to here 
            where they can see the static content','ques_option_type'=>4,'ques_ordering_id'=>7,'ques_parent_option_id'=>23,'is_sub_question'=>0,'ques_status'=>1],

            //question 5 (!!!)
            ['id' => 8,'ques_title'=>'Select to continue for personalization consultation','ques_option_type'=>1,'ques_ordering_id'=>8,'ques_parent_option_id'=>25,'is_sub_question'=>0,'ques_status'=>1],

             //question 5 (5)
            ['id' => 9,'ques_title'=>'Please select CAR.','ques_option_type'=>5,'ques_ordering_id'=>9,'ques_parent_option_id'=>27,'is_sub_question'=>1,'ques_status'=>1],

            //question 5 (5)
            ['id' => 10,'ques_title'=>'Please select CAR.','ques_option_type'=>5,'ques_ordering_id'=>10,'ques_parent_option_id'=>29,'is_sub_question'=>1,'ques_status'=>1],

            //question 5 (5)
            ['id' => 11,'ques_title'=>'Please select CAR.','ques_option_type'=>5,'ques_ordering_id'=>11,'ques_parent_option_id'=>30,'is_sub_question'=>1,'ques_status'=>1],

            //question 5 (5)
            ['id' => 12,'ques_title'=>'Select your concern','ques_option_type'=>1,'ques_ordering_id'=>12,'ques_parent_option_id'=>30,'is_sub_question'=>1,'ques_status'=>1],

            //question 13
            ['id' => 13,'ques_title'=>'On selecting Option -1 User will redirected to here 
            where they can see the static content','ques_option_type'=>1,'ques_ordering_id'=>13,'ques_parent_option_id'=>31,'is_sub_question'=>0,'ques_status'=>1],
            
            //question 14
            ['id' => 14,'ques_title'=>'How would you describe the condition of your scalp? 
            Please check all that apply.','ques_option_type'=>1,'ques_ordering_id'=>14,'ques_parent_option_id'=>32,'is_sub_question'=>0,'ques_status'=>1],

            //question 15 conition ques ((Female true))
            ['id' => 15,'ques_title'=>'What is the location on scalp?','ques_option_type'=>1,'ques_ordering_id'=>15,'ques_parent_option_id'=>0,'is_sub_question'=>0,'ques_status'=>1],

            //question 16 conition ques ((Female false))
            ['id' => 16,'ques_title'=>'What is the location on scalp?','ques_option_type'=>1,'ques_ordering_id'=>16,'ques_parent_option_id'=>0,'is_sub_question'=>0,'ques_status'=>1],

       
            ['id' => 17,'ques_title'=>'Have you had a biopsy or culture performed by a dermatologist or medical professional with a positive diagnosis?','ques_option_type'=>1,'ques_ordering_id'=>17,'ques_parent_option_id'=>56,'is_sub_question'=>0,'ques_status'=>1],

            
            // question 18 sub question
            ['id' => 18,'ques_title'=>'Please check all that apply.','ques_option_type'=>1,'ques_ordering_id'=>18,'ques_parent_option_id'=>56,'is_sub_question'=>1,'ques_status'=>1],

            // question 19 option based new question
            ['id' => 19,'ques_title'=>'Select case type.','ques_option_type'=>1,'ques_ordering_id'=>19,'ques_parent_option_id'=>33,'is_sub_question'=>0,'ques_status'=>1],

            // question 20 option based new question
            ['id' => 20,'ques_title'=>'','ques_option_type'=>1,'ques_ordering_id'=>20,'ques_parent_option_id'=>68,'is_sub_question'=>1,'ques_status'=>1],

            // question 21 option based new question
            ['id' => 21,'ques_title'=>'','ques_option_type'=>1,'ques_ordering_id'=>21,'ques_parent_option_id'=>71,'is_sub_question'=>1,'ques_status'=>1],
            
            // question 22 conition ques ((Female true))
            ['id' => 22,'ques_title'=>'What is the location on scalp?','ques_option_type'=>1,'ques_ordering_id'=>22,'ques_parent_option_id'=>0,'is_sub_question'=>0,'ques_status'=>1],

            //question 23 conition ques ((Female false))
            ['id' => 23,'ques_title'=>'What is the location on scalp?','ques_option_type'=>1,'ques_ordering_id'=>23,'ques_parent_option_id'=>0,'is_sub_question'=>0,'ques_status'=>1],

            //question 24 conition ques ((Female false))
            ['id' => 24,'ques_title'=>'Select case type.','ques_option_type'=>1,'ques_ordering_id'=>24,'ques_parent_option_id'=>33,'is_sub_question'=>0,'ques_status'=>1],

            //question 25
            ['id' => 25,'ques_title'=>'Select case type.','ques_option_type'=>1,'ques_ordering_id'=>25,'ques_parent_option_id'=>34,'is_sub_question'=>0,'ques_status'=>1],

             //question 26
             ['id' => 26,'ques_title'=>'Select Extreme case type','ques_option_type'=>1,'ques_ordering_id'=>26,'ques_parent_option_id'=>80,'is_sub_question'=>0,'ques_status'=>1], 
            //question 27 (male)
             ['id' => 27,'ques_title'=>'What is the location on scalp?','ques_option_type'=>1,'ques_ordering_id'=>27,'ques_parent_option_id'=>0,'is_sub_question'=>0,'ques_status'=>1],
            //question 28 (female)
            ['id' => 28,'ques_title'=>'What is the location on scalp?','ques_option_type'=>1,'ques_ordering_id'=>27,'ques_parent_option_id'=>0,'is_sub_question'=>0,'ques_status'=>1],
            //question 29
            ['id' => 29,'ques_title'=>'Select Nominal case type','ques_option_type'=>1,'ques_ordering_id'=>28,'ques_parent_option_id'=>83,'is_sub_question'=>0,'ques_status'=>1],
            //question 30
            ['id' => 30,'ques_title'=>'Dry Brittle ends?','ques_option_type'=>1,'ques_ordering_id'=>30,'ques_parent_option_id'=>88,'is_sub_question'=>1,'ques_status'=>1],
            //question 31
            ['id' => 31,'ques_title'=>'','ques_option_type'=>1,'ques_ordering_id'=>31,'ques_parent_option_id'=>89,'is_sub_question'=>1,'ques_status'=>1],
            //question 32
            ['id' => 32,'ques_title'=>'Pleases select which best describes your hair porosity','ques_option_type'=>1,'ques_ordering_id'=>32,'ques_parent_option_id'=>94,'is_sub_question'=>1,'ques_status'=>1],
            //question 33
            ['id' => 33,'ques_title'=>'','ques_option_type'=>1,'ques_ordering_id'=>33,'ques_parent_option_id'=>94,'is_sub_question'=>1,'ques_status'=>1],
            //question 34
            ['id' => 34,'ques_title'=>'','ques_option_type'=>1,'ques_ordering_id'=>34,'ques_parent_option_id'=>91,'is_sub_question'=>1,'ques_status'=>1],
            //question 35
            ['id' => 35,'ques_title'=>'Are you still breast feeding?','ques_option_type'=>1,'ques_ordering_id'=>35,'ques_parent_option_id'=>102,'is_sub_question'=>1,'ques_status'=>1],
            //question 36
            ['id' => 36,'ques_title'=>'Length of time you have been breast feeding?','ques_option_type'=>3,'ques_ordering_id'=>36,'ques_parent_option_id'=>104,'is_sub_question'=>1,'ques_status'=>1],
           
        ]);
     
    }

    public function run_ques_options(){
        DB::table('ques_options')->delete();
        DB::table('ques_options')->insert([
            // question 1
            ['id' => 1,'option_title'=>'Athlete','option_ques_id'=>1,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 2,'option_title'=>'Business Professional','option_ques_id'=>1,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 3,'option_title'=>'Construction','option_ques_id'=>1,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 4,'option_title'=>'Landscaping','option_ques_id'=>1,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 5,'option_title'=>'Medical','option_ques_id'=>1,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 6,'option_title'=>'Outdoor Environments','option_ques_id'=>1,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 7,'option_title'=>'Outdoor Environments','option_ques_id'=>1,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 8,'option_title'=>'Public Figure','option_ques_id'=>1,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],

            // question 2
            ['id' => 9,'option_title'=>'Recently','option_ques_id'=>2,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 10,'option_title'=>'0-6 Months','option_ques_id'=>2,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 11,'option_title'=>'6-18 Months','option_ques_id'=>2,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 12,'option_title'=>'Over 2 Years','option_ques_id'=>2,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 13,'option_title'=>'Decades','option_ques_id'=>2,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],

            //question 3 
            ['id' => 14,'option_title'=>'Nominal','option_ques_id'=>3,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 15,'option_title'=>'Nominal to Mild','option_ques_id'=>3,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 16,'option_title'=>'Occasionally More Than Nominal to Mild','option_ques_id'=>3,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 17,'option_title'=>'Excessive','option_ques_id'=>3,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            //question 4
            ['id' => 18,'option_title'=>'None at All','option_ques_id'=>4,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 19,'option_title'=>'1-3 Times a Month','option_ques_id'=>4,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 20,'option_title'=>'Weekly','option_ques_id'=>4,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            
            //question 5
            ['id' => 21,'option_title'=>'Yes','option_ques_id'=>5,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 22,'option_title'=>'No','option_ques_id'=>5,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],

            //question 6
            ['id' => 23,'option_title'=>'Information (Marketing)','option_ques_id'=>6,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],

            ['id' => 24,'option_title'=>'Purchase Products','option_ques_id'=>6,'option_status'=>1,'option_link'=>'https://www.dtdc.in/tracking/tracking_results.asp','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],

            ['id' => 25,'option_title'=>'Purchase Personalized Consultation','option_ques_id'=>6,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],

            ['id' => 26,'option_title'=>'New Client Purchase','option_ques_id'=>6,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],

            ['id' => 27,'option_title'=>'Purchase Follow Up Appointment ','option_ques_id'=>6,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],

             //question 8
             ['id' => 28,'option_title'=>'Create a New Consultation Analysis Report (CAR)','option_ques_id'=>8,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
             ['id' => 29,'option_title'=>'Use an Existing Consultation Analysis Report (CAR)','option_ques_id'=>8,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
             ['id' => 30,'option_title'=>'Follow up Consultation Analysis Report (CAR)','option_ques_id'=>8,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],

            //question 12
            ['id' => 31,'option_title'=>'Prevention','option_ques_id'=>12,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 32,'option_title'=>'Scalp Concern','option_ques_id'=>12,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 33,'option_title'=>'Hair Thining Concern','option_ques_id'=>12,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 34,'option_title'=>'Hair Loss Concern','option_ques_id'=>12,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
         
            //question 14
            ['id' => 35,'option_title'=>'Tight and Flaky (Capitis)','option_ques_id'=>14,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>1,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],

            ['id' => 36,'option_title'=>'Congested with Build up (Steoides)','option_ques_id'=>14,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>1,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],

            ['id' => 37,'option_title'=>'Itchy','option_ques_id'=>14,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>1,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],

            ['id' => 38,'option_title'=>'Bleeding','option_ques_id'=>14,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>1,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],

            ['id' => 39,'option_title'=>'Sores','option_ques_id'=>14,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>1,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],

            ['id' => 40,'option_title'=>'Smell','option_ques_id'=>14,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>1,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            
            ['id' => 41,'option_title'=>'Scabs','option_ques_id'=>14,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>1,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 42,'option_title'=>'Redness/Irritation','option_ques_id'=>14,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>1,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 43,'option_title'=>'Balanced and Healthy','option_ques_id'=>14,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>1,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],

            // question 14  (condition question (Female true) )
            ['id' => 44,'option_title'=>'Normal','option_ques_id'=>15,'option_status'=>1,'option_link'=>'','option_image'=>'image.///','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 45,'option_title'=>'Type I','option_ques_id'=>15,'option_status'=>1,'option_link'=>'','option_image'=>'image.///','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 46,'option_title'=>'Type II','option_ques_id'=>15,'option_status'=>1,'option_link'=>'','option_image'=>'image.///','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 47,'option_title'=>'Type III','option_ques_id'=>15,'option_status'=>1,'option_link'=>'','option_image'=>'image.///','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],

            // question 15  (condition question (Female false) )
            
            ['id' => 48,'option_title'=>'Type I','option_ques_id'=>16,'option_status'=>1,'option_link'=>'','option_image'=>'image.///','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            
            ['id' => 49,'option_title'=>'Type II','option_ques_id'=>16,'option_status'=>1,'option_link'=>'','option_image'=>'image.///','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
           
            ['id' => 50,'option_title'=>'Type III','option_ques_id'=>16,'option_status'=>1,'option_link'=>'','option_image'=>'image.///','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            
            ['id' => 51,'option_title'=>'Type IV','option_ques_id'=>16,'option_status'=>1,'option_link'=>'','option_image'=>'image.///','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
           
            ['id' => 52,'option_title'=>'Type V','option_ques_id'=>16,'option_status'=>1,'option_link'=>'','option_image'=>'image.///','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 53,'option_title'=>'Type VI','option_ques_id'=>16,'option_status'=>1,
            'option_link'=>'','option_image'=>'image.///','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            
            ['id' => 54,'option_title'=>'Type VII','option_ques_id'=>16,'option_status'=>1,'option_link'=>'','option_image'=>'image.///','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            
            ['id' => 55,'option_title'=>'Type VIII','option_ques_id'=>16,'option_status'=>1,'option_link'=>'','option_image'=>'image.///','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            
            //question 17
               
            ['id' => 56,'option_title'=>'Yes','option_ques_id'=>17,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 57,'option_title'=>'No','option_ques_id'=>17,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],

            // question 18 
            ['id' => 58,'option_title'=>'Alopecia','option_ques_id'=>18,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 59,'option_title'=>'Any Scalp Bacterial or Fungus','option_ques_id'=>18,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 60,'option_title'=>'Dermatitis','option_ques_id'=>18,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 61,'option_title'=>'Eczema','option_ques_id'=>18,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 62,'option_title'=>'Psoriasis','option_ques_id'=>18,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 63,'option_title'=>'Trichotillomania','option_ques_id'=>18,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 64,'option_title'=>'Folliculitis','option_ques_id'=>18,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 65,'option_title'=>'Lichen Planus Undiagnosed Microbiome Imbalances','option_ques_id'=>18,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 66,'option_title'=>'Dandruff Steaoides','option_ques_id'=>18,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 67,'option_title'=>'Dandruff Steaoides','option_ques_id'=>18,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            // question 19 option based new question

            ['id' => 68,'option_title'=>'Extreme','option_ques_id'=>19,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 69,'option_title'=>'Moderately Extreme','option_ques_id'=>19,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>1,'option_condition_true_next_question_id'=>27,'option_condition_false_next_question_id'=>28],
            ['id' => 70,'option_title'=>'Low Extreme','option_ques_id'=>19,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>1,'option_condition_true_next_question_id'=>27,'option_condition_false_next_question_id'=>28],
            ['id' => 71,'option_title'=>'Nominal','option_ques_id'=>19,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            // question 20 option based new question
            ['id' => 72,'option_title'=>'Hormonal','option_ques_id'=>20,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>1,'option_condition_true_next_question_id'=>22,'option_condition_false_next_question_id'=>23],
      
             ['id' => 73,'option_title'=>'Scalp condition','option_ques_id'=>20,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>1,'option_condition_true_next_question_id'=>22,'option_condition_false_next_question_id'=>23],
             ['id' => 74,'option_title'=>'Disrupted Microbiome','option_ques_id'=>20,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>1,'option_condition_true_next_question_id'=>22,'option_condition_false_next_question_id'=>23],

            // question 21 option based new question
            ['id' => 75,'option_title'=>'Drastic diet /medication/internal change','option_ques_id'=>21,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>1,'option_condition_true_next_question_id'=>22,'option_condition_false_next_question_id'=>23],
            ['id' => 76,'option_title'=>'Hair Styling Habits','option_ques_id'=>21,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>1,'option_condition_true_next_question_id'=>22,'option_condition_false_next_question_id'=>23],
            ['id' => 77,'option_title'=>'Sudden Medical Emergency','option_ques_id'=>21,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>1,'option_condition_true_next_question_id'=>22,'option_condition_false_next_question_id'=>23],
            ['id' => 78,'option_title'=>'Pregnancy','option_ques_id'=>21,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>1,'option_condition_true_next_question_id'=>22,'option_condition_false_next_question_id'=>23],
            ['id' => 79,'option_title'=>'Stress','option_ques_id'=>21,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>1,'option_condition_true_next_question_id'=>22,'option_condition_false_next_question_id'=>23],
            // question 80 
            ['id' => 80,'option_title'=>'Extreme','option_ques_id'=>25,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 81,'option_title'=>'Moderately Extreme','option_ques_id'=>25,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>1,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 82,'option_title'=>'Low Extreme','option_ques_id'=>25,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>1,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 83,'option_title'=>'Nominal','option_ques_id'=>25,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
             // question 81 
            ['id' => 84,'option_title'=>'Androgenic','option_ques_id'=>26,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 85,'option_title'=>'Alopeicas','option_ques_id'=>26,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 86,'option_title'=>'Central Centrifugal Cicatricial Alopecia concern','option_ques_id'=>26,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            // question 29
            ['id' => 87,'option_title'=>'Stressful Moments in Life Concerns','option_ques_id'=>29,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>1,'option_condition_true_next_question_id'=>28,'option_condition_false_next_question_id'=>27],
            ['id' => 88,'option_title'=>'Hair Fiber Concerns','option_ques_id'=>29,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 89,'option_title'=>'Hair Porosity Concerns','option_ques_id'=>29,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 90,'option_title'=>'Chemically Treated','option_ques_id'=>29,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 91,'option_title'=>'Protective Style Hair Damage','option_ques_id'=>29,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 92,'option_title'=>'Post Partum Concerns','option_ques_id'=>29,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            // question 30 
            ['id' => 93,'option_title'=>'Yes','option_ques_id'=>29,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
           
             // question 31 
             ['id' => 94,'option_title'=>'Yes','option_ques_id'=>31,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
             ['id' => 95,'option_title'=>'No','option_ques_id'=>31,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            // question 31 
            ['id' => 96,'option_title'=>'Low','option_ques_id'=>32,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 97,'option_title'=>'High','option_ques_id'=>32,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],

            //===
            ['id' => 98,'option_title'=>'Hair Fibre Concern','option_ques_id'=>12,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 99,'option_title'=>'No','option_ques_id'=>29,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
             //===

            // question 33 
            ['id' => 100,'option_title'=>'Yes','option_ques_id'=>33,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 101,'option_title'=>'No','option_ques_id'=>33,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],

            // question 34 
            ['id' => 102,'option_title'=>'Yes','option_ques_id'=>34,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 103,'option_title'=>'No','option_ques_id'=>34,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
             //question 35
            ['id' => 104,'option_title'=>'Yes','option_ques_id'=>35,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            ['id' => 105,'option_title'=>'No','option_ques_id'=>35,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>1,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
            //question 36
            ['id' => 106,'option_title'=>'','option_ques_id'=>36,'option_status'=>1,'option_link'=>'','option_image'=>'','option_check_condition_id'=>0,'option_condition_true_next_question_id'=>0,'option_condition_false_next_question_id'=>0],
        ]);
     
    }

    public function run_ques_condition(){
        DB::table('ques_conditions')->delete();
        DB::table('ques_conditions')->insert([
            ['id'=>1,'condition_title'=>'female','condition_code'=>''],
            
        ]);
     
    }
}
