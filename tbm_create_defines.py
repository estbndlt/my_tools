key = "MR_MNU_"
#key = "SC_MNU_"
#key = "SO_MNU_"

clear_old_ids = open('tbm_generated_menu_ids.txt', 'w').close()

read_ids = open('tbm_test_menu_ids.py', 'r')
gen_ids = open('tbm_generated_menu_ids.txt', 'w')

for line in read_ids:
    if key in line:
        line = line.replace('=', '\t\t\t')
        gen_ids.write('#define '+line)

read_ids.close()
gen_ids.close()
