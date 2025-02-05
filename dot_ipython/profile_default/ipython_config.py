c = get_config()
c.InteractiveShellApp.exec_lines = []
c.InteractiveShellApp.exec_lines.append('%load_ext autoreload')
# Only autoreload modules loaded with %aimport
c.InteractiveShellApp.exec_lines.append('%autoreload 1')

print(">>>>>>>> Autoreload enabled with %aimport statements <<<<<<<<<")

