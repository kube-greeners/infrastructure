<div id="top"></div>

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]

<br />
<div align="center">

<h3 align="center">kube-green Dashboard Infrastructure</h3>

  <p align="center">
    Creating cluster resources so that the kube-greeners can find their way through
    <br />
    <br />
  </p>
</div>


<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#main-concepts">Main Concepts</a></li>
        <li><a href="#used-technologies-and-libraries">Used Technologies and Libraries</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#execution">Execution</a></li>
      </ul>
    </li>
    <li>
      <a href="#code-structure">Code Structure</a>
      <ul>
        <li><a href="#directories">Directories</a></li>
      </ul>
    </li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#people">People</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>

## About The Project

This project, as a part of the Dashboard for kube-green project intends to provide Kubernetes resource specifications to create and configure a testing cluster to test both the backend and frontend of kube-green.
So, this project doesn't contribute to the project itself, however it provides the basic backbone to develop, test and verify the functionalities of the project.
Within this project, contents of resources, that can be directly or indirectly applied to an empty Kubernetes cluster, are defined and used to create the first cluster to test this project.

<p align="right">(<a href="#top">back to top</a>)</p>

### Main Concepts:
* Helm is used to generate configurations for prebuilt Prometheus stack, MongoDB and Redis.
* Replicability is important, since Kubernetes is based on configuration files, we shall commit any changes made to the cluster to this repo. This will enable us to reconstruct parts or the whole cluster from scratch.
* A customized kube-green is used that attaches itself to Prometheus to export the metrics.
* Custom apps enable testing for different values of CPU and memory, and are built using different languages and frameworks to make it similar to real-world use cases
* To increase similarity to real-world, production and staging deployments vary by their service guarantees and scale.
* The frontend and backend of the cluster will also be deployed alongside this workload. Backend is an actual HTTP service while frontend is a bundle of code to be served. Thus, two extra namespaces shall exist and they shall integrate with one another.
<p align="right">(<a href="#top">back to top</a>)</p>

### Used technologies and Libraries

* [Yaml](https://yaml.org/)
* [Prometheus](https://prometheus.io/)
* [K8S](https://kubernetes.io/)
* [Helm](https://helm.sh/)
* [Kustomize](https://kustomize.io/)
* [kube-green](https://github.com/kube-green/kube-green)
* [Django Framework](https://www.djangoproject.com/)
* [Express.js](https://expressjs.com/)

##### README is based on [Best-README-Template](https://github.com/othneildrew/Best-README-Template)
<p align="right">(<a href="#top">back to top</a>)</p>

## Getting Started

This project assumes that you have an empty Kubernetes cluster to test the other components of this project on.
Consequentially, the kubectl binary is expected to be available and pointing to the aforementioned cluster.
The scripts available on this repository has only been tested using a POSIX environment and is not guaranteed to run on Windows.


### Execution
```sh
./helm_init.sh
```
should be enough to install and provision all the resources you would need for the testing environment.
The testing cluster can then be used to provision other projects on top, through the deployments specified in their appropriate README files.

## Code structure
This project contains many YML configurations used to provision a demo cluster and some sample applications to emulate workload.
The resources are grouped based on the cluster that they run on, while the significant customizations are put in the main directory for easy access.
The resources can be applied to a Kubernetes cluster directly by `kubectl apply -f` but we also provide an initialization script to create all resources on top of an empty cluster.


### Directories
* `.github/`: Automation using Github Actions, configurations in here allow us to automatically create images for the sample applications upon each push.
* `apps/`: Contains the sample application code to be deployed on some namespaces
  * `diangoApp/`: Demo application built using Django Framework on top of Python, exposing one endpoint that can be used to simulate CPU cycles.
  * `nodeApp/`: Demo application built using Express.js on top of Node.js, exposing endpoints that allow allocation/de-allocation of resources to simulate memory.
* `generated/`: Empty directory, which will become the storage for the generated configuration regarding Prometheus and relevant components
* `kube-green/`: Submodule directly from [kube-green's original repository](https://github.com/kube-green/kube-green)
* `production/ staging/`: Directories containing specific configuration for the production and staging namespaces
  * `apps`: Deployment configuration for Django and Node apps
  * `generated`: Empty directory to persist the configuration for the Redis and MongoDB deployments
  * `kustomization.yml patch.yml`: Kubernetes Kustomization allowing dynamically setting the production variables for all deployments
* `sleepInfos/`: Directory containing the sleepInfo resources we have used to run on our cluster.
* `clusterRoleForBackend.yml`: ClusterRole allowing the backend namespace to access the configmaps of the frontend
* `helm-init.sh`: A script to automate the provisioning of resources.
* `ingress.yml`: (WIP) network configuration to obtain a Public IP address for our resources.
* `kube-green-*.yml`: Resources needed to make Prometheus recognise kube-green as a data source
* `monitoring-values.yml`: Contains the configuration changes to the Prometheus stack to make it work with our cluster. The changes in configurations is the increased memory and enabling of persistance, as we might shut down the cluster.
* `ns.yml`: Contains the namespaces to be created in the infrastructure.

<p align="right">(<a href="#top">back to top</a>)</p>

## Contributing

As this project is mainly a resource dump for how we created our cluster and shall change if we need to change something in our testing cluster, it is closed to external contribution.
However, please feel free to inspire and be inspired by any part of the code that is included in this repository.

<p align="right">(<a href="#top">back to top</a>)</p>

## License

Distributed under the MIT License. See `LICENSE` for more information.

<p align="right">(<a href="#top">back to top</a>)</p>

## People
#### Built by:
* Ozan İncesulu [@ozyinc](https://github.com/ozyinc)
#### [kube-green backend](https://github.com/kube-greeners/backend/) by:
* Alban Delishi [@albandelishi](https://github.com/albandelishi)
* Zoé Pesleux [@zoepj](https://github.com/zoepj)
* Redion Lila [@rlila97](https://github.com/rlila97)
#### [kube-green frontend](https://github.com/kube-greeners/frontend/) by:
* Boris Grunwald [@jikol1906](https://github.com/jikol1906)
* Ragnhild Kleiven [@RagnhildK](https://github.com/RagnhildK)
* Hanna Torjusen [@hanntorj](https://github.com/hanntorj)
* Marija Popovic [@marijapopovic28](https://github.com/marijapopovic28)
* Amila Cizmic [@amilacizmic](https://github.com/amilacizmic)
### Acknowledgements:
We would like to thank:
* Malvina Latifaj and Samuele Giussani for their assistance and feedback through this project and for sharing this journey with us.
* Davide Bianchi for kube-green and valuable guidance for integration of this project
* Francesca Carta for feedback regarding each step of the product built.

<p align="right">(<a href="#top">back to top</a>)</p>

[contributors-shield]: https://img.shields.io/github/contributors/kube-greeners/infrastructure.svg?style=for-the-badge
[contributors-url]: https://github.com/kube-greeners/infrastructure/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/kube-greeners/infrastructure.svg?style=for-the-badge
[forks-url]: https://github.com/kube-greeners/infrastructure/network/members
[stars-shield]: https://img.shields.io/github/stars/kube-greeners/infrastructure.svg?style=for-the-badge
[stars-url]: https://github.com/kube-greeners/infrastructure/stargazers
[issues-shield]: https://img.shields.io/github/issues/kube-greeners/infrastructure.svg?style=for-the-badge
[issues-url]: https://github.com/kube-greeners/infrastructure/issues
[license-shield]: https://img.shields.io/github/license/kube-greeners/infrastructure.svg?style=for-the-badge
[license-url]: https://github.com/kube-greeners/infrastructure/blob/dev/LICENSE
