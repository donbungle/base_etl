docker run --name nifi-test \
  -p 8080:8080 \
  -i -v /home/donbungle/Proyectos/banco-ripley/:/opt/nifi/nifi-current/ls-target \
  -d \
  apache/nifi:latest
  