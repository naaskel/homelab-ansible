# Homelab Ansible

This repo contains Ansible playbooks that I use to manage my (small) homelab!

## Why?

*"You only have one Raspberry Pi, you don't need to setup it via Ansible!"* Yeah, but also I wanted to learn a little more about DevOps'ing, as well as have a "wiki" on stuff that is running there, and has been done to it.

## Prerequisites

This repo is pretty much just read-only, as it contains my setup-specific quirks, those include:

- The Pi has to have a static address of 192.168.0.138, and the user has to be called "pi"
- It has to have a USB drive plugged in (also I'm mounting it by its UUID so... yeah)
- You have to copy your SSH public key to it before running the playbooks
- Probably something else that I forgor 💀

Additionally, this was only tested on my 8GB Pi 5, so even if you somehow manage to get it running on your hardware, there's no guarantee that it will work performance-wise.

## What it does?

I've split my playbooks into "sections", here they are in order:

1. Hardware
- Mounts the USB drive

2. System
- Performs an update
- Hardens SSH

3. Installs and configures these packages:
- Docker
- Fail2ban
- Wireguard

4. Sets up these services:
- AdGuard Home
- Glances
- Jellyfin
- Nginx Proxy Manager
- Open WebUI
- Seafile

*(From what I saw, all the images support ARM, so there isn't any performance issues, with all of these running I'm sitting at around 10% CPU and 30% RAM utilization.)*

## Lessons learned

As I said before, this project was pretty much just a learning ground for me, so here is what I've learned:

- How to write playbooks, I have never previously written any.
- How to tag them, and re-run only the things that I was working on.
- How to manage IaC.
- I've also dabbled into planning everything, like folder structure on the target machine.

## AI Usage

As I said twice before, this project was mainly done from the standpoint that I want to learn Ansible, thus, I've tried to limit my AI usage on this project. Here are the things that I helped myself with using AI:

- Wireguard script
- Seafile configuration
- Fixing wording in this README
