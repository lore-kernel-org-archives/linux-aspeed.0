Return-Path: <linux-aspeed+bounces-4351-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ECF1C43458
	for <linux-aspeed@archiver.kernel.org>; Sun,  5 Jul 2026 05:36:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtGSD3Mczz2ygm;
	Sun, 05 Jul 2026 15:36:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783108986;
	cv=none; b=VQUtfo8P1nKbs7GdyA5zXGjZPB16HysI/uTI8Bj8+tz0nM2C0Py8WXjeoW+ym9Sehj7KVBP1usN9ONxOB3/09a5VMVwZysPgWwTsP6m3I6dng/TcYCKqVmV2N9aAH3LkPxKAC11hVwyQUDyMtxHZGBP1OFA0MRL3yzshY5sBmYGfMZucMuVzRp/U6FUBuKxOieZbqy1z/3eOaBTCy3JqG0EJjEOVJiwnMrBZnYCh3yOD5Z3+6uFM/Tpedmqklytqwrio7WbPaPpMgzOgxEIMz5k7hV5O98KMo8JsiVmjZ+zdbRnFKl9CogcPXF+YX4vVZZcIQpPogA21YPTATi+qdw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783108986; c=relaxed/relaxed;
	bh=yuDgKoAlw/JRHunDNfGXYBYzhSRLVnjx2xmNmMEK1vs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ET29enikviw7XhnzTSxUC7w/kZa5DUUd4mVcNaEB5ze0RVP2iryaT1+aKAg9jGZ1NV46rpFGDLZrqFXBqNsB8dmw7BP453GqK9Qer2qtqbzRU/46kcKmxuQldzHnb8dfJxiyw9vZl3N5UqYQVlA/AYhJzgohxvsJX+88XivOFDMFv10MQ1KJJ+1LrocDDvZdBtqeq+CDei2yk+Bw3hDMqyVxVorVEY/O+scxvo/6dugv6LeH22Kqp7bOL37RKFnSBHByq/qwPHWu7FBp13YSTGHpNrcvY8b78q9YoHLGq67gNKZCKE2GrheZbG/m/WHNdUiq2EDf0bjK0EhKrnnVTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YEMeysY1; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=f9yjXJ5v; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YEMeysY1;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=f9yjXJ5v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gsPnP5Qkwz2xC3
	for <linux-aspeed@lists.ozlabs.org>; Sat, 04 Jul 2026 06:03:05 +1000 (AEST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663HiIHU683668
	for <linux-aspeed@lists.ozlabs.org>; Fri, 3 Jul 2026 19:39:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=yuDgKoAlw/JRHunDNfGXYB
	YzhSRLVnjx2xmNmMEK1vs=; b=YEMeysY1/myhDao0i74e7TNlV74ktXTCfMwdq9
	CR3QbS5AITeviE8hf9EJ30WAllVldtcYL4AMMm0/LzjQKzr0t0eqDF0S43incuSV
	MyApeWy7M1IbpM60LNShiFzTpmwg+/W0PKTj+Lp+cXYVgARiHsuxhXD426SvD7cT
	GGZrPR1QcL7iICOr24d23aBH8a/MPY5danZVa1/zTiMmF2fSUTDZMyH3oHPCfVAv
	4nbvlJJiytEOZCVzenusm2J4e5XUbEHMVWQY64oswPjfiGG059bwY0hXxdENEoJ/
	sJbKqjoPigEwtHk2s+fe6Ba9Tfz1f/tpFlGt1x1q0Mz2ipmQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f64b5brk4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Fri, 03 Jul 2026 19:39:26 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c889d1eedcdso1374552a12.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 03 Jul 2026 12:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783107566; x=1783712366; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yuDgKoAlw/JRHunDNfGXYBYzhSRLVnjx2xmNmMEK1vs=;
        b=f9yjXJ5v3mWB2p/VJCp9E7x1kAnvOl79+PK+ASqAO1R6o4fHL/sEZkYXA1gIM54rcE
         nBm4Xqq/ggnH4fJCh75pxlvJ4XSV9nnYG88kbMQjuEq86uWf3bGCQPzDQK6C+AuiallZ
         uU7G0PyufLdRZMwEqlnKciq1e27MI9I9OTUhdjNIspzxWEVK4VlyR3D4nLyruoadxUbx
         lhR5GzeTyM5HxJefVg+J+gLlz/DTE1XJijayatVsXHfOhT2XbPHe+gDFiLGFBEYeMqeX
         fzvWiCngiHWKSoKLUUbW8u0XV4h3szvGnBruBFN+J9DaJGvcH0yapPV0j7ISkg63YTam
         wA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783107566; x=1783712366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuDgKoAlw/JRHunDNfGXYBYzhSRLVnjx2xmNmMEK1vs=;
        b=qmqYIK826x40eQ0P+JWKG5vRnsAXQJf7QqCOtnLkIH+eaezdd6WE2wcqmoIz5JpDfS
         mUe6NbK9nvdy8qPUDPk0BaAaDLKUcqJlhz7FvhQS38HJ7FsGhJDapryPIN35hdLN1c5j
         g0X3veddD5Xnyfs0t5eNisVu/esFbv58IPIjyfVNffIPRu6CeXqOcG4VS17XlWD8Slgr
         3sgjlxe5G5YXJ0TwkkuystfnYO1NgpOIdPCAgzhpPXlKmAXBBSPBKMvxVKXodYDGNFqu
         F1pAa7QcvE/abA9ddJDW+DGa/ufcpNGmp8u6CoIOGS/KnBePnRZq9+b3LBRrCYuZLKid
         ibCg==
X-Forwarded-Encrypted: i=1; AFNElJ/6lzxn5c6ASPYQyekO+hs76b7vjp494KuC0qCS+GjuZeIaYngyFK9D4/Uwfd3+PUHTQ1ji17Q4tUf4HqU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzlMxk5ERnpolJHRzFsLn9aHafaU0gup1nJq6TlAI2L9VtFQjO8
	45/3Ro3rsPKx61aPOm1BqcSmU1NI5pIW8Ur5tiLDIr1h803/fywDcpfN321gDZYKRPjb5temuvU
	4InormO9KRzC7mmfc+lTeAafJClW/a3h9CFEu4sEp87ScNKxnFMcXGjICk2WzoIWt7ziD
X-Gm-Gg: AfdE7clsdQePMT0oYtWKjuturGRbuIQIn/s80qckRn+Raqd30n5dRMfUygqNpL1gay8
	WP501pE+Xi8l5cXpTQ+lMdWdKC9b9jnpG9Nhihw79eSVPHiVyCHw/Z8+H59xujOvYUrmR2hsIBC
	aPQ048EFSiD4dYLInrHmWu+zF1mQSTsDWJkRjVG7UaOmKgroJ7Y9+vIFca5+K7TLxV8khmx+T4J
	gZFloHFCtGaf//NhrzL9gMAGECv+w8oozjILFNAThKX8ei1taGeTDlf4Uyq3T+PZjd+pJw9Kifd
	ygJuxgV7rkAK0OZDZTB6uiOuMFaG1eFpHEAwo8rI02XFzdar4WyFW+RtQfuZG1mKb9YJfHN1324
	n341pa3kQ07xl0iYKT3vMvzo4/uPmHSUXElRmZA==
X-Received: by 2002:a05:6a21:4c81:b0:3bf:e291:496c with SMTP id adf61e73a8af0-3c03e298475mr701928637.17.1783107565962;
        Fri, 03 Jul 2026 12:39:25 -0700 (PDT)
X-Received: by 2002:a05:6a21:4c81:b0:3bf:e291:496c with SMTP id adf61e73a8af0-3c03e298475mr701865637.17.1783107565344;
        Fri, 03 Jul 2026 12:39:25 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f290b6bc2sm10065845eec.27.2026.07.03.12.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 12:39:24 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Paul Cercueil <paul@crapouillou.net>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Paul Kocialkowski <paulk@sys-base.io>,
        Linus Walleij <linusw@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Michal Simek <michal.simek@amd.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Eddie James <eajames@linux.ibm.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Joseph Liu <kwliu@nuvoton.com>, Marvin Lin <kflin@nuvoton.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Thierry Reding <thierry.reding@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Srinivas Kandagatla <srini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ge Gordon <gordon.ge@bst.ai>, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Peter Chen <peter.chen@cixtech.com>,
        Fugang Duan <fugang.duan@cixtech.com>
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
        BST Linux Kernel Upstream Group <bst-upstream@bstai.top>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        CIX Linux Kernel Upstream Group <cix-kernel-upstream@cixtech.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-media@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-mediatek@lists.infradead.org,
        kernel@collabora.com, linux-tegra@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        imx@lists.linux.dev, sound-open-firmware@alsa-project.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH 00/42] of: reserved_mem: Introduce devres helpers and convert drivers
