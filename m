Return-Path: <linux-aspeed+bounces-4345-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7988C43458
	for <linux-aspeed@archiver.kernel.org>; Sun,  5 Jul 2026 05:33:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtGNj2dwVz2yYd;
	Sun, 05 Jul 2026 15:33:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783108270;
	cv=none; b=oydxpyTmE0Y9ak0CyHgjhGDcSvnD7Pdyo8fryQYFAk8Vm60NG0OsLtR6JGu88d6oE25DgfOakcx+IiiitJf3rx6F8iHSlPLd2MVY/xJli0tlMPwudkrxVIwkJrKxZtAOAysLplT7P1UYxJEUNmP9e0EFQAiwrwyPde5G0EvsBp8B+r30vpuGyP5MIgT00UpvgHDq2k9UyVRUWLv7bs2M8ph5WoRsd6R9Pcoacsj/5gorYNOKLp/cx198OmK9s+NViaWv8vADLWMvR/xV0EDMvUKa2eZi5S1fvPL+4QQSBlf2zTrh65HMomylva9jXPo9jRkZuBWW5nKEHKFN4rXnzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783108270; c=relaxed/relaxed;
	bh=pe8ST3hB3CCkwE4BX70lYuVQgCSkkHxWMCKtiPgz/Ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jkX+ODFZn8qux79mBN8p4c/Vslp0/jKtU7etRmwZt2WQwtvnReIqstZ++EHi00O5MuPpsx8QFGEp8FlEfeCas64GKyf1PcFZxsIM4tlG7kkLfcZ8uU+XL0h9tMpbWj9n0X09uxZhx2lEeJU56RdcJ/YKY8BkEDkduOpF0amXM+Pc5fJFOI7EsgSmkWaQFhbLHDyt8hC1rebV2OwmyL6+w0rff/364nInBsMUZzFWMMnBkrPFLoxM/JF3beKqF8ry4tCUZmwfX5yDDN64Pb4HhffFgU44QTIRAv2lAWcvnG5Ug5PVwoTE16x2ye4ow2VhXmvkx8PudMlQaUbRO2yWnA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=p7nQ7zZX; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NOlwnCyT; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=p7nQ7zZX;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NOlwnCyT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gsPWf0603z2xF8
	for <linux-aspeed@lists.ozlabs.org>; Sat, 04 Jul 2026 05:51:09 +1000 (AEST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663Hicd7685038
	for <linux-aspeed@lists.ozlabs.org>; Fri, 3 Jul 2026 19:51:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=pe8ST3hB3CC
	kwE4BX70lYuVQgCSkkHxWMCKtiPgz/Ew=; b=p7nQ7zZXx1dyH2mXz3LmtPkSnUd
	jisvgy2NTifLo08O3O54R98wx1vDjNj0Wc6nkxAI5QmcWaDX4R1xcGtW8a7qUW11
	pP1Tmm1qXYe0QSfC3Y/udjscZR+Ph2P+KwbQihalCCu0X5gayaM/FZiuNqhKC4dC
	bI5fBbUqwcvvYugwPT3aaoSQw4Y+2vA+YENnTjr5fTDu/vYApw3jocaRRE8EBwwD
	shcNAKkygkP0VARnjPMXCY1b3eOOzmUQ/fIJHpQK5JTNcblKvr+H9jiOiBxFD/XY
	k9QsTa+kZLp8Khy1haYPvPKdydK13icOw3hF3M3xr1GuNNJUog1AC7E7Twg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f64b5bsy7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Fri, 03 Jul 2026 19:51:08 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-37d4f23eb37so1718045a91.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 03 Jul 2026 12:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783108267; x=1783713067; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pe8ST3hB3CCkwE4BX70lYuVQgCSkkHxWMCKtiPgz/Ew=;
        b=NOlwnCyTk9L4OGLutVH8n3mDut4CT5JTSqrRP5oGHALIFq4l/Ut+als+b5ffTHek8M
         fpbOHoIkRLu7IkKO75GjdFwC+N+TTqTMjXlZ6GdDmP1juTrtHRni4sSn15iXkDcqd59U
         9FgvaYRSUCrKt/o6XwIrDPueJRMSXdY6wolJfJfCZrmP+vOUG1GrqEqa9dC31Ojy1K1H
         2MF1JMgNAfaLSSliQnqfQ6L1nyd4dqdEc5r/E8klLEkumVhm+9xHQ9f6Ii1QpkBaFKip
         LjMGknZyGJGCFGqHh+FMDQsVLIeEgNcYvcrZKlUEzzcS7oWeMdOaV7kW+kuatsmGekhR
         tH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783108267; x=1783713067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pe8ST3hB3CCkwE4BX70lYuVQgCSkkHxWMCKtiPgz/Ew=;
        b=jeUuh4QHqweR2lah15q61Cu4S77OJNHqqD6U3x6E9k1U2jM81LBXbA3JFmIaX8L8tO
         8RSm/oEQFN6K0AALKKip0cq696vG7pHDuBlHkMz0hdQ4dpl78IHRXXQz5WMb0tjt9Shp
         ndERQsK3myZpUHDJqYipl1HphfGE4HOH5ROKtaJMKpRDbpIkXUKOhXfze3a+6gdgknE5
         2iWFEPRaNZljxMppNhCPsKruR8vLuN8DWxl42K21VNK65yGvPOv0yRQMFevngJyKKRRV
         b88Uxmz94xa9M7VdNMl8EkX/60y39x02d13y4NZvcnzEqfuqAp4/wHId2rJVEmNJ7590
         hVcg==
X-Forwarded-Encrypted: i=1; AHgh+RomEKL6PQk3Pi5eFaE6zbsAmcLKdYUdAYjXQbGDj8YUbel819XtnVazgfrV7+115jTk2Ay4+3Z4k1fNfbU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzWKk9LKWL6HBeLBxUeYEZuUy0diG5LQOOr9y7d1AoFneh24i8o
	fRJq7BZElPZSJ52eOl0UzeRXrZe5t3aub4JrasXN7t7A+Z486BWQwToCJLSnvNVycikEDqrwVez
	RIu2eGT5OqfmESLbAnMEFMNsJY4hzv7jWaKVrL9X+C6ucrPaYWYMZZrVb18vy/8sMzPB/
X-Gm-Gg: AfdE7cnx9bjxF75D53c9cuLSluV0cP4clGpWLdk+xtcbRq9RgOsXGfO+Cz3PWfrkOMy
	GpHBvrjGVYRwahX7PLc6jvjteGw2mwaYOArrEO7jxZgPOAPhVKwlGQi5jCDU6qgdf+jdyfOoxky
	W3+7Kv77m2z3oXxQd/+0kYDD6QDJZ77owsk2JfpfCCEvdWT8DRK6Z3r7mYoCeo9OAgIqqnrz8Wo
	V3hr6Wfd4Y7WQcNzD1FjY7+4FH6G0dxlWrGCQsCSDt7giJeJHa8lAE3zQKXr54F941P4ehfd7Ba
	1JlqJCT6shgGl0AwtL5feB53BWROGAubcleF3d6FC2NpVe/sLBxZ/QBPuzybff46w7HbC/1s3AP
	10iGCBYZT7tlB77JdgiSK4ipZDjfL0vTj6ioiGw==
X-Received: by 2002:a17:90b:4d0f:b0:381:e73:3c2e with SMTP id 98e67ed59e1d1-3829f4e8432mr819396a91.24.1783108267277;
        Fri, 03 Jul 2026 12:51:07 -0700 (PDT)
X-Received: by 2002:a17:90b:4d0f:b0:381:e73:3c2e with SMTP id 98e67ed59e1d1-3829f4e8432mr819306a91.24.1783108266647;
        Fri, 03 Jul 2026 12:51:06 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f290b6bc2sm10065845eec.27.2026.07.03.12.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 12:51:06 -0700 (PDT)
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
Subject: [PATCH 29/42] ASoC: SOF: imx: Use devm_of_reserved_mem_device_init_by_name()
Date: Sat,  4 Jul 2026 01:08:42 +0530
Message-ID: <20260703193855.110619-30-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDIwMCBTYWx0ZWRfX473xCE1p3iNl
 Si3gDEiH6w+wltpi95h2PaM3MbdBu+7w+lVmq4+x9F4IUFVcBPkK2nMOPBojflmJoZlJoc2r2rg
 JVieSm27L9euStTmMMFt9I0pBM2IhUU=
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a4812ac cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=3WP4xAbIaamtf5A8kHQA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: VaKNGvQS66eJGsfos45i1rSk5ta2idwg
X-Proofpoint-GUID: VaKNGvQS66eJGsfos45i1rSk5ta2idwg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDIwMCBTYWx0ZWRfX/V+0vZ4i1RPa
 HCjnXB4M/BhnjfgGH70RCGIQxHzZETprr3j2bLIFt8H2EWrQWJIhQGODUAKd89STH6CiUp/cbGn
 IPqoAA7vXzvug/zFCCNcyKvXa3Xkr0PK8u7SWthXOA8SAH0gH0NXSLirL2JcRjotda3MbQ9qDad
 r+Wda9YYGhI0RqboRuPrcx8Mv4BeDcCxPHmM0BxDqoB2Rp5CbPUJheQVQDmqBE4SDKhdaep83Xe
 UHOjtnq97paPfShPP6npcBssWg9HVVPeGDz5o/O6iQ9de3OqFm23A0WCdN3Cd/7WiGx6tl4aB5d
 tWSIYq/HgjKTi/aDIUnj6xs/Cvam9tcSqo7hFiLwDgE16nqRQ4ZMKeHouCAAFGC5HcDiCfbor/L
 1sqky8hFmQetuQ9AROHmR+U+EApMSW9115eK0oeSfxBGVWWTSBrbmEKgH0ug5nNiaRQPUvzUGi+
 enMBp24p5iQ/1Dx2SmQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030200

Use the devres-managed devm_of_reserved_mem_device_init_by_name()
instead of the manual of_reserved_mem_device_init_by_name()/
of_reserved_mem_device_release() pair, letting the device resource
manager handle cleanup automatically.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 sound/soc/sof/imx/imx-common.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sof/imx/imx-common.c b/sound/soc/sof/imx/imx-common.c
index 7a03c8cc5dd4..29314022c11f 100644
--- a/sound/soc/sof/imx/imx-common.c
+++ b/sound/soc/sof/imx/imx-common.c
@@ -330,9 +330,6 @@ static void imx_unregister_action(void *data)
 	sdev = data;
 	common = sdev->pdata->hw_pdata;
 
-	if (get_chip_info(sdev)->has_dma_reserved)
-		of_reserved_mem_device_release(sdev->dev);
-
 	platform_device_unregister(common->ipc_dev);
 }
 
@@ -362,9 +359,9 @@ static int imx_probe(struct snd_sof_dev *sdev)
 				     "failed to create IPC device\n");
 
 	if (get_chip_info(sdev)->has_dma_reserved) {
-		ret = of_reserved_mem_device_init_by_name(sdev->dev,
-							  pdev->dev.of_node,
-							  "dma");
+		ret = devm_of_reserved_mem_device_init_by_name(sdev->dev,
+							       pdev->dev.of_node,
+							       "dma");
 		if (ret) {
 			platform_device_unregister(common->ipc_dev);
 
-- 
2.53.0


