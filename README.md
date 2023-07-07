# VMware vSphere Automation

## Table of Contents

- [Abstract](#abstract)
- [Steps to Build the Automation Client Image and Jenkins Job for vCenter Admin Tasks](#steps-to-build-the-automation-client-image-and-jenkins-job-for-vcenter-admin-tasks)
  - [Build Automation Client](#build-automation-client)
  - [Create VM, Configure Hostname, and Configure IP4 Properties](#create-vm-configure-hostname-and-configure-ip4-properties)
  - [Delete VM](#delete-vm)
  - [Update Hostname and Static IP](#update-hostname-and-static-ip)

## Abstract

This document describes the vSphere automation in the ROME datacenter. The automation client leverages vSphere Automation SDK for Java, PowerShell, VMware PowerCLI, and Bash scripts. It automates various vSphere admin tasks, including:

- Creating VMs
- Assigning owners/assignees
- Configuring hostnames
- Checking IP availability
- Configuring IP4 properties (static IP, gateway, subnet mask, preferred DNS, and alternate DNS)

**Steps to Build the Automation Client Image and Jenkins Job for vCenter Admin Tasks**
---

*Build Automation Client*
---

1. Run the following Jenkins job to build the vCenter automation client image and push it to the JFROG repository:

   **Jenkins job URL:** [http://bigfix-jenkins.nonprod.hclpnp.com:8080/view/Infrastructure/job/VCenter_Build_Automation_Client/](http://bigfix-jenkins.nonprod.hclpnp.com:8080/view/Infrastructure/job/VCenter_Build_Automation_Client/)

   #### This job performs the following tasks: 
   
   - Checkout [bigfix-docker](git@github02.hclpnp.com:besuem/bigfix-docker.git)
     ```bash
     git clone git@github02.hclpnp.com:besuem/bigfix-docker.git
     ```
   - Execute the `make` command to build the vCenter automation client image:
     ```bash
      make build-vcenter
     ```
   - Tag the build number with the Docker image and push it to the JFROG Docker registry.

*Create VM, Configure Hostname, and Configure IP4 Properties*
---

2. Run the following Jenkins job to create a VM, configure the hostname, and configure IP4 properties:

   **Jenkins job URL:** [http://bigfix-jenkins.nonprod.hclpnp.com:8080/view/Infrastructure/job/VCenter_Create_VM/](http://bigfix-jenkins.nonprod.hclpnp.com:8080/view/Infrastructure/job/VCenter_Create_VM/ )

   #### This job performs the following tasks: 

   - Remove the automation container if it already exists.

   - Pull the latest image from the JFROG Docker registry.

   - Spin up the container with the necessary environment properties.

   - Check the IP availability. The job will mark it as a failure in case of an IP conflict.

   - Create a VM based on the selected template, configure the hostname, and configure IP4 properties (static IP, gateway, subnet mask, preferred DNS, and alternate DNS):
     ```bash
     docker exec vcenter /app/scripts/create-vm.sh
     ```
*Delete VM*
---
3. Run the following Jenkins job to delete a VM:

   **Jenkins job URL:** [http://bigfix-jenkins.nonprod.hclpnp.com:8080/view/Infrastructure/job/VCenter_Delete_VM/](http://bigfix-jenkins.nonprod.hclpnp.com:8080/view/Infrastructure/job/VCenter_Delete_VM/)

*Update Hostname and Static IP*
---
4. Run the following Jenkins job to update the hostname and static IP for a given VM:

   **Jenkins job URL:** [http://bigfix-jenkins.nonprod.hclpnp.com:8080/view/Infrastructure/job/VCenter_Update_VM/](http://bigfix-jenkins.nonprod.hclpnp.com:8080/view/Infrastructure/job/VCenter_Update_VM/)
