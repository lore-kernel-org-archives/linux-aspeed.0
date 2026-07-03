Return-Path: <linux-aspeed+bounces-4352-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D54C44500
	for <linux-aspeed@archiver.kernel.org>; Sun,  5 Jul 2026 05:36:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtGSD4wHcz2ygn;
	Sun, 05 Jul 2026 15:36:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783111394;
	cv=none; b=CMm0p5T4Gfo9IKtkytdrSUifQNzRhLZNgrah9LrvVk1GQRN+RhbwhhDCJy79R5klI0ys8VFdwVq79WkjXKKQfQi9mLTRTWIIcNS0qt20TDBWzj20bA8sqNea7YJcXWhwTQs6WiT8zvDQNAqaJDxeLCxIyRiuf0rhiQZjBCb6ROV2E64FF8yWWfXnW00PG01TkI809+CcOUGToCEeRgRnFqKTDVSnjE17I+CDBgi4Q5/jp9GHJ+Dhs78WuahQkPfZzzdrdr6b+3m5WSj0O9KdgMC35+nFCBGp1Dyr85JrrJ3QUBZVhDQJhq4vuOYU0ok8LuGATrGybvmEUgOMdqAedQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783111394; c=relaxed/relaxed;
	bh=PGH0Mfb9t3dkT8UvMf5f1wosC3eQeF337EZxodGa2xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lmHJZt5SIAmL0LX4fXBpKHWekbWm1T9Nv1JuflJ7E8PrdcQCNv1rD8nt52j4vzC9DehQUJcShAIjNPe3qJT4KFSG2V6pWUaB+zn6f0j2yDJfTwPN893dv2M4rUopzP9ZMmOKf3KiKKda3n9cpvpO829AbKuyXJPVTYnCmdJZw0f9dm4PE95/ms5WM705f2W+wqH8nMg5c6yXzXTUxiOnzmuRhVEcRVeDjcXKGMRj+IpKDXhryYNPowDD6p8Gq+LxSWQpI3Of/AYPqfAQn9le7CLrEsGUs354sgeQvvjy1rje/TbQcae3QlbSdggznSu4E79WXyd7ddFjd+hTCMzm9Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HipLHZTm; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZyGWPIEN; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HipLHZTm;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZyGWPIEN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gsQgj5YgSz2xF8
	for <linux-aspeed@lists.ozlabs.org>; Sat, 04 Jul 2026 06:43:12 +1000 (AEST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663HibeS545676
	for <linux-aspeed@lists.ozlabs.org>; Fri, 3 Jul 2026 19:40:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=PGH0Mfb9t3d
	kT8UvMf5f1wosC3eQeF337EZxodGa2xo=; b=HipLHZTmLwrBQObeVsOGWExITfp
	t7/tVWx4vzKDtDPxgNwrOMMLEYbY4ozBpTauLC1kSTV/W7k1Qm0e12vRO+ogANBW
	NW0APmhU3sAdU2NrCqlWIoHmD0kU4SQGq4ljc6YwuMSM7GFhHObmCpJ+/+rhnKsQ
	INKlcMzloIbYPjrnEN/lLIpHGyWDH5yPXXSi8+KcBgoraO6K/MnRfB3UUkLILky6
	qTPqH4OVJXMwBZsrvWtdNjSsexZaz22Q5jADDCPONMxS+LjIGY3qz0KpGGSr3YaR
	wcrE60nfHX13IMBNYdT4V8pqcZ2+pD+AyngKR10muMKnOdEdCQYuLKpAovQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f682btqpk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Fri, 03 Jul 2026 19:40:15 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3810e5c5871so1379532a91.2
        for <linux-aspeed@lists.ozlabs.org>; Fri, 03 Jul 2026 12:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783107615; x=1783712415; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGH0Mfb9t3dkT8UvMf5f1wosC3eQeF337EZxodGa2xo=;
        b=ZyGWPIENd4PIUfJ6zR5SI4CzR3x1174iETlVinryevDL010FBcwwkNihWydjJFJ3t1
         XYvjpJPt+7ljY9w89dRS77svrGZMhvatZzcIO3NiDJHYKAnSBYnp2MeoTz7NvDIK2P6e
         Vwnj/8rOpdWOMbl6gW+anEBv855taGG37pknMxZ5ys9ezCQ302gQai2zk6R9Rk4S+SYJ
         cGRJqm7C6Is3vFXASYkWYH3dLdUuXpX5LHwR5PVuAnoQ5qgzOoUih3+/BFcdkZxHK2g4
         lESuFWgg6itLGg/PuJvDi3zSISmB+3ZBk0z/J6/LLCsJPuYUqsV6ew/93yST2Uk7gGhQ
         014g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783107615; x=1783712415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PGH0Mfb9t3dkT8UvMf5f1wosC3eQeF337EZxodGa2xo=;
        b=QUe9cYPQe9ZNrwSMO4FQn6N5SglY4Z+wSeWe6iRLNL44h36HwiSOfQvnGob1dKVPqV
         wJ08k3Gie7XKYd7bKu+Aq9T5a1e/vA30R2SXKnef4JWgmS9n9jQNdSmXYr3sANvPov6D
         CJITcSP0jsWJq6GEk+OW9EY348iLaHyTmcqMDQ69O2bpaRkI8gpouvZI/De4mqtIZU9Q
         zn5ejF5E2aLDQ4KCXTLXX2q406352TijSdEStL5fg1n3yw1gZWeK0WW0c92ezkCcOpqT
         BE+quSJ/X3rwYZN1VizQyz2Ea/TgDTQ65qWdTktcbsAeK4j3dRKNEgwqNY1pSXydfdgL
         cccw==
X-Forwarded-Encrypted: i=1; AHgh+RqA36/3SG/EZtX1ni1HBYmgGXmoh1yEANMJDWgK4n7JPv3A0xT4GEDvxmxIWTLEIs9qV479JYPJ2+DNoQY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxfM+s8L0lVYUOvAlH/tVSaUNNMzWSzORHwWNsQhzjZNOKQIh8a
	JX06EuGzK4X8QLq244zrWLnARggwGEbQM4EoC9A6gQCk0vnuMb8EU1KOpnJvThGk52k2R23YExi
	7qE91/HpE04/afE1qYplvajMWF2WxNADTH/GeOsdgUdHPHf3cMe3vQc6W/89FQP+AStO4
X-Gm-Gg: AfdE7cngq5Llb5LGfx2vdgrRVw9enhrEQjeBFd93TfDYTRDXG84kcjFmfwvkL5UQgga
	OVvXDaLGRxO192/3Ka0Bg5H/rioFEOGzsv1OtggUyuXjOavpPaGNm099ambIsTpm83igQuejNZ5
	4ShRAj2DHnIONoZpRhC+wCEA/Yx2l29jBEJ3/G8y7ll5e5Hr8VMOtNuRVLRErHFBa5DSRD/j4m7
	qSzbP346/uBqxbsRFeBIXJE4cg+UzxWjN20leMYyw/Bby+JF0u4sUjTu7dYqxNg+lLGMch7vaAh
	LibdZgb5iiL2P/epHSNEywjSrhqq6jm+xZf1FaQ3nUeoT4f1RDf/wlJmgHTYwHq37RRfk4d0K9i
	wvGnFj6vLvYN6R/w9CepXBMxXK+sswadaq+HVWQ==
X-Received: by 2002:a17:90b:4fd1:b0:37f:db06:2299 with SMTP id 98e67ed59e1d1-3829f0054e1mr764426a91.21.1783107614359;
        Fri, 03 Jul 2026 12:40:14 -0700 (PDT)
X-Received: by 2002:a17:90b:4fd1:b0:37f:db06:2299 with SMTP id 98e67ed59e1d1-3829f0054e1mr764330a91.21.1783107613641;
        Fri, 03 Jul 2026 12:40:13 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f290b6bc2sm10065845eec.27.2026.07.03.12.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 12:40:13 -0700 (PDT)
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
Subject: [PATCH 02/42] of: reserved_mem: Add devm_of_reserved_mem_device_init_by_name()
Date: Sat,  4 Jul 2026 01:08:15 +0530
Message-ID: <20260703193855.110619-3-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
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
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE5OCBTYWx0ZWRfX4wl6p17eR0jD
 iJLMEmxNMd/5Dkr9F7poxEAT4eWxY3yzImi0AB1b99N/YMSZ8Rv3I3Ax9wFeeltqU7xi8TeJaRn
 YCovy9RumM1E5P4ak/Mtm6QqdEJdPqodeosGIq1z3Lbuso13cZ3QZ6UHaDQ8SPZuQjbT6kuEJt9
 PhCojSrlqAT+Pajq1d+gBVNuZu1KLgsmZO5YOe4YoXtHDNCyhIyQtc8ojCHAWhmNySlWclnVLvm
 WIV+M3sSSPKu5txxhcWfzFX3CGI4NL52ztranEnB76XWYLr8lKEL1DnnR8+puYkfiCoMxZXbMNS
 6kDM98dO3tgEpaLd0VUFUtn29l8vRr7fmgbS5AcuJgi4xpwtNJE4btwTM3HLZ+p3yxRVSeFaf0O
 4n/lpW+dJXphMv5CBgTX2kA25ukTPS8eGdvF9u6m1vWU7L0NLdCMt2jEtvfI45gdqWA8yLg2tDW
 x78fM/GoTUCMGnWu9AQ==
X-Proofpoint-ORIG-GUID: Apq3g-oTfwTMnvZXYnou2XqJG8cHKL07
X-Authority-Analysis: v=2.4 cv=cc3iaHDM c=1 sm=1 tr=0 ts=6a48101f cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=K3bnyJ_z4bF7bLuR74EA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE5OCBTYWx0ZWRfXx2lC3+aKSL8x
 gEV6vTUj12sH9lUZHidC4b7SN3gIvtRUoBM6gFGkYa0VMc+kogSewkARBmJKYu2wWEckwHLRdni
 dTC+ZlQepzyNIcR1/FJ8t3qg6Mmc9g4=
X-Proofpoint-GUID: Apq3g-oTfwTMnvZXYnou2XqJG8cHKL07
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030198

Add a resource managed inline wrapper for
of_reserved_mem_device_init_by_name() to complement the existing
devm_of_reserved_mem_device_init_by_idx() and
devm_of_reserved_mem_device_init() helpers.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 include/linux/of_reserved_mem.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index b9fd78123d77..52aacdbf432c 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -133,4 +133,25 @@ static inline int devm_of_reserved_mem_device_init(struct device *dev)
 	return devm_of_reserved_mem_device_init_by_idx(dev, dev->of_node, 0);
 }
 
+/**
+ * devm_of_reserved_mem_device_init_by_name() - Resource managed of_reserved_mem_device_init_by_name
+ * @dev:	Pointer to the device to configure
+ * @np:		Pointer to the device node with 'memory-region' property
+ * @name:	Name of the selected memory region
+ *
+ * This is a resource managed version of of_reserved_mem_device_init_by_name().
+ * The reserved memory region will be released automatically when the device
+ * is unbound.
+ *
+ * Returns error code or zero on success.
+ */
+static inline int devm_of_reserved_mem_device_init_by_name(struct device *dev,
+							   struct device_node *np,
+							   const char *name)
+{
+	int idx = of_property_match_string(np, "memory-region-names", name);
+
+	return devm_of_reserved_mem_device_init_by_idx(dev, np, idx);
+}
+
 #endif /* __OF_RESERVED_MEM_H */
-- 
2.53.0


