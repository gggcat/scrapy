FROM zzzcat/dispshell:latest

WORKDIR /work-scrapy

#
# Scrapy
#
ENV LC_ALL=C.UTF-8 \
    LANG=C.UTF-8 \
    TZ=Asia/Tokyo \
    DEBIAN_FRONTEND=noninteractive \
    DEBCONF_NOWARNINGS=yes

#
# Scrapy
# 
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends python3 && \
    apt-get install -y --no-install-recommends python3-dev && \
    apt-get install -y --no-install-recommends python3-pip && \
    apt-get install -y --no-install-recommends libxml2-dev && \
    apt-get install -y --no-install-recommends libxslt1-dev && \
    apt-get install -y --no-install-recommends zlib1g-dev && \
    apt-get install -y --no-install-recommends libffi-dev && \
    apt-get install -y --no-install-recommends libssl-dev && \
    # --no-install-recommendsだとgccがインストールされずscrapyのインストールでエラーになる
    apt-get install -y --no-install-recommends gcc && \
    echo "*** INSTALLED: scrapy modules ***"

#
# Scrapy - Python
#
COPY requirements.txt .
#RUN pip install --upgrade pip setuptools wheel && \
RUN pip install --upgrade pip && \
    pip install -r requirements.txt && \
    echo "*** INSTALLED: python scrapy modules ***"

#
# RUN: need override
#
COPY entrypoint.sh .
ENTRYPOINT ["bash", "entrypoint.sh"]
CMD ["bash"]