Date: Sat,  4 Jul 2026 01:08:13 +0530
Message-ID: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE5OCBTYWx0ZWRfXyhRILZq9gsXi
 51cAwCHfl8Xgf5AXmwJIneTE+7opJdeHgPBUhwM4LGod5+V4MeYi5DXBTX5oFpFlpxF0Z0nwmRg
 u3C0+0ehyL+/513pBRJpLOK7pTGzc+Q=
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a480fee cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=c_1ikP4J58vCyc_cPHMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: GW4GucENOnsdXFlegO5r0lQplbEuYNag
X-Proofpoint-GUID: GW4GucENOnsdXFlegO5r0lQplbEuYNag
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE5OCBTYWx0ZWRfX9pP8uexwhKP4
 f+kpPE3VpCM0gZcqsErD8naDRYHGyMmPBL4HU/JsVTMLAKyMd6GOS1yDrXbjq50srnOe7xjSFQI
 byvG5UBDMBPzdB6n5XrVfF/cXYQOBqU643LCF83AQADbRAo6G2DzWPRKQhY1Uat/SwPjjcA/h47
 HCLuQR5AyEdqCdy19y7WoIh/l0qZ7rFuQ2rgvWhMLc9DpVR+gm2RqzbbQC79tjW5nakq8F2nVar
 qxYF6vE/S3C2P+isAZvqVIMR/Rho0Eh1qExE+XAzfoPm9lbE9ioG6jZid9CMk8Cnaf9eM2c8oq0
 2x2LTHnz7ZTVQVI0r5KnuD9qVGBTyIcL/sciFqoBcNaiDpcsp8u2Yzs3uo1ySg4avbWGzdFRuxE
 ZOlPCmzjaR9QVJur1Se2cyGG/Dsv7eJ6aVwDInDoUJdQMDPebJo77V6GDiTm0O9EPEWVz5iJGm1
 yv7coLvyVsEfIFgy4vA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 adultscore=0 clxscore=1011 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030198

