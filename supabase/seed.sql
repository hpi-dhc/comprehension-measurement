insert into public.surveys (title)
values 
  ('Survey 1'),
  ('Feedback Survey');

insert into public.questions (title, type, context, survey_id)
values
  ('This is an example single choice question', 'single_choice', null, 1),
  ('This is an example multiple choice question', 'multiple_choice', null, 1),
  ('This is an example text question', 'text_answer', null, 1),
  ('This is an example contextual single choice question', 'single_choice', 'context', 1),
  ('This is an example contextual multiple choice question', 'multiple_choice', 'another_context', 1),
  ('This is an open question for feedback', 'text_answer', null, 2);

insert into public.answers (is_correct, answer_text, question_id)
values 
  (true, 'This answer is true', 1),
  (false, 'This answer is wrong', 1),
  (true, 'This answer is true', 2),
  (true, 'This answer is also true', 2),
  (false, 'This answer is wrong', 2),
  (null, 'This is a context answer', 4),
  (null, 'This is another context answer', 4),
  (null, 'This is a context answer', 5),
  (null, 'This is another context answer', 5);