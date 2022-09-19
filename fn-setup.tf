## Copyright (c) 2020, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "null_resource" "Login2OCIR" {
  provisioner "local-exec" {
    command = "echo '${var.ocir_user_password}' |  docker login ${local.ocir_docker_repository} --username ${local.ocir_namespace}/${var.ocir_user_name} --password-stdin"
  }
}


resource "null_resource" "query-apiPush2OCIR" {
  depends_on = [null_resource.Login2OCIR
			   ]

  provisioner "local-exec" {
    command = "image=$(docker images | grep query-api | awk -F ' ' '{print $3}') ; docker rmi -f $image &> /dev/null ; echo $image"
    working_dir = "functions-fn/api/query-api/"
  }

  provisioner "local-exec" {
    command = "fn build "
    working_dir = "functions-fn/api/query-api/"
  }

  provisioner "local-exec" {
    command = "image=$(docker images | grep query-api | awk -F ' ' '{print $3}') ; docker tag $image ${local.ocir_docker_repository}/${local.ocir_namespace}/${var.ocir_repo_name}/query-api:0.0.1"
    working_dir = "functions-fn/api/query-api/"
  }

  provisioner "local-exec" {
    command = "docker push ${local.ocir_docker_repository}/${local.ocir_namespace}/${var.ocir_repo_name}/query-api:0.0.1"
    working_dir = "functions-fn/api/query-api/"
  }
}

resource "null_resource" "data-keyval-loadPush2OCIR" {
  depends_on = [null_resource.Login2OCIR
			   ]

  provisioner "local-exec" {
    command = "image=$(docker images | grep data-keyval-load | awk -F ' ' '{print $3}') ; docker rmi -f $image &> /dev/null ; echo $image"
    working_dir = "functions-fn/load/data-keyval-load/"
  }

  provisioner "local-exec" {
    command = "fn build "
    working_dir = "functions-fn/load/data-keyval-load/"
  }

  provisioner "local-exec" {
    command = "image=$(docker images | grep data-keyval-load | awk -F ' ' '{print $3}') ; docker tag $image ${local.ocir_docker_repository}/${local.ocir_namespace}/${var.ocir_repo_name}/data-keyval-load:0.0.1"
    working_dir = "functions-fn/load/data-keyval-load/"
  }

  provisioner "local-exec" {
    command = "docker push ${local.ocir_docker_repository}/${local.ocir_namespace}/${var.ocir_repo_name}/data-keyval-load:0.0.1"
    working_dir = "functions-fn/load/data-keyval-load/"
  }
}

resource "null_resource" "data-loadPush2OCIR" {
  depends_on = [null_resource.Login2OCIR
			   ]

  provisioner "local-exec" {
    command = "image=$(docker images | grep data-load | awk -F ' ' '{print $3}') ; docker rmi -f $image &> /dev/null ; echo $image"
    working_dir = "functions-fn/load/data-load/"
  }

  provisioner "local-exec" {
    command = "fn build "
    working_dir = "functions-fn/load/data-load/"
  }

  provisioner "local-exec" {
    command = "image=$(docker images | grep data-load | awk -F ' ' '{print $3}') ; docker tag $image ${local.ocir_docker_repository}/${local.ocir_namespace}/${var.ocir_repo_name}/data-load:0.0.1"
    working_dir = "functions-fn/load/data-load/"
  }

  provisioner "local-exec" {
    command = "docker push ${local.ocir_docker_repository}/${local.ocir_namespace}/${var.ocir_repo_name}/data-load:0.0.1"
    working_dir = "functions-fn/load/data-load/"
  }
}


