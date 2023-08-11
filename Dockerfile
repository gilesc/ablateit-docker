FROM nvidia/cuda:11.7.1-cudnn8-devel-ubuntu20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV HF_DATASETS_CACHE=/data/cache/datasets
ENV TRANSFORMERS_CACHE=/data/cache/transformers

RUN apt update
RUN apt install -y git python3 python3-pip git-lfs

RUN mkdir -p /app /data/cache

RUN git clone https://github.com/AblateIt/finetune-study.git /app
RUN cd /app && git clone https://github.com/OpenAccess-AI-Collective/axolotl
RUN cd /app/axolotl && pip3 install -e . && pip3 install -U git+https://github.com/huggingface/peft.git

RUN mkdir -p /root/.cache/huggingface
COPY user-data/huggingface-token /root/.cache/huggingface/token
COPY user-data/netrc /root/.netrc

#RUN sed -i 's/accelerate launch/accelerate launch --num_processes=1' /app/sweep.py

WORKDIR /app
ENTRYPOINT ["python3", "sweep.py"]
