# 2018-petstore
Containers and JavaPetStore.

## JavaPetStore
jPetStore is a reference application alike today's ToDo list that was implemented across various Java Enterprise Edition (JEE) web containers. It is a fun aplication, but so 2003. All pictures and lists are static. Definitely it is a hard thing to compete with those flashy new applications out there.

Besides to the obvious lack of the User Experience, it is designed to be run on premis.

I will show you steps to modernize this application and how to improve its architecture from infrastructure and UX point of views.

## infrastructure modernization
I started by reusing the example shown at the DockerCon 2017 in December, where this application was dockerized and shown out of Docker for Mac. A great app improvement. Now you can store it the container on the cloud.

Further more you can further evolve the architecture of the application by creating a data layer on Kubernetes cluster. And the application layer in PaaS. I used for that IBM Cloud, which natively supports Kubernetes.

I created a yaml file for the MYSql db:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: mysql-pod
  labels:
    name: mysql-pod
    context: jpetstoreibm
spec:
  containers: 
    - name: mysql
      image: mysql:5.6
      env: 
        - name: "MYSQL_USER"
          value: "jpetstore"
        - name: "MYSQL_PASSWORD"
          value: "foobar"
        - name: "MYSQL_DATABASE"
          value: "jpetstore"
        - name: "MYSQL_ROOT_PASSWORD"
          value: "foobar"
      ports: 
        - containerPort: 3306
```

And I used the Kubernetes UI to upload the yaml file to the system and to lunch the Kube container.

The War file of the Java application I installed directly on the JEE cloud container - Open Liberty. It is the famous Websphere Liberty server that was open sourced and donated to the open source community by IBM during Java One in Fall 2017.

## the UX
In order to be relevant to current market challenges in addition to the containerized app I created a prototype for the mobile app. I thought that someone could use approach alike Shazam for music, with the pets around us. So let's say a kid would take a picture of a dog (not event knowing its breed). And the service would behave like Shazam for music. It would detect the name of the breed with the help of the IBM Watson service.

## repositories

Mobile app - https://github.com/blumareks/2018-petstore-android
DB - this repo
jPetStore WAR app - this repo

Please follow me on Twitter: @blumareks

