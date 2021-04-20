## learning-kubernetes
Configurações e exemplos de POD's, Deployments, Services  com Kubernetes

# Comandos

Iniciar cluster, usando o minikube: 
```bash 
  minikube start
```
Parar cluster: 
```bash
minikube stop
```
Obter lista com contextos disponiveis no computador: 
```bash
kubectl config get-contexts
```
Obter log de um pod
```bash
kubectl logs <nome_pod>
```
Acessar ao bash do container
```bash
kubectl exec -it mongodb-pod -- /bin/bash
```
```bash
kubectl delete <pod> --grace-period=<s>
```
Reiniciar o Docker
```bash
docker-machine restart default
```
Fazer build de uma imagem na nossa máquina
```bash
docker build -t <nome-da-sua-imagem> .
```
Rodar uma imagem com o Docker passando a variavel de ambiente PORT
```bash
docker run -e PORT=8080 -p 2345:8080 <nome-de-sua-imagem>
```
Criando um alias para uma imagem docker
```bash
docker tag <nome-da-sua-imagem> <seu-usuario-dockerhub>/<nome-da-sua-imagem>
```
Enviar imagem para doker registry
```bash
docker push <seu-usuario-dockerhub>/<nome-da-sua-imagem>
```
Criar um workload 
```bash
kubectl create -f <caminho-arquivo>
```
Atualizar um workload existente
```bash
kubectl apply -f <caminho-arquivo>
```
Descrever um POD
```bash
kubectl describe pod <nome-do-seu-pod>
```
Obtermos informações de um pod com label especifica
```bash
kubectl get pod -l chave=valor
```
Instalar nginx-ingress-controller no cluster
```bash
minikube addons enable ingress
```
Obter IP externo do cluster
```bash
minikube ip
```
Rodar um comando no mododry-run(teste)
```bash
kubectl create -f <arquivo> --dry-run
```

## Ciclo de vida de um POD
- Unknown: este é o estado em que todos os pods se iniciam,
ele deve durar apenas alguns breves momentos até que o
kubelet possa se comunicar com o nó principal e reportar o
estado de volta. Ele significa que, no momento, não foi
possível obter as métricas e o estado atual do pod. Se isso
acontecer por alguns segundos, é o esperado; porém, se um
pod permanecer no estado unknown por muito tempo,
isso pode significar algum problema de comunicação entre
o kubelet e o master ou então entre o kubelet e o pod.

- Pending: a solicitação de criação do pod já foi recebida
pelo master e registrada, mas uma ou mais imagens ou
contêineres ainda não terminaram de ser criados. É
importante dizer que um pod vai continuar neste estado
enquanto estiver baixando a imagem base do contêiner
através da rede, o que pode demorar um pouco.

- Running: é o estado de execução do pod. Todo pod que
não possuir um estado de saída, ou seja, que se mantém
rodando eternamente (como é o caso de um servidor web,
um banco de dados como o MongoDB ou qualquer outro
serviço que tenha execução prolongada) vai ficar neste
estado. Este estado será o atual quando todos os
contêineres dentro de um pod foram criados e pelo menos
um deles ainda está rodando.

- Succeeded: é o estado de sucesso do pod. Um pod entrará
neste estado somente se cumprir dois requisitos: o primeiro
é que todos os seus contêineres possuam um estado de
saída, isto é, executem uma ação e depois se desliguem; o
segundo é que todos os estados de saída devem ser de
sucesso, em outras palavras, nenhum dos contêineres pode 
sair com um erro. Se formos transpor essa mesma lógica
para o que utilizamos, por exemplo, com ShellScript, é
como dizer que todos os contêineres precisam sair com
exit(0) , logo, com finalização perfeita sem nenhum erro.

- Failed: é o oposto do succeeded. Acontece somente se todos
os contêineres tiverem sido terminados e pelo menos um
deles não tiver uma saída perfeita (sem nenhum tipo de
erro).

## Services
Os services possuem quatro tipos, e podemos escolher setando a chave type , dentro de spec

- ClusterIP: é o modelo padrão, faz com que o serviço
exponha um IP fixo interno para todo o cluster e qualquer
serviço que acessar este IP na porta selecionada pela chave
port do nosso arquivo declarativo.

- NodePort: habilitará uma porta externa que estará descrita
na chave nodePort dentro de spec.ports (ou então
será uma porta aleatória entre 30000-32767) que será
aberta em todos os nós do seu cluster e enviadas para
dentro da porta selecionada pelo serviço. Ou seja, vamos
expor o serviço pela internet para todos que acessarem o
ip-do-cluster:porta .

- oadBalancer: este tipo fará com que seja criado um
balanceador de carga para seus serviços. No geral, é um
tipo bem pouco utilizado, porque geralmente estas
configurações se localizam fora do Kubernetes, em seu
provedor cloud. Por isso, às vezes se torna necessária uma
configuração externa (disponível na documentação do
Kubernetes, na seção de referências).

- ExternalName: este tipo é utilizado somente em casos
extremamente raros, pois mapeiam para um DNS externo
em vez de um seletor, como os demais. Neste caso, quando
estivermos fazendo a resolução do DNS do nosso serviço,
seremos redirecionados para um DNS externo. A maior
diferença aqui é que o redirecionamento acontece em nível
de DNS e não através de um proxy.

Para fixar uma porta especifica, entre 30000 - 32767
```json
"spec": {
  "type": "NodePort",
  "selector": {
  "app": "simple-api"
  },
  "ports": [{
  "protocol": "TCP",
  "port": 8085,
  "nodePort": 30526,
  "targetPort": "porta-api"
  }]
}
```
## Ingress

## Volumes



