library(blastula)

my_email_obj <- blastula::render_email('send_email/blastula_.Rmd')
class(my_email_obj)

print(my_email_obj)
