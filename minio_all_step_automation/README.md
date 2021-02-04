# Automate all steps in MinIO (Bucket,Folder, Policy based Access to Folder, Policy to User and Group) and Insert bucket name, folder path, username and password to Vault as credentials

Soon: It will be in Jenkins with parametrized job :)
```
Add minio admin credential to enviroment
Added `minio_object_storage` successfully.
Success

Create Bucket:
Bucket created successfully `minio_object_storage/test_project`.
Success

dev enviroment:
Copy sample data to bucket based on dev folder:
data/dev/tst.txt:       5 B / 5 B  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓  65 B/s 0s

Prepare and create test_project_dev policy:
Added policy `test_project_dev_policy` successfully.

Create New User:
Added user `test_project_dev_user` successfully.

Apply  policy to user:
Policy test_project_dev_policy is set on user `test_project_dev_user`

Add user to  new group: 
Added members {test_project_dev_user} to group test_project_dev_group successfully.

Add policy to the group:
Policy test_project_dev_policy is set on group `test_project_dev_group`
Insert bucket name, folder path, username and password to vault as credentials:
Vault UI Path: secret/minio/test_project/dev 


pre enviroment:
Copy sample data to bucket based on pre folder:
data/pre/tst.txt:       5 B / 5 B  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓  44 B/s 0sPrepare and 

create test_project_pre policy:
Added policy `test_project_pre_policy` successfully.

Create New User:
Added user `test_project_pre_user` successfully.

Apply  policy to user:
Policy test_project_pre_policy is set on user `test_project_pre_user`

Add user to  new group: 
Added members {test_project_pre_user} to group test_project_pre_group successfully.

Add policy to the group:
Policy test_project_pre_policy is set on group `test_project_pre_group`

Insert bucket name, folder path, username and password to vault as credentials:
Vault UI Path: secret/minio/bucketoldk/pre 

prod enviroment:
Copy sample data to bucket based on prod folder:
data/pre/tst.txt:       5 B / 5 B  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓  44 B/s 0sPrepare and 

create test_project_prod policy:
Added policy `test_project_prod_policy` successfully.

Create New User:
Added user `test_project_prod_user` successfully.

Apply  policy to user:
Policy test_project_prod_policy is set on user `test_project_prod_user`

Add user to  new group: 
Added members {test_project_prod_user} to group test_project_prod_group successfully.

Add policy to the group:
Policy test_project_pre_policy is set on group `test_project_prod_group`

Insert bucket name, folder path, username and password to vault as credentials:
Vault UI Path: secret/minio/test_project/prod 
```