Drivers using of_reserved_mem_device_init() and its variants must
manually call of_reserved_mem_device_release() in their remove and
error-unwind paths. This is repetitive boilerplate that is easy to
get wrong, and several drivers have open-coded the teardown
inconsistently or skipped it entirely, leading to dangling reserved
memory references.

This series introduces devres-managed wrappers —
devm_of_reserved_mem_device_init(), devm_of_reserved_mem_device_init_by_idx(),
and devm_of_reserved_mem_device_init_by_name() — that tie the reserved
memory region lifetime to the device, releasing it automatically on
unbind. The remaining 40 patches convert drivers across the drm, media,
ASoC, remoteproc, firmware, mmc, memory and misc subsystems to use these
helpers, yielding a net reduction of ~90 lines of boilerplate.

This series depends on  https://lore.kernel.org/lkml/20260703164457.4040457-1-mukesh.ojha@oss.qualcomm.com/

Konrad Dybcio (1):
  of: reserved_mem: Introduce devres-managed initialization functions

Mukesh Ojha (41):
  of: reserved_mem: Add devm_of_reserved_mem_device_init_by_name()
  firmware: qcom: scm: Use devm_of_reserved_mem_device_init()
  remoteproc: da8xx: Use devm_of_reserved_mem_device_init()
  remoteproc: keystone: Use devm_of_reserved_mem_device_init()
  media: synopsys: hdmirx: Use devm_of_reserved_mem_device_init()
  remoteproc: omap: Use devm_of_reserved_mem_device_init()
  drm: logicvc: Use devm_of_reserved_mem_device_init()
  drm: hdlcd: Use devm_of_reserved_mem_device_init()
  drm: pl111: Use devm_of_reserved_mem_device_init()
  remoteproc: mtk_scp: Use devm_of_reserved_mem_device_init()
  media: aspeed: Use devm_of_reserved_mem_device_init()
  media: nuvoton: npcm-video: Use devm_of_reserved_mem_device_init()
  memory: tegra210-emc: Use devm_of_reserved_mem_device_init_by_name()
  drm: komeda: Use devm_of_reserved_mem_device_init()
  drm: malidp: Use devm_of_reserved_mem_device_init()
  drm: ingenic: Use devm_of_reserved_mem_device_init()
  drm: kmb: Use devm_of_reserved_mem_device_init()
  drm: sun4i: Use devm_of_reserved_mem_device_init()
  drm: xlnx: zynqmp_dpsub: Use devm_of_reserved_mem_device_init()
  media: arm: mali-c55: Use devm_of_reserved_mem_device_init()
  media: mediatek: vpu: Use devm_of_reserved_mem_device_init()
  mmc: sdhci-of-bst: Use devm_of_reserved_mem_device_init_by_idx()
  remoteproc: ti_k3: Use devm_of_reserved_mem_device_init()
  ASoC: mediatek: mt8192: Use devm_of_reserved_mem_device_init()
  ASoC: mediatek: mt8196: Use devm_of_reserved_mem_device_init()
  ASoC: mediatek: mt8183: Use devm_of_reserved_mem_device_init()
  ASoC: mediatek: mt8189: Use devm_of_reserved_mem_device_init()
  ASoC: SOF: imx: Use devm_of_reserved_mem_device_init_by_name()
  staging: media: cedrus: Use devm_of_reserved_mem_device_init()
  ASoC: cix-ipbloq: Use devm_of_reserved_mem_device_init()
  drm: aspeed: Use devm_of_reserved_mem_device_init()
  drm: arcpgu: Use devm_of_reserved_mem_device_init()
  ASoC: mediatek: mt8173: Use devm_of_reserved_mem_device_init()
  ASoC: mediatek: mt8186: Use devm_of_reserved_mem_device_init()
  ASoC: mediatek: mt8188: Use devm_of_reserved_mem_device_init()
  ASoC: mediatek: mt8195: Use devm_of_reserved_mem_device_init()
  ASoC: SOF: mediatek: mt8186: Use devm_of_reserved_mem_device_init()
  ASoC: SOF: mediatek: mt8195: Use devm_of_reserved_mem_device_init()
  misc: fastrpc: Use devm_of_reserved_mem_device_init()
  ASoC: fsl: imx-rpmsg: Use devm_of_reserved_mem_device_init_by_idx()
  ASoC: sprd: Use devm_of_reserved_mem_device_init()

 drivers/firmware/qcom/qcom_scm.c              | 22 +++------
 .../gpu/drm/arm/display/komeda/komeda_dev.c   |  4 +-
 drivers/gpu/drm/arm/hdlcd_drv.c               |  6 +--
 drivers/gpu/drm/arm/malidp_drv.c              |  4 +-
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c       |  2 +-
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c     | 13 +-----
 drivers/gpu/drm/kmb/kmb_drv.c                 | 12 +----
 drivers/gpu/drm/logicvc/logicvc_drm.c         | 21 ++++-----
 drivers/gpu/drm/pl111/pl111_drv.c             |  4 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c             |  4 +-
 drivers/gpu/drm/tiny/arcpgu.c                 |  2 +-
 drivers/gpu/drm/xlnx/zynqmp_dpsub.c           |  4 +-
 .../platform/arm/mali-c55/mali-c55-core.c     | 12 ++---
 drivers/media/platform/aspeed/aspeed-video.c  | 12 ++---
 drivers/media/platform/mediatek/vpu/mtk_vpu.c |  3 +-
 drivers/media/platform/nuvoton/npcm-video.c   |  9 +---
 .../platform/synopsys/hdmirx/snps_hdmirx.c    | 16 +------
 drivers/memory/tegra/tegra210-emc-core.c      | 21 ++++-----
 drivers/misc/fastrpc.c                        |  2 +-
 drivers/mmc/host/sdhci-of-bst.c               |  7 +--
 drivers/of/of_reserved_mem.c                  | 41 +++++++++++++++++
 drivers/remoteproc/da8xx_remoteproc.c         | 10 +---
 drivers/remoteproc/keystone_remoteproc.c      | 16 +------
 drivers/remoteproc/mtk_scp.c                  |  3 +-
 drivers/remoteproc/omap_remoteproc.c          | 13 +-----
 drivers/remoteproc/ti_k3_common.c             | 13 +-----
 drivers/remoteproc/ti_k3_common.h             |  1 -
 .../staging/media/sunxi/cedrus/cedrus_hw.c    |  6 +--
 include/linux/of_reserved_mem.h               | 46 +++++++++++++++++++
 sound/hda/controllers/cix-ipbloq.c            |  2 +-
 sound/soc/fsl/imx-rpmsg.c                     |  2 +-
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c    |  2 +-
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c    | 13 +-----
 sound/soc/mediatek/mt8186/mt8186-afe-pcm.c    |  2 +-
 sound/soc/mediatek/mt8188/mt8188-afe-pcm.c    |  2 +-
 sound/soc/mediatek/mt8189/mt8189-afe-pcm.c    | 16 +------
 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c    | 11 +----
 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c    |  2 +-
 sound/soc/mediatek/mt8196/mt8196-afe-pcm.c    | 14 +-----
 sound/soc/sof/imx/imx-common.c                |  9 ++--
 sound/soc/sof/mediatek/mt8186/mt8186.c        |  2 +-
 sound/soc/sof/mediatek/mt8195/mt8195.c        |  2 +-
 sound/soc/sprd/sprd-pcm-dma.c                 |  3 +-
 43 files changed, 162 insertions(+), 249 deletions(-)

-- 
2.53.0


